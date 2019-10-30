const express = require('express');
const router = express.Router();
const upl = require('./uploadFile').upload;
const upload = upl('./public/users/');
const users = require('../controllers/users');


router.get('/', users.getUsers);
router.get('/:id', users.getUserById);
router.get('/tutor/:id', users.getPatientsByTutor);
router.put('/tutor/:id', users.unlinkPatient);
router.put('/voice/:id', users.changeAssistantVoice);
router.post('/signup', upload.single('userImage'), users.signUpUser);
router.post('/signin', users.signInUser);
router.delete('/:id', users.deleteUser);

module.exports = router;

