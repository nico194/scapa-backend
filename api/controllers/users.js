const { get, getById, insert, update, signIn, signUp, del } = require('./connection');

const getUsers = (req, res) => {
    get('users')
        .then( users => res.status(200).json(users) )
        .catch( err => { throw err });
}

const getUserById = (req, res) => {
    getById('users', parseInt(req.params.id))
        .then( users => res.status(200).json(users) )
        .catch( err => { throw err });
}

const getPatientsByTutor = (req, res) => {
    getById('users', parseInt(req.params.id), 'tutor_id')
        .then( users => res.status(200).json(users) )
        .catch( err => { throw err });
}

const unlinkPatient = (req, res) => {
    update('users', parseInt(req.params.id), req.body)
        .then( response => response ? res.status(200).json({ message: 'Unlink success'}) : res.status(500).json({ err : 'error'}))
        .catch( err => { throw err; })
}

const changeAssistantVoice = (req, res) => {
    update('users', parseInt(req.params.id), req.body)
        .then( response => response ? res.status(200).json({ message: 'Change voice assistant'}) : res.status(500).json({ err : 'error'}))
        .catch( err => { throw err; })
}

const signUpUser = async (req, res) => {
    console.log('type user', req.body.type_user)

    if(req.body.type_user === 'tutor' || req.body.type_user === 'admin') {
        signUp('users', req.body, req.file)
            .then( response => response ? res.status(200).json(response) : res.status(500).json({ err : 'error'}))
            .catch( err => console.log('error tutor', err));
    } else if( req.body.type_user === 'patient' ) {
        if(req.body.tutorEmail) {
            getById('users', req.body.tutorEmail, 'email')
                .then( tutor => {
                    const idTutor = tutor[0].id;
                    const user = {
                        email: req.body.email,
                        password: req.body.password,
                        name: req.body.name,
                        birthday: req.body.birthday,
                        voice: req.body.voice,
                        tutor_id: idTutor,
                        type_user: req.body.type_user
                    }
                    signUp('users', user, req.file)
                        .then( patient => {
                            const folder = {
                                patient_id: patient.id,
                                tutor_id : idTutor
                            }
                            insert('folders', folder)
                                .then( response => response ? res.status(200).json(patient) : res.status(200).json({ err : 'error'}))
                                .catch( err => console.log('error folder',err))
                        })
                        .catch( err => console.log('error user',err))
                        })
                .catch( err => console.log('error tutor',err))
        }else {
            signUp('users', req.body, req.file)
                .then( response => {
                    const folder = {
                        patient_id: response.id,
                    }
                    insert('folders', folder)
                        .then( response => response ? res.status(200).json(response) : res.status(500).json({ err : 'error'}))
                        .catch( err => console.log('error folder',err))
                })
                .catch( err => console.log('error user',err))
        }
    }   
}

const signInUser = (req, res) => {
    signIn('users', req.body)
        .then( response => response ? res.status(200).json(response) : res.status(500).json({ err : 'error'}))
        .catch( err => {throw err} );
}

const deleteUser = (req, res) => {
    del('users', req.params)
        .then( response => response ? res.status(200).json({ delete: 'success' }) : res.status(501).json({ delete: 'failure' }))
        .catch( err => { throw err });
}

module.exports = {
    getUsers,
    getUserById,
    getPatientsByTutor,
    unlinkPatient,
    changeAssistantVoice,
    signUpUser,
    signInUser,
    deleteUser
};
