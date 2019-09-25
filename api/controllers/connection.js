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
    console.log('Query: ', `SELECT ${columns} FROM ${entity} WHERE ${findBy} = $1`);
    return new Promise(function(resolve, reject){
        pool.query(`SELECT ${columns} FROM ${entity} WHERE ${findBy} = $1`, [id], (err, results) => {
            if(err) {
                reject(err);
            }
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
        pool.query(query, newBody, (err, results) => {
            if(err) {
                reject(err);
            }
            const response = {
                id: results.rows[0].id,
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

const del = (entity, id) => {
    if(entity === 'pictograms' || entity === 'tutors' || entity === 'patients') {
        getById(entity, id)
            .then( data => {
                fs.unlinkSync(data[0].image);
            })
            .catch(err => { throw err })
    }
    return new Promise(function(resolve, reject){
        pool.query(`DELETE FROM ${entity} WHERE id = $1`, [id], (err, result) => {
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