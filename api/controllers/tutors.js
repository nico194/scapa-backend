const { pool, get } = require('./connection');
const { signUp, signIn } = require('./auth');

const getTutors = (req, res) => {
    get('tutors')
        .then( tutors => res.status(200).json(tutors))
        .catch( err => { throw err});
}

const signUpTutor = async (req, res) => {
    const response = await signUp(pool, 'tutors', req.body, req.file);
    response ? res.status(200).json(response) : res.status(500).json({ err : 'error'});    
}

const signInTutor = async (req, res) => {
    const response = await signIn(pool, 'tutors', req.body);
    response ? res.status(200).json(response) : res.status(500).json({ err : 'error'});
}

module.exports = {
    getTutors,
    signUpTutor,
    signInTutor
};


