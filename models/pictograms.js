const conection = require('./conection');
const multer = require('multer');

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

var storage = multer.diskStorage({
    destination: (req, file, callback) => {
        callback(null, '/public/pictograms');
    },
    filename: (req, file, callback) => {
        callback(null, file.fieldname + "_" + Date.now() + file.originalname)
    }   
});

const createPictogram = (req, res) => {
    const { description, type, category_id } = req.body;
    const img = storage.fieldname;
    console.log(img)
    conection.query('INSERT INTO categories (description) values ($1)', [description], (error, result) => {
        if (error){
            throw error;
        }
        res.status(201).send(`Added Pictogram ${description}`);
    });
}

const updatePictogram = (req, res) => {
    const id = parseInt(req.params.id);
    const description = req.body.description;
    conection.query('UPDATE categories SET description = $1 WHERE id = $2', [description, id], (error, results) => {
        if (error)  {
            throw error;
        }
        res.status(200).send(`Updated Pictogram ${id}`);
    });
}

const deletePictogram = (req, res) => {
    const id = parseInt(req.params.id);
    conection.query('DELETE FROM pictograms WHERE id = $1', [id], (error, results) => {
        if (error) {
            throw error;
        }
        res.status(200).send(`Deleted Pictogram ${id}`)
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

