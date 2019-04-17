const conection = require('./conection');

const getCategories = (req, res) => {
    conection.query('SELECT * FROM categories', (error, results) => {
        if (error) {
          throw error
        }
        res.status(200).json(results.rows)
    })
}

const getCategoryById = (req, res) => {
    const id = parseInt(req.params.id);
    conection.query('SELECT * FROM categories WHERE id= $1 ', [id], (error, results) => {
        if (error) {
            throw error;
        }
        res.status(200).json(results.rows);
    });
}

const createCaterory = (req, res) => {
    const { description } = req.boby;
    conection.query('INSERT INTO categories (description) values ($1)', [description], (error, result) => {
        if (error){
            throw error;
        }
        res.status(201).send(`Added category ${description}`);
    });
}

const updateCategory = (req, res) => {
    const id = parseInt(req.params.id);
    const { description } = req.body;
    conection.query('UPDATE categories SET description = $1 WHERE id = $2', [description, id], (error, results) => {
        if (error)  {
            throw error;
        }
        res.status(200).send(`Updated category ${description}`);
    });
}

const deleteCategory = (req, res) => {
    const id = parseInt(req.params.id);
    conection.query('DELETE FROM categories WHERE id = $1', [id], (error, results) => {
        if (error) {
            throw error;
        }
        res.status(200).send(`Deleted category ${id}`)
    })
}



module.exports = {
    getCategories
}

