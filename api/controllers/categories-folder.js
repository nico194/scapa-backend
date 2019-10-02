const { get, insert, del } = require('./connection');

const getCategoriesFolder = (req, res) => {
    get('categories_folder')
        .then( categories => res.status(200).json(categories))
        .catch( err => { throw err });   
}

const createCategoriesInFolder = async (req, res) => {
    console.log('body', req.body)
    const idFolder = parseInt(req.body.idFolder);
    let categories = req.body.categories;
    console.log(categories, idFolder);
    for(let category of categories) {
        console.log(category)
        await insert('categories_folder',
            {
                folder_id: idFolder,
                category_id: category
            },
        );
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
    createCategoriesInFolder,
    deleteCategoriesInFolder
}

