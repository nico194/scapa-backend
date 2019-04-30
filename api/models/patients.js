const conection = require('./conection');
const bcrypt = require('bcrypt');

const getPatients = (req, res) => {
    conection.query('SELECT * FROM patients', (error, result) => {
        if (error) {
            throw error;
        }
        res.status(200).send(result.rows)
    });
}

const signUp = (req, res) => {
    const { email, password, name, birthday, voice, tutor_id } = req.body;
    const image = req.file.path;
    console.log('Body: ', req.body);
    console.log('File: ', req.file);
    conection.query('SELECT * FROM patients WHERE email = $1', [email], (error, result) => {
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
                    let query = '';
                    let array = []
                    if(tutor_id === undefined) {
                        array = [email, hash, name, birthday, image, voice];
                        query = 'INSERT INTO patients (email, password, name, birthday, image, voice) values ($1, $2, $3, $4, $5, $6)';
                    } else {
                        array = [email, hash, name, birthday, image, voice, tutor_id]
                        query = 'INSERT INTO patients (email, password, name, birthday, image, voice, tutor_id) values ($1, $2, $3, $4, $5, $6, $7)';
                    }
                    conection.query(query, array, (error, result) => {
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
                                image,
                                voice,
                                tutor_id: tutor_id !== undefined ? tutor_id : 'No hay tutor' 
                            }
                        });
                    });
                }
            });
            
        }
    });
    
}

module.exports = {
    getPatients,
    signUp
};
