const conection = require('./conection');
const bcrypt = require('bcrypt');

const getTutors = (req, res) => {
    conection.query('SELECT * FROM tutors', (error, result) => {
        if (error) {
            throw error;
        }
        res.status(200).send(result.rows)
    });
}

const signUp = (req, res) => {
    const { email, password, name, birthday } = req.body;
    const image = req.file.path;
    console.log('Body: ', req.body);
    console.log('File: ', req.file);
    conection.query('SELECT * FROM tutors WHERE email = $1', [email], (error, result) => {
        if (error) {
            throw error;
        }
        if(result.rows.length >= 1){
            return res.status(409).json({
                message: 'Mail exists'
            });
        } else {
            bcrypt.hash(password, 10, (err, hash) => {
                if (err) {
                    return res.status(500).json({
                        error: "Error hash" + err
                    })
                } else {
                    conection.query('INSERT INTO tutors (email, password, name, birthday, image) values ($1, $2, $3, $4, $5)', [email, hash, name, birthday, image], (error, result) => {
                        if (error){
                            throw error;
                        }
                        res.status(201).json({
                            created: 'success',
                            pictogram: {
                                email, 
                                hash, 
                                name, 
                                birthday, 
                                image
                            }
                        });
                    });
                }
            });
            
        }
    });
    
}

module.exports = {
    getTutors,
    signUp
};


