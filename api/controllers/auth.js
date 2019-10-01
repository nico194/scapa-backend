const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

const signUp = (connection, entity, body, file) => {
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
                        reject({error: "Error hash" + err });
                    } else {
                        newBody[1] = hash;
                        let query = `INSERT INTO ${entity} (${namesKeys}) values (${numbersKeys}) RETURNING id`;                        
                        connection.query(query, newBody, (error, results) => {
                            if (error){
                                reject('error insert', error);
                            }
                            resolve({
                                signup: 'success',
                                id: results.rows[0].id,
                                [entity]: newBody
                            });
                        });
                    }
                });
                    
            }
        });
    })
        
}

const signIn = (connection, entity, body, res) => {
    const { email, password } = body;
    console.log('Body: ', body)
    connection.query(`SELECT * FROM ${entity} WHERE email = $1`, [email], (error, results) => {
        if(error) {
            throw error;
        }
        if (results.rows.length < 1) {
            return res.status(404).json({
                message: 'Authentication Failed - Mail doesn\'t exsist'
            });
        }
        bcrypt.compare(password, results.rows[0].password, (err, login) => {
            if (err) {
                return res.status(404).json({
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
                return res.status(200).json({
                    message: 'Authentication Success',
                    token: token,
                    [entity]: results.rows[0]
                });
            } else {
                return res.status(404).json({
                    message: 'Authentication Failed - Password'
                });
            }    
        });    
    });
}

module.exports =  {
    signUp,
    signIn
}