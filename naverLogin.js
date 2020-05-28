var express = require('express');
var app = express();

app.set('view engine', 'pug'); 
app.set('/', path.join(__dirname,'/'));


var client_id = "";
var redirectURI = "http://192.168.0.2:3000/callback";
var state = "RAMDOM_STATE";

app.get('/naverlogin', function (req, res) {
    var api_url = 'https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=' + client_id + '&redirect_uri=' + redirectURI + '&state=' + state;
    res.writeHead(200, {'Content-Type': 'text/html;charset=utf-8'});
    res.end("<a href='"+ api_url + "'><img height='50' src='http://static.nid.naver.com/oauth/small_g_in.PNG'/></a>");
});
app.get('/callback', function (req, res) {
    var client_secret = '';
    code = req.query.code;
    state = req.query.state;
    api_url = 'https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&client_id='
    + client_id + '&client_secret=' + client_secret + '&redirect_uri=' + redirectURI + '&code=' + code + '&state=' + state;
    var request = require('request');
    var options = {
        url: api_url,
        headers: {'X-Naver-Client-Id':client_id, 'X-Naver-Client-Secret': client_secret}
    };
    request.get(options, function (error, response, body) {
    if (!error && response.statusCode == 200) {
        res.render("naverloginauth", {key:body['access_token']});
    } else {
        res.send("ERR");
        console.log('error = ' + response.statusCode);
    }
    });
});

app.listen(3000);
