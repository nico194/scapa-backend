const { get, getById, insert, update, del } = require('./connection');

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

const getCategoriesInFolder = async (req, res) => {
    const idFolder = await getById('folders', parseInt(req.params.id), 'pacient_id', 'id')[0];
    console.log('idFolder', idFolder)
    let categories = [];
    const categoriesId = await getById('categories_folder', idFolder , 'folder_id', 'category_id')
    for(const id of categoriesId){
        const category = await getById('categories', id.category_id, 'id', 'description');
        categories.push(category[0]);
    }
    res.status(200).json(categories);

}

const createCategory = (req, res) => {
    insert('categories', req.body)
        .then( response => response ? res.status(200).json({ insert: 'success', response: response }) : res.status(501).json({ insert: 'failure' }))
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
    getCategoriesInFolder,
    createCategory,
    updateCategory,
    deleteCategory    
}

