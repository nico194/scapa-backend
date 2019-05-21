const express = require('express');
const router = express.Router();
const categoriesInFolder = require('../controllers/categories-folder');

router.get('/', categoriesInFolder.getCategoriesFolder);
router.get('/:id', categoriesInFolder.getCategoriesInFolder);
router.post('/', categoriesInFolder.createCategoriesInFolder);
router.put('/:id', categoriesInFolder.updateCategoriesInFolder);
router.delete('/:id', categoriesInFolder.deleteCategoriesInFolder);

module.exports = router;