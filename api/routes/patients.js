const express = require('express');
const router = express.Router();
const upl = require('./uploadFile').upload;
const upload = upl('./public/patients/');
const patients = require('../controllers/patients');


router.get('/', patients.getPatients);
router.get('/:id', patients.getPatientsById);
router.get('/tutor/:id', patients.getPatientsByTutor);
router.put('/tutor/:id', patients.unlinkPatient);
router.post('/signup', upload.single('patientImage'), patients.signUpPatient);
router.post('/signin', patients.signInPatient);

module.exports = router;

