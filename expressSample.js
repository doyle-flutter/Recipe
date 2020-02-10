// Flutter X 생활코딩(Node.js/express) # 1

var express = require("express");
var app = express();

app.get("/", (req,res)=>{
    // res.send("기존 예제");
    res.json(
        [
            {
                'id' : 1,
                'name' : 'K'
            },
            {
                'id' : 2,
                'name' : 'S'
            },
        ]
    )
});

app.listen( 3000, (err) => console.log(3000) );
