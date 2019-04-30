const express = require('express');
const router = express.Router();
const upl = require('./uploadFile').upload;
const upload = upl('./public/pictograms/');
const pictograms = require('../models/pictograms');


router.get('/', pictograms.getPictograms);
router.get('/:id', pictograms.getPictogramsById);
//router.get('/pictograms/:id', pictograms.getPictogramsByCategoryId);
router.post('/', upload.single('pictogramImage'), pictograms.createPictogram);
router.put('/:id', pictograms.updatePictogram);
router.delete('/:id', pictograms.deletePictogram);

module.exports = router;