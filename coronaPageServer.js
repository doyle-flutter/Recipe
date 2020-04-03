// Flutter X 생활코딩(Node.js/MySQL) # 4 디자인 - 서버

var express = require("express");
var app = express();

app.get("/a", (req,res)=>{
    res.json(
        [
            {
                'id': 1,
                'date':"2020-02-11",
                'source':"0000",
                'country' :"KR",
                'infectedCount' : 1 
            },
            {
                'id': 2,
                'date':"2020-02-11",
                'source':"0000",
                'country' :"US",
                'infectedCount' : 1 
            },
            {
                'id': 3,
                'date':"2020-02-11",
                'source':"0000",
                'country' :"JP",
                'infectedCount' : 1 
            },
            {
                'id': 4,
                'date':"2020-02-11",
                'source':"0000",
                'country' :"CN",
                'infectedCount' : 1 
            },
            {
                'id': 5,
                'date':"2020-02-11",
                'source':"0000",
                'country' :"SP",
                'infectedCount' : 1 
            }
        ]
    );
});

app.listen( 3000, (err) => console.log(3000) );







