const { get, getById, insert, update, del } = require('./conection');

const getCategoriesFolder = (req, res) => {
    let categories = [];
    get('categories_folder')
        .then( results => categories = results )
        .catch( err => { throw err }); 
    res.status(200).json(categories);    
}

const getCategoriesInFolder = (req, res) => {
    let categories = []
    getById('categories_folder', req.params.id , 'folder_id')
        .then( results => categories = results )
        .catch( err => { throw err }); 
    res.status(200).json(categories);    
}

const createCategoriesInFolder = (req, res) => {
    const idFolder = req.body.folder_id;
    const categories = req.body.categories;
    console.log(categories);
    categories.forEach(idCategory => {
        insert('categories_folder', { folder_id: idFolder, category_id: idCategory })
            .then( response => response ? res.status(200).json({ insert: 'success' }) : res.status(501).json({ insert: 'failure' }))
            .catch( err => { throw err }); 
    })  
}

const updateCategoriesInFolder = (req, res) => {
    const idFolder = parseInt(req.params.id);
    const categories = req.body.categories
    categories.forEach( idCategory => {
        update('categories_folder', idFolder, { category_id: idCategory })
            .then( response => response ? res.status(200).json({ update: 'success' }) : res.status(501).json({ update: 'failure' }))
            .catch( err => { throw err });
    })
}

const deleteCategoriesInFolder = (req, res) => {
    del('categories_folder', parseInt(req.params.id));
}

module.exports = {
    getCategoriesFolder,
    getCategoriesInFolder,
    createCategoriesInFolder,
    updateCategoriesInFolder,
    deleteCategoriesInFolder
}

