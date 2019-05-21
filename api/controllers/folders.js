const { get , getById, insert, update, del} = require('./conection');
var url = require('url');

const getFolders = (req, res) => {
    get('folders')
        .then( folders => res.status(200).json(folders))
        .catch( err => { throw err });     
}

const getFoldersById = (req, res) => {    
    getById('folders', Object.keys(req.query)[0], Object.values(req.query)[0])
        .then( folder => res.status(200).json(folder))
        .catch( err => { throw err });
}

const createFolders = (req, res) => {
    insert('folders', req.body)
        .then( response => response ? res.status(200).json({ insert: 'success' }) : res.status(501).json({ insert: 'failure' }))
        .catch( err => { throw err });
}

const updateFolders = (req, res) => {
    update('folders', parseInt(req.params.id), req.body)
        .then( response => response ? res.status(200).json({ update: 'success' }) : res.status(501).json({ update: 'failure' }))
        .catch( err => { throw err });
}

const deleteFolders = (req, res) => {
    del('folders', parseInt(req.params.id))
        .then( response => response ? res.status(200).json({ delete: 'success' }) : res.status(501).json({ delete: 'failure' }))
        .catch( err => { throw err });
}

module.exports = {
    getFolders,
    getFoldersById,
    createFolders,
    updateFolders,
    deleteFolders    
}