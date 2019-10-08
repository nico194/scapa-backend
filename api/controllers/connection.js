const Pool = require('pg').Pool;
const fs = require('fs');
const pool = new Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'scapa-backend',
    password: '1234',
    port: 5432
});

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
    console.log(body)
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
    if(entity === 'pictograms' || entity === 'tutors' || entity === 'patients') {
        getById(entity, params)
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

const connection = {
    pool,
    get,
    getById,
    insert,
    update,
    del
}

module.exports = connection;