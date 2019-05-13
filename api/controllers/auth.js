const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

const signUp = (conection, entity, body, file, res) => {
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
        
    const newBoby = Object.values(body);

    if(file) {
        namesKeys += ', image';
        numbersKeys += `, $${number + 1}`;
        newBoby.push(file.path);
    }
        
    conection.query(`SELECT * FROM ${entity} WHERE email = $1`, [body.email], (error, result) => {
        if (error) {
            throw error;
        }
        if(result.rows.length >= 1){
            return res.status(409).json({
                message: 'Mail exists'
            });
        } else {
            bcrypt.hash(body.password, 10, (err, hash) => {
                if (err) {
                    return res.status(500).json({
                        error: "Error hash" + err
                    })
                } else {
                    newBody.password = hash;
                    let query = `INSERT INTO patients (${namesKeys}) values (${numbersKeys})`;                        
                    conection.query(query, newBoby, (error, result) => {
                        if (error){
                            throw error;
                        }
                        res.status(201).json({
                            signup: 'success',
                            patient: {
                                newBody
                            },
                            result
                        });
                    });
                }
            });
                
        }
    });    
}

const signIn = (conection, entity, body, res) => {
    const { email, password } = body;
    conection.query(`SELECT * FROM ${entity} WHERE email = $1`, [email], (error, results) => {
        if(error) {
            throw error;
        }
        if (results.rows.length < 1) {
            return res.status(404).json({
                message: 'Authentication Failed - Mail doesn\'t exsist'
            });
        }
        console.log("Body: ", results.rows[0].password);
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
                    token: token
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