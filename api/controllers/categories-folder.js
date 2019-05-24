const { get, getById, insert, update, del } = require('./conection');

const getCategoriesFolder = (req, res) => {
    get('categories_folder')
        .then( categories => res.status(200).json(categories))
        .catch( err => { throw err });   
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


const deleteCategoriesInFolder = (req, res) => {
    del('categories_folder', parseInt(req.params.id))
        .then( response => response ? res.status(200).json({ delete: 'success' }) : res.status(501).json({ delete: 'failure' }))
        .catch( err => { throw err });
}

module.exports = {
    getCategoriesFolder,
    getCategoriesInFolder,
    createCategoriesInFolder,
    deleteCategoriesInFolder
}

