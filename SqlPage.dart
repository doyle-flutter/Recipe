// Flutter X 생활코딩(Node.js/express) # 2

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SqlPage extends StatefulWidget {
  @override
  _SqlPageState createState() => _SqlPageState();
}

class _SqlPageState extends State<SqlPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetch(),
        builder: (context, snap){
          if(!snap.hasData) return CircularProgressIndicator();
          return ListView.builder(
            itemCount: snap.data.length,
            itemBuilder:(context, int index) => ListTile(
              leading: Text(snap.data[index]['id'].toString()),
              title: Text("Name : ${snap.data[index]['name'].toString()}"),
              trailing: IconButton(
                icon: Icon(Icons.keyboard_arrow_right),
                onPressed: () => print(snap.data[index]['name'].toString()),
              ),
            )
          );
        },
      ),
    );
  }

  fetch() async{
    var res = await http.get('http://192.0.0.0:3000');
    return json.decode(res.body);
  }
}
