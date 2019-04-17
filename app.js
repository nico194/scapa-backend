var express = require('express');
var bodyParser = require('body-parser');
const categories = require('./models/categories');


var app = express();
app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());

app.get('/categories', categories.getCategories);

app.listen(8000, function(){
    console.log('Escuchandooo puerto 8000')
})