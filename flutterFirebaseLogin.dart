import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(MaterialApp(home: MyApp(),));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text("로그인"),
          onPressed: () async{
            await FirebaseAuth.instance.signInWithEmailAndPassword(email: "*****@naver.com", password: "****")
              .then((user) => Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(user: user.user.email,))))
              .catchError((e)=>print(e));
          },
        ),
      )
    );
  }
}

class MainPage extends StatefulWidget {
  var user;
  MainPage({this.user});
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("안녕하세요, ${widget.user} 님"),
      ),
    );
  }
}


// Err 주의
// android/gradle.properties
// + android.enableJetifier=true
// + android.useAndroidX=true
