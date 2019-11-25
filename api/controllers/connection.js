const Pool = require('pg').Pool;
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const fs = require('fs');

const localConfigurarion = {
    user: 'postgres',
    host: 'localhost',
    database: 'scapa-backend',
    password: '1234',
    port: 5432
}

// const herokuConfigurarion = {
//     user: 'lizangklvfjvxw',
//     host: 'ec2-54-235-180-123.compute-1.amazonaws.com',
//     database: 'dc09u22c82s9et',
//     password: '53e97141f1fb8bf8afed76cd132509c7dacbfdf4e34c5d2318b351a6d5ae06e9',
//     port: 5432
// }

const pool = new Pool(localConfigurarion);
 
const get = (entity, columns = '*') => {
    return new Promise(function(resolve, reject){
        pool.query(`SELECT ${columns} FROM ${entity}`, (err, results) => {
            if(err) {
                reject(err);
            }
            resolve(results.rows);
        });
    });
}

const getById = (entity, id, findBy = 'id', columns = '*') => {
    console.log('Query: ', `SELECT ${columns} FROM ${entity} WHERE ${findBy} = $1`, id);
    return new Promise(function(resolve, reject){
        pool.query(`SELECT ${columns} FROM ${entity} WHERE ${findBy} = $1`, [id], (err, results) => {
            if(err) {
                reject(err);
            }
            console.log('get: ', results.rows)
            resolve(results.rows);
        });
    });
}

const insert = (entity, body, file) => {
    let first = true;
    let namesKeys = '';
    let numbersKeys = '';
    let number = 0;
    Object.keys(body).forEach( (name, index) => {
        number = index + 1;
        if (first) {
            first = false;
            namesKeys = name;
            numbersKeys = `$${number}`;
        } else {
            namesKeys += ', ' + name
            numbersKeys += `, $${number}`
        }
    });

    const newBody = Object.values(body);

    if(file) {
        namesKeys += ', image';
        numbersKeys += `, $${number + 1}`
        newBody.push(file.path);
    }

    console.log('new body: ', newBody)

    let query = `INSERT INTO ${entity} (${namesKeys}) values (${numbersKeys}) RETURNING id`;
    console.log('Insert Query: ', query);

    return new Promise(function(resolve, reject){
        pool.query(query, newBody, (err, result) => {
            if(err) {
                reject(err);
            }
            console.log('result', result)
            const response = {
                id: result.rows[0].id,
                path: file? file.path : ''
            }
            resolve(response);
        });
    });
}

const update = (entity, id, body, file) => {
    let first = true;
    let namesAndNumbersKeys = '';
    let number = 0;
    Object.keys(body).forEach( (name, index) => {
        number = index + 1;
        if (first) {
            first = false;
            namesAndNumbersKeys = `${name} = $${number}`;
        } else {
            namesAndNumbersKeys += `, ${name} = $${number}`;
        }
    });

    const newBody = Object.values(body);

    if(file) {
        namesAndNumbersKeys += `, image = $${number + 1}`;
        newBody.push(file.path);
    }

    newBody.push(id);

    console.log('new body: ', newBody)

    let query = `UPDATE ${entity} SET ${namesAndNumbersKeys} WHERE id = $${number + 1}`;
    console.log('Update Query: ', query);
    return new Promise(function(resolve, reject){
        pool.query(query, newBody, (err, result) => {
            if(err) {
                reject(err);
            }
            resolve(true);
        });
    });
}

const del = (entity, params) => {
    if(entity === 'pictograms' || entity === 'users') {
        getById(entity, params.id)
            .then( data => {
                fs.unlinkSync(data[0].image);
            })
            .catch(err => { throw err })
    }

    let conditions = '';
    let number = 0;
    let first = true;
    Object.keys(params).forEach((condition, index) => {
        number = index + 1;
        console.log(`${condition} = $${number}`)
        if (first) {
            first = false;
            conditions = `${condition} = $${number}`;
        } else {
            conditions += ` AND ${condition} = $${number}`;
        }
    })

    const query = `DELETE FROM ${entity} WHERE ${conditions}`;
    console.log('Query: ', query)
    console.log('values', Object.values(params));
    return new Promise(function(resolve, reject){
        pool.query(query, Object.values(params), (err, result) => {
            if(err) {
                reject(err);
            }
            resolve(true);
        });
    });
}

const signUp = (entity, body, file) => {
    console.log('Body: ', body)
    console.log('File: ', file)
    let first = true;
    let namesKeys = '';
    let numbersKeys = '';
    let number = 0;
    Object.keys(body).forEach( (name, index) => {
        number = index + 1;
        if (first) {
            first = false;
            namesKeys = name;
            numbersKeys = `$${number}`;
        } else {
            namesKeys += ', ' + name;
            numbersKeys += `, $${number}`;
        }
            
    });
        
    const newBody = Object.values(body);

    if(file) {
        namesKeys += ', image';
        numbersKeys += `, $${number + 1}`;
        newBody.push(file.path);
    }
    
    return new Promise( (resolve, reject) => {
        pool.query(`SELECT * FROM ${entity} WHERE email = $1`, [body.email], (error, result) => {
            if (error) {
                reject('error mail', error);
            }
            if(result.rows.length >= 1){
                resolve({ message: 'Mail exists' });
            } else {
                bcrypt.hash(body.password, 10, (err, hash) => {
                    if (err) {
                        resolve({error: "Error hash" + err });
                    } else {
                        const index = newBody.findIndex(pass => pass === body.password);
                        newBody[index] = hash;
                        console.log('newBody, index ',newBody, index)
                        let query = `INSERT INTO ${entity} (${namesKeys}) values (${numbersKeys}) RETURNING id`;                        
                        console.log('Query: ', query);
                        pool.query(query, newBody, (error, results) => {
                            if (error){
                                console.log('error insert', error)
                                reject('error insert', error);
                            }
                            console.log(results)
                            resolve({
                                signup: 'success',
                                id: results.rows[0].id,
                                path: file? file.path : '',
                                user: newBody
                            });
                        });
                    }
                });
                    
            }
        });
    })
        
}

const signIn = (entity, body) => {
    const { email, password } = body;
    console.log('Body: ', body)
    return new Promise((resolve, reject) => {
        pool.query(`SELECT * FROM ${entity} WHERE email = $1`, [email], (error, results) => {
            if(error) {
                reject(error);
            }
            if (results.rows.length === 0) {
                console.log('entro')
                resolve({
                    message: 'Authentication Failed - Mail doesn\'t exsist'
                });
            } else {
                console.log('results', results)
                bcrypt.compare(password, results.rows[0].password, (err, login) => {
                    if (err) {
                        resolve({
                            message: 'Authentication Failed - Error bcrypt'
                        });
                    }
                    if (login) {
                        const token = jwt.sign(
                            {
                                email: results.rows[0].email,
                                id: results.rows[0].id
                            },
                            'secret',
                            {
                                expiresIn: '1h'
                            }
                        );
                        resolve({
                            message: 'Authentication Success',
                            token: token,
                            user: results.rows[0]
                        });
                    } else {
                        resolve({
                            message: 'Authentication Failed - Password'
                        });
                    }    
                }); 
            }
        });
    })
    
}

const connection = {
    get,
    getById,
    insert,
    update,
    del,
    signUp,
    signIn,
}

module.exports = connection;