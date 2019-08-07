const express = require('express');
const router = express.Router();
const categoriesInFolder = require('../controllers/categories-folder');

router.get('/', categoriesInFolder.getCategoriesFolder);
router.post('/', categoriesInFolder.createCategoriesInFolder);
router.delete('/:id', categoriesInFolder.deleteCategoriesInFolder);

module.exports = router;