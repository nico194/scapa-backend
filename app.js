const PORT = process.env.PORT || 8000;
var express = require('express');
var bodyParser = require('body-parser');
const categories = require('./models/categories');
const pictograms = require('./models/pictograms');


var app = express();
app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());

app.get('/', function(req, res){
    res.status(200).send({Conectado: 'API en puerto: ' + PORT});    
});

app.get('/pictograms', pictograms.getPictograms);
app.get('/pictograms/:id', pictograms.getPictogramsById);
//app.get('/pictograms/:id', pictograms.getPictogramsByCategoryId);
app.post('/pictograms', pictograms.createPictogram);
app.put('/pictograms/:id', pictograms.updatePictogram);
app.delete('/pictograms/:id', pictograms.deletePictogram);

app.get('/categories', categories.getCategories);
app.get('/categories/:id', categories.getCategoryById);
app.post('/categories', categories.createCategory);
app.put('/categories/:id', categories.updateCategory);
app.delete('/categories/:id', categories.deleteCategory);

app.listen(PORT, function(){
    console.log('Escuchando puerto: ' + PORT)
})