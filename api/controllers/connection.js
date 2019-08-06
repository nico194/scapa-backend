const Pool = require('pg').Pool;
const pool = new Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'scapa-backend',
    password: 'nico',
    port: 5432
});

const get = (entity, columns) => {
    let col = columns || '*';
    return new Promise(function(resolve, reject){
        pool.query(`SELECT ${col} FROM ${entity}`, (err, results) => {
            if(err) {
                reject(err);
            }
            resolve(results.rows);
        }); 
    });
}

const getById = (entity, id, findBy, columns) => {
    let find = findBy || 'id';
    let col = columns || '*';
    console.log(find, id)
    return new Promise(function(resolve, reject){
        pool.query(`SELECT ${col} FROM ${entity} WHERE ${find} = $1`, [id], (err, results) => {
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
        
    const newBoby = Object.values(body);
    if(file) {
        namesKeys += ', image';
        numbersKeys += `, $${number + 1}`
        newBoby.push(file.path);
    }
    let query = `INSERT INTO ${entity} (${namesKeys}) values (${numbersKeys})`;   
    return new Promise(function(resolve, reject){
        pool.query(query, newBoby, (err, results) => {
            if(err) {
                reject(err);
            }
            console.log(results)
            resolve(true);
        }); 
    });   
}

const update = (entity, id, body, file) => {
    let first = true;
    let namesAndnumbersKeys = '';
    let number = 0;
    Object.keys(body).forEach( (name, index) => {
        number = index + 1;
        if (first) {
            first = false;
            namesAndnumbersKeys = `${name} = $${number}`;
        } else {
            namesAndnumbersKeys += `, ${name} = $${number}`;
        }
    });

    const newBody = Object.values(body);

    if(file) {
        namesAndnumbersKeys += `, image = $${number + 1}`;
        newBoby.push(file.path);
    }

    newBoby.push(id)

    let query = `UPDATE ${entity} SET ${namesAndnumbersKeys} WHERE id = $${number + 1}`;  
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