// Flutter X 생활코딩(Node.js/MySQL) # 2

var express = require("express");
var mysql = require('mysql');
var app = express();

var connection = mysql.createConnection({
    host     : 'localhost',
    user     : 'root',
    password : ’******',
    database : 'mydb',
  });
connection.connect();

app.get("/", (req,res)=>{
    connection.query('SELECT * FROM author', (err, result, field) => {
        return res.json(result);
    })
});

app.listen( 3000, (err) => console.log(3000) );
