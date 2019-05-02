const express = require('express');
const router = express.Router();
const upl = require('./uploadFile').upload;
const upload = upl('./public/tutors/');
const tutors = require('../models/tutors');


router.get('/', tutors.getTutors);
router.post('/signup', upload.single('tutorImage'), tutors.signUpTutor);
router.post('/signin', tutors.signInTutor);

module.exports = router;