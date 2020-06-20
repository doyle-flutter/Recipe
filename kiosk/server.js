var express = require('express'),
    app = express(),
    http = require('http').Server(app),
    io = require('socket.io')(http),
    mysql = require('mysql');

var connect = mysql.createConnection({
    user : "",
    password : '',
    database : ""
});
connect.connect();
app.all('/*', (req, res, next) => {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "X-Requested-With");
    next();
});
app.use(express.json());
app.use(express.urlencoded({extended:true}));

http.listen(3000, () => {});

app.get('/', (req, res) => res.sendFile("C:/Users/User/Desktop/kiosk/main.html"));
app.get('/admin', (req, res) =>  res.sendFile("C:/Users/User/Desktop/kiosk/webadmin.html"));
app.get('/imgs', (req,res) => {
    /*/
    use kiosk;

    CREATE TABLE img ( 
        id int AUTO_INCREMENT,
        src TEXT NOT NULL,
        PRIMARY Key(id)
    ) default character set utf8 collate utf8_general_ci;

    *EXPRESS
    INSERT INTO img(src) VALUES(?)

    *MYSQL
    INSERT INTO img(src) VALUES ("https://cdn.pixabay.com/photo/2020/03/07/11/54/the-fog-4909513__340.jpg");
    INSERT INTO img(src) VALUES ("https://cdn.pixabay.com/photo/2020/05/12/17/04/wind-turbine-5163993__480.jpg");
    INSERT INTO img(src) VALUES ("https://cdn.pixabay.com/photo/2020/06/09/15/16/brugge-5278796__480.jpg");
    /*/
    var sql = "SELECT * FROM img";
    return connect.query(sql, (err, result) => res.json(result));
});

app.post('/img/uploadimgurl',(req,res) => {
    var src = req.body['src'];
    var sql = "SELECT * FROM img";
    connect.query(sql, (err, result) => {
        if(err) return res.json(false);
        if(result.length == 3) return res.json(false);
        var sql = "INSERT INTO img(src) VALUES(?)";
        connect.query(sql, [src], (err, result) => {
            if(err) return res.json(false);
            return res.json(true);
        });
    });
});
app.post("/img/change/index/:select/:target", (req,res) => {
    var select = req.params.select;
    var target = req.params.target;
    var sql = "SELECT * FROM img WHERE id = ?";
    var updateSql = "UPDATE img WHERE id = ? VALUES(src) ?";
    // connect.query(sql, [select],);
    return res.status(200).json(true);
});
io.on('connection', (socket) => {
    socket.on('platformCheck', (data) => {
        console.log(`접속 환경 : ${data}`);
    });

    socket.on('onStart', (data) => {
        io.emit('wOnStart', data);
    });
    socket.on('onStop', (data) => {
    });
});

