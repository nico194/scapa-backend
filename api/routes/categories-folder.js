const express = require('express');
const router = express.Router();
const categoriesInFolder = require('../controllers/categories-folder');

router.get('/', categoriesInFolder.getCategoriesFolder);
router.post('/:id', categoriesInFolder.createCategoriesInFolder);
router.delete('/:patient/:category', categoriesInFolder.deleteCategoriesInFolder);

module.exports = router;