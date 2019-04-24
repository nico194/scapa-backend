const http = require('http');
const app = require('./app');
const PORT = process.env.PORT || 8000;

const server= http.createServer(app);

server.listen(PORT, function(){
    console.log('Escuchando puerto: ' + PORT)
})