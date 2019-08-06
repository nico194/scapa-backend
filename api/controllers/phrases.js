const { get , getById, insert, update, del} = require('./connection');

const getPhrases = (req, res) => {
    get('phrases', res);     
}

const createPhrases = (req, res) => {
    insert('phrases', req.body, res);
}

const updatePhrases = (req, res) => {
    update('phrases', req.params.id, req.body, res);
}

const deletePhrases = (req, res) => {
    del('phrases', req.params.id, res);
}

module.exports = {
    getPhrases,
    getPhrasesByIdPacient,
    createPhrases,
    updatePhrases,
    deletePhrases    
}