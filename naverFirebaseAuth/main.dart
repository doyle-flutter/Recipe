// Doc : https://firebase.google.com/docs/reference/rest/auth#section-create-email-password

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FirebaseAuth extends StatefulWidget {
  @override
  _FirebaseAuthState createState() => _FirebaseAuthState();
}

class _FirebaseAuthState extends State<FirebaseAuth> {

  Future<void> _firebaseAuthRestReq() async{
    const String _endPoint = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=KEY";
    const Map<String, String> _header = {'Content-Type' : 'application/json'};
    const Map<String, String> _body = {"email":"abc@gmail.com","password":"a123456","returnSecureToken":'true'};
    final http.Response _res = await http.post(_endPoint,headers: _header,body: json.encode(_body));
    print(json.decode(_res.body));
    return;
  }

  Future<void> _firebaseAuthMyServer() async{
    http.Response _res = await http.get('http://127.0.0.1:3000/firebase2');
    print(json.decode(_res.body));
    return;
  }

  @override
  void initState() {
    Future(() async{
      // await _firebaseAuthRestReq();
      await _firebaseAuthMyServer();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text("Firebase Auth"),),);
}
