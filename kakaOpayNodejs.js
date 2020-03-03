var express = require('express');
var app = express();

app.use(express.json());

// http://MyIP:MyPort/kakaopayment
app.get('/kakaopayment', (req, res) => {
    res.send(`<h1>종료해주세요</h1>`)
});

app.listen(3000, () => { console.log('3000')});
