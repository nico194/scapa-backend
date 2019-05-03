const Pool = require('pg').Pool;
const pool = new Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'scapa-backend',
    password: '1234',
    port: 5432
});

const get = (entity) => {
    pool.query(`SELECT * FROM ${entity}`, (err, results) => {
        if(err) {
            throw err
        }
        return results.rows;
    });    
}

const getById = (entity, id) => {
    pool.query(`SELECT * FROM ${entity} WHERE id = $1`, [id], (err, results) => {
        if(err) {
            throw err
        }
        return results.rows;
    }); 
}

const insert = (body) => {
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
    let query = `INSERT INTO patients (${namesKeys}) values (${numbersKeys})`;                        
    pool.query(query, newBoby, (error, result) => {
        if (error){
            throw error;
        }
        return true;
    });
}

const update = (entity, id, body) => {
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
        return true;
    });
}

const del = (entity, id) => {
    pool.query(`DELETE FROM ${entity} WHERE id = $1`, [id], (err, results) => {
        if(err) {
            throw err
        }
        return true;
    }); 
}

module.exports = {
    pool,
    get,
    getById,
    insert,
    update,
    del
};