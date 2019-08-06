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

const getCategoriesByFolderId = (req, res) => {
    getById('categories_folder', parseInt(req.params.id) , 'folder_id', 'category_id')
        .then( categoriesInFolder => {
            console.log(categoriesInFolder);
            let categories = [];            
            do {
                Object.values(categoriesInFolder).forEach( category => {
                    getById('categories', category.category_id)
                        .then( category => {
                            categories.push(category[0])
                        })
                        .catch( err => { throw err });
                });
                console.log(categories);                
            } while (categoriesInFolder.lenght === categories.length);  
            return categories;
        })
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
    getCategoriesByFolderId,
    createCategory,
    updateCategory,
    deleteCategory    
}

