const { get, getById, insert, update, del } = require('./connection');

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

const createCategoriesInFolder = async (req, res) => {
    const idFolder = parseInt(req.body.folder_id);
    let categories = req.body.categories;
    console.log(categories, idFolder);
    for(let category of categories) {
        console.log('Category: ', category)
        const a = await insert('categories_folder',
            {
                folder_id: idFolder,
                category_id: category
            },
        );
        console.log('Await', a);
    }
    res.status(200).json({insert: 'succsess'})
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

