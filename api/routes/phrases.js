const express = require('express');
const router = express.Router();
const phrases = require('../controllers/phrases');

router.get('/', phrases.getPhrases);
router.post('/', phrases.createPhrases);
router.put('/:id', phrases.updatePhrases);
router.delete('/:id', phrases.deletePhrases);

module.exports = router;