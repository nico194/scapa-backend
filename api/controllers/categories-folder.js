const { get, getById, insert, del } = require('./connection');

const getCategoriesFolder = (req, res) => {
    get('categories_folder')
        .then( categories => res.status(200).json(categories))
        .catch( err => { throw err });   
}

const createCategoriesInFolder = async (req, res) => {
    console.log('body', req.body)
    const folder = await getById('folders', parseInt(req.params.id), 'patient_id', 'id');
    const idFolder = folder[0].id;
    let categories = req.body.categories;
    console.log('add categories: ', categories)
    let newCategories = [];
    console.log(categories, idFolder);
    for(let category of categories) {
        console.log(category)
        const response = await insert('categories_folder',
            {
                folder_id: idFolder,
                category_id: category
            },
        );
        const categoryAdded = await getById('categories', category)
        newCategories.push(categoryAdded[0]);
    }
    res.status(201).json({insert: 'success', categories: newCategories})
}


const deleteCategoriesInFolder = async (req, res) => {
    const idFolder = await getById('folders', req.params.patient, 'patient_id', 'id');
    const params = {
        'folder_id': idFolder[0].id,
        'category_id': req.params.category
    }
    del('categories_folder', params)
        .then( response => response ? res.status(200).json({ 'delete': 'success'}) : res.status(500).json({ err: 'error'}))
        .catch( err => { throw err });
}

module.exports = {
    getCategoriesFolder,
    createCategoriesInFolder,
    deleteCategoriesInFolder
}

