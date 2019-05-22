const { get, getById, insert, update, del } = require('./conection');

const getCategories = (req, res) => {
    get('categories')
        .then( categories => res.status(200).json(categories))
        .catch( err => { throw err }); 
}

const getCategoryById = (req, res) => {
    getById('categories', parseInt(req.params.id))
        .then( categories => res.status(200).json(categories))
        .catch( err => { throw err });
}

const createCategory = (req, res) => {
    insert('categories', req.body)
        .then( response => response ? res.status(200).json({ insert: 'success' }) : res.status(501).json({ insert: 'failure' }))
        .catch( err => { throw err });
}

const updateCategory = (req, res) => {
    update('categories', parseInt(req.params.id), req.body)
        .then( response => response ? res.status(200).json({ update: 'success' }) : res.status(501).json({ update: 'failure' }))
        .catch( err => { throw err });
}

const deleteCategory = (req, res) => {
    del('categories', parseInt(req.params.id))
        .then( response => response ? res.status(200).json({ delete: 'success' }) : res.status(501).json({ delete: 'failure' }))
        .catch( err => { throw err });
}

module.exports = {
    getCategories,
    getCategoryById,
    createCategory,
    updateCategory,
    deleteCategory    
}

