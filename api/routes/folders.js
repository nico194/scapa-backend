const express = require('express');
const router = express.Router();
const folders = require('../controllers/folders');

router.get('/', folders.getFolders);
router.get('/:id', folders.getFoldersById);
router.post('/', folders.createFolders);
router.put('/:id', folders.updateFolders);
router.delete('/:id', folders.deleteFolders);

module.exports = router;