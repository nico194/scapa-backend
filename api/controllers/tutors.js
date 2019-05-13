const conection = require('./conection');
const { signUp, signIn } = require('./auth');

const getTutors = (req, res) => {
    conection.query('SELECT * FROM tutors', (error, result) => {
        if (error) {
            throw error;
        }
        res.status(200).send(result.rows)
    });
}

const signUpTutor = (req, res) => {
    signUp(conection, 'tutors', req.body, req.file, res);    
}

const signInTutor = (req, res) => {
    signIn(conection, 'tutors', req.body, res);
}

module.exports = {
    getTutors,
    signUpTutor,
    signInTutor
};


