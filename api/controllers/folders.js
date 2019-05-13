const { get , getById, insert, update, del} = require('./conection');

const getFolders = (req, res) => {
    get('folders', res);     
}

const getFoldersByIdPacient = (req, res) => {
    getById('folders', req.params.id, res, 'pacient_id');
}

const createFolders = (req, res) => {
    insert('folders', req.body, res);
}

const updateFolders = (req, res) => {
    update('folders', req.params.id, req.body, res);
}

const deleteFolders = (req, res) => {
    del('folders', req.params.id, res);
}

module.exports = {
    getFolders,
    getFoldersByIdPacient,
    createFolders,
    updateFolders,
    deleteFolders    
}