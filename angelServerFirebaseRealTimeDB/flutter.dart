// main.dart 별도

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AngelRealTime extends StatefulWidget {
  @override
  _AngelRealTimeState createState() => _AngelRealTimeState();
}

class _AngelRealTimeState extends State<AngelRealTime> {

  static const String _url = 'http://127.0.0.1:3000/firebase/db';

  TextEditingController _readTctPath;
  TextEditingController _createTctPath;
  TextEditingController _createTctValue;
  TextEditingController _updateTctPath;
  TextEditingController _updateTctValue;
  TextEditingController _deleteTctPath;

  @override
  void initState() {
    _readTctPath = new TextEditingController(text: "");
    _createTctPath = new TextEditingController(text: "");
    _createTctValue = new TextEditingController(text: "");
    _updateTctPath = new TextEditingController(text: "");
    _updateTctValue = new TextEditingController(text: "");
    _deleteTctPath = new TextEditingController(text: "");
    super.initState();
  }

  @override
  void dispose() {
    _readTctPath?.dispose();
    _createTctPath?.dispose();
    _createTctValue?.dispose();
    _updateTctPath?.dispose();
    _updateTctValue?.dispose();
    _deleteTctPath?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter & Angel & Firebase"),
        centerTitle: true,
        backgroundColor: Colors.orange[900],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(child: Text("1. READ"),margin: EdgeInsets.symmetric(vertical: 10.0),),
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text("READ : Path"),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width/2.0,
                          child: TextField(
                            controller: _readTctPath,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: InputBorder.none,
                              hintText: "path"
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    RaisedButton(
                      child: Text("READ"),
                      onPressed: () async{
                        if(_readTctPath.text.isEmpty) return;
                        http.Response _res = await http.get("$_url/${_readTctPath.text}");
                        String _utfValue;
                        var result;
                        if(_res.bodyBytes.isEmpty){
                           result = null;
                        }
                        else{
                          _utfValue = utf8.decode(_res.bodyBytes);
                          result = json.decode(_utfValue);
                        }
                        await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Firebase : ${result.toString()}"),
                          )
                        );
                      },
                    )
                  ],
                ),
              ),
              Container(child: Text("2. Create"),margin: EdgeInsets.symmetric(vertical: 10.0),),
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text("Create : Path"),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width/2.0,
                          child: TextField(
                            controller: _createTctPath,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: InputBorder.none,
                                hintText: "path"
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text("Create : Value"),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width/2.0,
                          child: TextField(
                            controller: _createTctValue,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: InputBorder.none,
                                hintText: "value"
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    RaisedButton(
                      child: Text("Create"),
                      onPressed: () async{
                        if(_createTctPath.text.isEmpty || _createTctValue.text.isEmpty) return;
                        http.Response _res = await http.get("$_url/create/${_createTctPath.text}/${_createTctValue.text}");
                        String _utfValue;
                        var result;
                        if(_res.bodyBytes.isEmpty){
                          result = null;
                        }
                        else{
                          _utfValue = utf8.decode(_res.bodyBytes);
                          result = json.decode(_utfValue);
                        }
                        await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Firebase : ${result.toString()}"),
                          )
                        );
                      },
                    )
                  ],
                ),
              ),
              Container(child: Text("3. Update(Patch)"),margin: EdgeInsets.symmetric(vertical: 10.0),),
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text("Patch : Path"),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width/2.0,
                          child: TextField(
                            controller: _updateTctPath,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: InputBorder.none,
                              hintText: "path"
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text("Patch : Value"),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width/2.0,
                          child: TextField(
                            controller: _updateTctValue,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: InputBorder.none,
                                hintText: "value"
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    RaisedButton(
                      child: Text("Update"),
                      onPressed: () async{
                        if(_updateTctPath.text.isEmpty || _updateTctValue.text.isEmpty) return;
                        http.Response _res = await http.get("$_url/update/${_updateTctPath.text}/${_updateTctValue.text}");
                        String _utfValue;
                        var result;
                        if(_res.bodyBytes.isEmpty){
                          result = null;
                        }
                        else{
                          _utfValue = utf8.decode(_res.bodyBytes);
                          result = json.decode(_utfValue);
                        }
                        await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Firebase : ${result.toString()}"),
                            )
                        );
                      },
                    )
                  ],
                ),
              ),
              Container(child: Text("4. delete"),margin: EdgeInsets.symmetric(vertical: 10.0),),
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text("Patch : Path"),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width/2.0,
                          child: TextField(
                            controller: _deleteTctPath,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: InputBorder.none,
                                hintText: "path"
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    RaisedButton(
                      child: Text("Delete"),
                      onPressed: () async{
                        if(_deleteTctPath.text.isEmpty) return;
                        http.Response _res = await http.get("$_url/delete/${_deleteTctPath.text}");
                        String _utfValue;
                        var result;
                        if(_res.bodyBytes.isEmpty){
                          result = null;
                        }
                        else{
                          _utfValue = utf8.decode(_res.bodyBytes);
                          result = json.decode(_utfValue);
                        }
                        await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Firebase : ${result.toString()}"),
                            )
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
