import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FlaskApi extends StatefulWidget {
  @override
  _FlaskApiState createState() => _FlaskApiState();
}

class _FlaskApiState extends State<FlaskApi> {
  static const String GOORM_IO = "";
  var data;

  @override
  void initState() {
    Future.microtask(() async{
      var res = await http.get(GOORM_IO);
      data = res.body;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                  "https://flask.palletsprojects.com/en/1.1.x/_images/flask-logo.png",
                ) ,
                fit: BoxFit.fitWidth
            )
        ),
        padding: EdgeInsets.only(
          top: 300.0
        ),
        child: Center(
          child: Text(
            data == null ? "Loading ..." : this.data.toString(),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
                color: Colors.black
            ),
          ),
        ),
      ),
    );
  }
}
