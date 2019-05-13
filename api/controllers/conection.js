const Pool = require('pg').Pool;
const pool = new Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'scapa-backend',
    password: '1234',
    port: 5432
});

const get = (entity, res) => {
    pool.query(`SELECT * FROM ${entity}`, (err, results) => {
        if(err) {
            throw err
        }
        res.status(200).json(results.rows);
    });
}

const getById = (entity, id, res, findBy) => {
    let find = findBy || 'id';
    pool.query(`SELECT * FROM ${entity} WHERE ${find} = $1`, [id], (err, results) => {
        if(err) {
            throw err
        }
        res.status(200).json(results.rows);
    }); 
}

const insert = (entity, body, res, file) => {
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
    pool.query(query, newBoby, (error, result) => {
        if (error){
            throw error;
        }
        res.status(200).json({
            insert: 'success'
        });
    });
}

const update = (entity, id, body, res) => {
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

    const newBoby = Object.values(body);

    if(file) {
        namesAndnumbersKeys += `, image = $${number + 1}`;
        newBoby.push(file.path);
    }

    newBoby.push(id)

    let query = `UPDATE ${entity} SET ${namesAndnumbersKeys} WHERE id = $${number + 1}`;                        
    pool.query(query, newBoby, (error, result) => {
        if (error){
            throw error;
        }
        res.status(200).json({
            update: 'success'
        });
    });
}

const del = (entity, id, res) => {
    pool.query(`DELETE FROM ${entity} WHERE id = $1`, [id], (err, results) => {
        if(err) {
            throw err
        }
        res.status(200).json({
            delete: 'success'
        });
    }); 
}

const conection = {
    pool,
    get,
    getById,
    insert,
    update,
    del
}

module.exports = conection;