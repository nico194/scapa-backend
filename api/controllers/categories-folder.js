const { get, getById, insert, update, del } = require('./conection');

const getCategoriesInFolder = (req, res) => {
    get('categoriesfolder', res);     
}

const createCategoriesInFolder = (req, res) => {
    const idFolder = req.body.idfolder;
    let categories = req.body.categories;
    console.log(categories);
    categories.forEach(idCategory => {
        insert('categories_folder', 
            {
                folder_id: idFolder, 
                category_id: idCategory
            }, 
            res
        );
    })  
}

const updateCategoriesInFolder = (req, res) => {
    update('categories_folder', req.params.id, req.body, res);
}

const deleteCategoriesInFolder = (req, res) => {
    del('categories_folder', req.params.id, res);
}

module.exports = {
    getCategoriesInFolder,
    createCategoriesInFolder,
    updateCategoriesInFolder,
    deleteCategoriesInFolder
}

