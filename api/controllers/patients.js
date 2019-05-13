const conection = require('./conection');
const { signUp, signIn } = require('./auth');
const { get } = require('../controllers/conection');

const getPatients = (req, res) => {
    get('patients', res);
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
