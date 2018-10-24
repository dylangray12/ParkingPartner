var mysql = require('mysql');
var http = require('http'); // http protocol
var express = require('express'); // web server
var bodyParser = require('body-parser');

var connection = mysql.createConnection({
    host     : 'localhost',
    user     : 'dev',
    password : 'hawklets1',
    database : 'ParkingPartner'
});

connection.connect();

connection.query('SELECT 1 + 1 AS solution', function (error, results, fields) {
    if (error) throw error;
    console.log('Successful connection. 1 + 1 = ', results[0].solution);
});

// web server
var app = express();

// use middlewares
app.use(bodyParser.json());
app.use(allowCrossDomain);

app.get('/hello', function(req, res) {
    res.status(200).send('hello');
});

app.post('/message', function(req, res) {
    console.log(req);
    connection.query({
        sql : 'INSERT INTO messages(timestamp, sender, recipient, message) VALUES(NOW(), ?, ?, ?)',
        values : [ req.body.sender, req.body.recipient, req.body.message ]
    }, function(error, results) {
        if(error) throw error;
        res.status(201).send(results);
    });
});

app.listen(3000, function() {
    console.log('listening at http://localhost:3000');
});

/**
* Middleware:
* allows cross domain requests
* ends preflight checks
*/
function allowCrossDomain(req, res, next) {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'PUT, GET, POST, DELETE');
    res.setHeader('Access-Control-Allow-Headers', 'Authorization');

    // end pre flights
    if (req.method === 'OPTIONS') {
        res.writeHead(204);
        res.end();
    } else {
        next();
    }
}