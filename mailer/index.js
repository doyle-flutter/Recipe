// nodemailer : https://www.npmjs.com/package/nodemailer

const express = require('express'),
    app = express(),
    mailer = require('nodemailer'),
    port = 3000,
    MyPass = '';

app.listen(port);
app.use(express.json());
app.use(express.urlencoded({extended: false}));

app.get('/',(req,res) => res.json("true"));
app.post('/mail', (req, res) => {
    try{
        let data = req.body['txt'];
        if(data == undefined) return res.json(false);
        let transporter = mailer.createTransport({
            service: 'gmail',
            auth: {
                user: '',
                pass: MyPass,
            },
        });
        transporter.sendMail({
            from: '',
            to: "",
            subject: `Hello ✔ - ${data}`,
            text: `Hello world? - ${data}`,
        },(err, info) => {
            if (err) {
                console.log(err);
                res.json(false);
            } else {
                console.log('Email sent: ' + info.response);
                res.json(true);
            }
        });
    }
    catch(e){
        res.json(false);
    }
});


