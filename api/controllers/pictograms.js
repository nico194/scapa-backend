const { get, getById, insert, update, del } = require('./conection');

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
    const id = parseInt(req.params.id);
    conection.query('SELECT * FROM pictograms WHERE category_id = $1', [id], (error, results) => {
        if (error) {
            throw error;
        }
        res.status(200).send(results.rows);
    });
}

const createPictogram = (req, res) => {
    insert('pictograms', req.body, req.file)
        .then( response => response ? res.status(200).json({ insert: 'success' }) : res.status(501).json({ insert: 'failure' }))
        .catch( err => { throw err });
}

const updatePictogram = (req, res) => {
    update('pictograms', parseInt(req.params.id), req.body, req.file)
        .then( response => response ? res.status(200).json({ update: 'success' }) : res.status(501).json({ update: 'failure' }))
        .catch( err => { throw err });
    
}

const deletePictogram = (req, res) => {
    del('pictograms', parseInt(req.params.id))
        .then( response => response ? res.status(200).json({ delete: 'success' }) : res.status(501).json({ delete: 'failure' }))
        .catch( err => { throw err });
}

module.exports = {
    getPictograms,
    getPictogramsById,
    getPictogramsByCategoryId,
    createPictogram,
    updatePictogram,
    deletePictogram
}

