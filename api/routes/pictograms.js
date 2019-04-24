const express = require('express');
const router = express.Router();

const multer = require('multer');
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, './public/pictograms');
    },
    filename: (req, file, cb) => {
        cb(null, new Date().toISOString() + file.originalname);
    }
});

const fileFilter = (req, file, cb) => {
    if(file.mimetype === 'image/jpg' || file.mimetype === 'image/jpeg' || file.mimetype === 'image/png'){
        cb(null, true);
    } else {
        cb(null, false);
    }
};

const upload = multer({
    storage: storage,
    limits: {
        fileSize: 10264 * 1024 * 5
    },
    fileFilter: fileFilter
});

const pictograms = require('../models/pictograms');


router.get('/', pictograms.getPictograms);
router.get('/:id', pictograms.getPictogramsById);
//router.get('/pictograms/:id', pictograms.getPictogramsByCategoryId);
router.post('/', upload.single('pictogramImage'), pictograms.createPictogram);
router.put('/:id', pictograms.updatePictogram);
router.delete('/:id', pictograms.deletePictogram);

module.exports = router;