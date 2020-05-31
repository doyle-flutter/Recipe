const http = require('http');
const fs = require('fs');
const https = require('https');
const path = require('path');

var key = fs.readFileSync(path.join(__dirname,'/server.key'));
var cert = fs.readFileSync(path.join(__dirname, '/server.cert'));

const express = require('express');
const app = express();

app.get('/', (req,res) => {
    return res.send("Hi!");
})
app.get('/rtc', function(req, res){
    return res.sendFile(path.join(__dirname,'/rtc.html'));
});

const httpServer = http.createServer(app);
const httpsServer = https.createServer({key: key, cert: cert }, app);

httpServer.listen(3000, () => { console.log('listening on 3000') });
httpsServer.listen(443, () => { console.log('listening on 443') });

const io = require('socket.io')(httpsServer);
io.sockets.on('connection',socket=>{
    function log() {
        let array = ['Message from server:'];
        array.push.apply(array,arguments);
        socket.emit('log',array);
    }

    socket.on('message',message=>{
        log('Client said : ' ,message);
        socket.broadcast.emit('message',message);
    });

    socket.on('create or join',room=>{
        let clientsInRoom = io.sockets.adapter.rooms[room];
        let numClients = clientsInRoom ? Object.keys(clientsInRoom.sockets).length : 0;
        log('Room ' + room + ' now has ' + numClients + ' client(s)');
        
        if(numClients === 0){
            console.log('create room!');
            socket.join(room);
            log('Client ID ' + socket.id + ' created room ' + room);
            socket.emit('created',room,socket.id);
        }
        else if(numClients===1){
            console.log('join room!');
            log('Client Id' + socket.id + 'joined room' + room);
            io.sockets.in(room).emit('join',room);
            socket.join(room);
            socket.emit('joined',room,socket.id);
            io.sockets.in(room).emit('ready');
        }else{
            socket.emit('full',room);
        }
    });
});
