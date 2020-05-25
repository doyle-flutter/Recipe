var express = require('express');
var cors = require('cors');
var app = express();
var path = require('path');
var admin = require('firebase-admin');
var serviceAccount = require("./aps.json");
var FCM = require('fcm-node');

app.use(cors({ origin: true }));
app.set('view engine', 'pug'); 
app.set('/', path.join(__dirname,'/'));


admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
});

app.get('/', function (req, res) {
    var key = "req.query['code']";
    res.render( 'pp', {name:key});
});

app.get('/auth', (req, res) => {
    var key = req.query['code'];
    res.render("kakaologinauth", {key});
});

var registrationToken = "";
app.get("/sended", async (req,res) => {
    var ff = new FCM("");
    var push_data = {
        notification: {
            title: "Hello Node",
            body: "Node.",
            sound : "default",
        },
        priority: "high",
        restricted_package_name: "com.doyle.",
        data: {},
        to: registrationToken,
    };

    ff.send(push_data, function(err, response) {
    if (err) {
        console.error('Push메시지 발송에 실패했습니다.');
        console.error(err);
        return;
    }
 
    console.log('Push메시지가 발송되었습니다.');
    console.log(response);
});
    return res.send(`Push메시지가 발송되었습니다.`);
});

app.get("/sended/:id", async (req,res) => {
    var id = req.params.id;
    var setID = "";
    console.log("*-*******"+id);
    var message = {
        notification:{
            title:"FCM TEST for ADMIN",
            body:`${id===null?setID:id}TTTEEESSST`
        },
        data: {
            title: '테스팅id',
            body: '보내기 테스팅'
        },
        token: registrationToken
    };

    admin.messaging().send(message)
    .then((response) => {
        console.log('Successfully sent message:', response);
    })
    .catch((error) => {
        console.log('Error sending message:', error);
    });
    return res.send(`33 ${req.params.id}`);
});

app.listen(3000);
