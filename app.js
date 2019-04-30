const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const morgan = require('morgan');

const categoriesRouter = require('./api/routes/categories');
const pictogramsRouter = require('./api/routes/pictograms');
const tutorsRouter = require('./api/routes/tutors');
const patientsRouter = require('./api/routes/patients');

app.use('/public', express.static('public'));
app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());
app.use(morgan('dev'));

app.use((req, res, next)=> {
    res.header('Access-Control-Allow-Origin', '*');
    res.header(
        'Access-Control-Allow-Headers',
        'Origin, X-Requested-With, Content-Type, Accept, Authorization"'
    );
    if ( req.method === 'OPTIONS') {
        res.header('Access-Control-Allow-Methods', 'PUT, PATH, POST, DELETE,GET');
        return res.status(200).json({}); 
    }
    next(); 
});

app.get('/', function(req, res){
    res.status(200).send({Conectado: 'API corriendo'});
});

app.use('/categories', categoriesRouter);
app.use('/pictograms', pictogramsRouter);
app.use('/tutors', tutorsRouter);
app.use('/patients', patientsRouter);


app.use((req, res, next) =>{
    const err = new Error('Not found');
    err.status = 404;
    next(err);
});

app.use((err, req, res, next) => {
    res.status(err.status || 500);
    res.json({
        error: {
            message: err.message
        }
    });
});

module.exports = app;