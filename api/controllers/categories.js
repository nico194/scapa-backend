const { get, getById, insert, update, del } = require('./conection');

const getCategories = (req, res) => {
    get('categories', res); 
}

const getCategoryById = (req, res) => {
    getById('categories', req.params.id, res);
}

const createCategory = (req, res) => {
    insert('categories', req.body, res);
}

const updateCategory = (req, res) => {
    update('categories', req.params.id, req.body, res);
}

const deleteCategory = (req, res) => {
    del('categories', req.params.id, res);
}

module.exports = {
    getCategories,
    getCategoryById,
    createCategory,
    updateCategory,
    deleteCategory    
}

