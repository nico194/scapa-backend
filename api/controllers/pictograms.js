const { get, getById, insert, update, del } = require('./connection');

const getPictograms = (req, res) => {
    get('pictograms')
        .then( pictograms => res.status(200).json(pictograms))
        .catch( err => { throw err });  
}

const getPictogramsById = (req, res) => {
    getById('pictograms', req.params.id)
        .then( pictograms => res.status(200).json(pictograms))
        .catch( err => { throw err });
}

const getPictogramsByCategoryId = (req, res) => {
    getById('pictograms', parseInt(req.params.id), 'category_id')
        .then( pictograms => res.status(200).json(pictograms))
        .catch( err => { throw err });
}

const getPictogramsByPatientId = async (req, res) => {
    const folders = await getById('folders', parseInt(req.params.id), 'patient_id', 'id');
    const idFolder = folders[0].id;
    console.log('idFolder', idFolder)
    let categories = [];
    const categoriesIds = await getById('categories_folder', idFolder , 'folder_id', 'category_id')
    for(const id of categoriesIds){
        const category = await getById('categories', id.category_id, 'id');
        categories.push(category[0]);
    }
    let pictograms = [];
    for(const category of categories){
        const pictogramsInCategory = await getById('pictograms', category.id, 'category_id');
        pictograms = pictograms.concat(pictogramsInCategory);
    }
    res.status(200).json(pictograms)
}

const createPictogram = (req, res) => {
    insert('pictograms', req.body, req.file)
        .then( response => response ? res.status(200).json({ insert: 'success', response }) : res.status(501).json({ insert: 'failure' }))
        .catch( err => { throw err });
}

const updatePictogram = (req, res) => {
    update('pictograms', parseInt(req.params.id), req.body, req.file)
        .then( response => response ? res.status(200).json({ update: 'success' }) : res.status(501).json({ update: 'failure' }))
        .catch( err => { throw err });
    
}

const deletePictogram = (req, res) => {
    del('pictograms', req.params)
        .then( response => response ? res.status(200).json({ delete: 'success' }) : res.status(501).json({ delete: 'failure' }))
        .catch( err => { throw err });
}

module.exports = {
    getPictograms,
    getPictogramsById,
    getPictogramsByCategoryId,
    getPictogramsByPatientId,
    createPictogram,
    updatePictogram,
    deletePictogram
}

