const { get, getById, insert, update, del } = require('./conection');

const getPictograms = (req, res) => {
    get('pictograms', res);  
}

const getPictogramsById = (req, res) => {
    getById('pictograms', req.params.id, res);
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
    insert('pictograms', req.body, res, req.file);
}

const updatePictogram = (req, res) => {
    const id = parseInt(req.params.id);
    const description = req.body.description;
    conection.query('UPDATE pictograms SET description = $1 WHERE id = $2', [description, id], (error, results) => {
        if (error)  {
            throw error;
        }
        res.status(200).json({
            updated: 'success',
            id
        });
    });
}

const deletePictogram = (req, res) => {
    const id = parseInt(req.params.id);
    conection.query('DELETE FROM pictograms WHERE id = $1', [id], (error, results) => {
        if (error) {
            throw error;
        }
        res.status(200).json({
            deleted: 'success',
            id
        });
    })
}

module.exports = {
    getPictograms,
    getPictogramsById,
    getPictogramsByCategoryId,
    createPictogram,
    updatePictogram,
    deletePictogram
}

