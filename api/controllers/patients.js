const { signUp, signIn } = require('./auth');
const { pool, get, getById, insert, update } = require('../controllers/connection');

const getPatients = (req, res) => {
    get('patients')
        .then( patients => res.status(200).json(patients) )
        .catch( err => { throw err });
}

const getPatientsById = (req, res) => {
    getById('patients', parseInt(req.params.id))
        .then( patients => res.status(200).json(patients) )
        .catch( err => { throw err });
}

const getPatientsByTutor = (req, res) => {
    getById('patients', parseInt(req.params.id), 'tutor_id')
        .then( patients => res.status(200).json(patients) )
        .catch( err => { throw err });
}

const unlinkPatient = (req, res) => {
    update('patients', parseInt(req.params.id), req.body)
        .then( response => response ? res.status(200).json({ message: 'Unlink success'}) : res.status(500).json({ err : 'error'}))
        .catch( err => { throw err; })
}

const signUpPatient =  (req, res) => {
    if(req.body.tutorEmail) {
        getById('tutors', req.body.tutorEmail, 'email')
            .then( response => {
                const tutorId = response[0].id
                const patient = {
                    email: req.body.email,
                    password: req.body.password,
                    name: req.body.name,
                    birthday: req.body.birthday,
                    voice: req.body.voice,
                    tutor_id: tutorId
                }
                signUp(pool, 'patients', patient, req.file)
                    .then( patient => {
                        const folder = {
                            patient_id: patient.id,
                            tutor_id : tutorId
                        }
                        insert('folders', folder)
                            .then( response => response ? res.status(200).json(patient) : res.status(500).json({ err : 'error'}))
                            .catch( err => console.log('error folder',err))
                    })
                    .catch( err => console.log('error user',err))
            })
            .catch( err => console.log('error tutor',err))
    } else {
        signUp(pool, 'patients', req.body, req.file)
            .then( response => {
                const folder = {
                    patient_id: response.id,
                    tutor_id : 8
                }
                insert('folders', folder)
                    .then( response => response ? res.status(200).json(response) : res.status(500).json({ err : 'error'}))
                    .catch( err => console.log('error folder',err))
            })
            .catch( err => console.log('error user',err))
    }
    
}

const signInPatient = (req, res) => {
    signIn(pool, 'patients', req.body)
        .then( response => response ? res.status(200).json(response) : res.status(500).json({ err : 'error'}))
        .catch( err => {throw err} );
}

module.exports = {
    getPatients,
    getPatientsById,
    getPatientsByTutor,
    unlinkPatient,
    signUpPatient,
    signInPatient,
};
