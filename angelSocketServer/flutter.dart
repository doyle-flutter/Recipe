import 'package:angel_websocket/flutter.dart';
import 'package:flutter/material.dart';

class AngelSocket extends StatefulWidget {
  @override
  _AngelSocketState createState() => _AngelSocketState();
}

class _AngelSocketState extends State<AngelSocket> {
  static const String _WS = "ws://127.0.0.1:3000/ws";
  static const String _WS_PATH = "http://127.0.01:3000/ws2";
  WebSockets app;
  String angelData;

  @override
  void initState() {
    Future.microtask(()async{
      app = WebSockets(_WS);
      await app.connect();
      app.on['fromServer'].listen((event) {
        if(!mounted) return;
        setState(() {
          angelData = event.data.toString();
        });
      });
    });
    super.initState();
  }

  @override
  void dispose(){
    app?.logout();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Angel",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 20.0),),
            Text("Socket.IO"),
            Container(
              padding: EdgeInsets.all(20.0),
              margin: EdgeInsets.only(top: 20.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey)
              ),
              child: Text( angelData == null ? "Loading ..." : angelData)
            ),
            RaisedButton(
              child: Text("Socket : Send Data"),
              onPressed: () async => await app.get(_WS_PATH,headers: {}),
            )
          ],
        )
      ),
    );
  }
}
