const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

const signUp = (connection, entity, body, file) => {
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
        connection.query(`SELECT * FROM ${entity} WHERE email = $1`, [body.email], (error, result) => {
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
                        console.log('newBody, index ',body, index)
                        let query = `INSERT INTO ${entity} (${namesKeys}) values (${numbersKeys}) RETURNING id`;                        
                        console.log('Query: ', query);
                        connection.query(query, newBody, (error, results) => {
                            if (error){
                                reject('error insert', error);
                            }
                            resolve({
                                signup: 'success',
                                id: results.rows[0].id,
                                path: file.path,
                                [entity]: newBody
                            });
                        });
                    }
                });
                    
            }
        });
    })
        
}

const signIn = (connection, entity, body) => {
    const { email, password } = body;
    console.log('Body: ', body)
    return new Promise((resolve, reject) => {
        connection.query(`SELECT * FROM ${entity} WHERE email = $1`, [email], (error, results) => {
            if(error) {
                reject(error);
            }
            if (results.rows.length < 1) {
                resolve({
                    message: 'Authentication Failed - Mail doesn\'t exsist'
                });
            }
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
                        [entity]: results.rows[0]
                    });
                } else {
                    resolve({
                        message: 'Authentication Failed - Password'
                    });
                }    
            });    
        });
    })
    
}

module.exports =  {
    signUp,
    signIn
}