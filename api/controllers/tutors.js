const { pool, get } = require('./connection');
const { signUp, signIn } = require('./auth');

const getTutors = (req, res) => {
    get('tutors')
        .then( tutors => res.status(200).json(tutors))
        .catch( err => { throw err});
}

const signUpTutor = (req, res) => {
    signUp(pool, 'tutors', req.body, req.file, res);    
}

const signInTutor = (req, res) => {
    console.log('request',req.body)
    signIn(pool, 'tutors', req.body, res);
}

module.exports = {
    getTutors,
    signUpTutor,
    signInTutor
};


