const express = require('express');
const router = express.Router();
const upl = require('./uploadFile').upload;
const upload = upl('./public/patients/');
const patients = require('../models/patients');


router.get('/', patients.getPatients);
router.post('/signup', upload.single('patientImage'), patients.signUp);

module.exports = router;

