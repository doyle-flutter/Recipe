void main() async{
  var app = new Angel();
  var http = new AngelHttp(app);
  var ws = AngelWebSocket(app, sendErrors: !app.isProduction);

  app.get('/ws', ws.handleRequest);
  app.get('/ws2', (req,res) => ws.batchEvent(WebSocketEvent(eventName: 'fromServer', data: "fromServer222")));
  app.fallback((req, res) => throw AngelHttpException.notFound());

  ws.onConnection.listen((socket) {
    print("CONN");
    var req = socket.request;
    ws.batchEvent(WebSocketEvent(eventName: 'fromServer', data: "fromServer"));
    socket.on['sign_in'].listen((data) {
      socket.send('signed_in', "user");
      ws.batchEvent(WebSocketEvent(eventName: 'user_joined', data: "user_joined"));
    });
    socket.on['message'].listen((data) {
      ws.batchEvent(WebSocketEvent(eventName: 'message', data: "message"));
    });
    socket.onClose.listen((_) {
      ws.batchEvent(WebSocketEvent(eventName: 'user_left', data: "user"));
    });
  });
  
// ...
  await http.startServer('127.0.0.1', 3000);
}
