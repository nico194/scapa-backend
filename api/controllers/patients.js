const { signUp, signIn } = require('./auth');
const { pool, get } = require('../controllers/conection');

const getPatients = (req, res) => {
    get('patients')
        .then( patients => res.status(200).json(patients) )
        .catch( err => { throw err });
}

const signUpPatient = (req, res) => {
    signUp(pool, 'patients', req.body, req.file, res);    
}

const signInPatient = (req, res) => {
    signIn(pool, 'patients', req.body, res);
}

module.exports = {
    getPatients,
    signUpPatient,
    signInPatient
};
