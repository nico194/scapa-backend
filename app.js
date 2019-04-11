var express = require('express');
var bodyParser = require('body-parser');

var app = express();
app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());

app.get('/hola/:id/:nombre', function(req, res){
    console.log(req.params);
    res.send(`Hola ${req.params.id} ${req.params.nombre}`)
});

app.listen(8000, function(){
    console.log('Escuchandooo puerto 8000')
})