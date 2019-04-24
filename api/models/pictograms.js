const conection = require('./conection');

const getPictograms = (req, res) => {
    conection.query('SELECT * FROM pictograms', (error, results) => {
        if (error) {
            throw error;
        }
        res.status(200).send(results.rows)
    });
}

const getPictogramsById = (req, res) => {
    const id = parseInt(req.params.id);
    conection.query('SELECT * FROM pictograms WHERE id = $1', [id], (error, results) => {
        if (error) {
            throw error;
        }
        res.status(200).send(results.rows);
    });
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
    const { description, type, category_id } = req.body;
    const image = req.file.path;
    console.log(img)
    conection.query('INSERT INTO pictograms (description, type, image, category_id) values ($1, $2, $3, $4)', [description, type, image, category_id], (error, result) => {
        if (error){
            throw error;
        }
        res.status(201).json({
            created: 'success',
            pictogram: {
                description,
                type,
                image,
                category_id
            }
        });
    });
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

