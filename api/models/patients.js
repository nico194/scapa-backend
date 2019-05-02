const conection = require('./conection');
const { signUp, signIn } = require('./auth');

const getPatients = (req, res) => {
    conection.query('SELECT * FROM patients', (error, result) => {
        if (error) {
            throw error;
        }
        res.status(200).send(result.rows)
    });
}

const signUpPatient = (req, res) => {
    signUp(conection, 'patients', req.body, req.file, res);    
}

const signInPatient = (req, res) => {
    signIn(conection, 'patients', req.body, res);
}

module.exports = {
    getPatients,
    signUpPatient,
    signInPatient
};
