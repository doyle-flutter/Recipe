import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(
  MaterialApp(
    home: MyApp(),
  )
);

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  var data;

  @override
  void initState() {
    Future.microtask(() async{
      var res = await http.get("http://gogos.run.goorm.io/hello/Flutter");
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
              "https://golang.org/lib/godoc/images/home-gopher.png",
            ) ,
            fit: BoxFit.cover
          )
        ),
        child: Center(
          child: Text(
            data == null ? "Loading ..." : this.data.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
              color: Color.fromRGBO(0, 125, 156, 1.0)
            ),
          ),
        ),
      ),
    );
  }
}
