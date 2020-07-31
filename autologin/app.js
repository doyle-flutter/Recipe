var express = require('express');
var app = express();

app.use(express.json());
app.use(express.urlencoded({extended:false}));

app.get('/',(req,res) => res.send("Hi !"));
app.post('/login', (req,res) => {
    var headerToken = req.headers['token'];
    var id = req.body['id'];
    var pw = req.body['pw'];
    if(id === undefined || pw === undefined) return res.json(false);
    if(id !== "qwe" || pw !== "123") return res.json(false); // id & token Check + Validation Logic
    if(headerToken === undefined) return res.json(false);
    if(headerToken !== "1") return res.json(false); // DB Token Check Logic
    return res.json(true);
});

app.listen(3000);
