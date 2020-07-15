import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AngelFcm extends StatefulWidget {
  @override
  _AngelFcmState createState() => _AngelFcmState();
}

class _AngelFcmState extends State<AngelFcm> {
  static const String _URL = "http://127.0.0.1:3000";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text("A\n(Left Android)"),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () async{
                    await http.get("$_URL/fcm/1");
                    return;
                  },
                ),
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () async{
                    await http.get("$_URL/fcm/2");
                    return;
                  },
                ),
              ],
            )
          ),
          Container(
            child: Text("B\n(Right Android)"),
          ),
        ],
      ),
    );
  }
}
