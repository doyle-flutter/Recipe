// 패키지 : socket_io_client: ^0.9.10

// Android 설정
// <uses-permission android:name="android.permission.INTERNET" />
// <application ...... android:usesCleartextTraffic="true">

// IOS 설정 별도 작업 없습니다

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  IO.Socket socket;

  @override
  void initState() {
    socket = IO.io('http://localhost:3000/',<String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          icon: Icon(Icons.data_usage),
          onPressed: (){
            socket.emit("send_message", "VALUE");
          },
        ),
      ),
    );
  }
}


/// Node.JS

// var app = require('express')(); 
// var http = require('http').Server(app); 
// var io = require('socket.io')(http); 

// app.get('/', function(req, res){ 
//     res.send("hi"); 
// }); 
// // app.get("/chat",(req,res) =>{
// //     res.sendFile('../index.html');
// // });


// io.on('connection', function(socket){ 
//     socket.on('send_message', function(msg){ 
//         console.log(msg)
//         io.emit('receive_message', msg); }
//     ); 
// });


// http.listen(3000, function(){ console.log('listening on *:3000'); });
