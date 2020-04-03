// push -> pushReplacement -> push -> pushAndRemoveUtil

import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(
      home: MoveMainPage(),
    )
  );
}

// ignore: must_be_immutable
class WrapperPage extends StatelessWidget {
  String title;
  Widget moveNavigator;
  WrapperPage({@required this.title, @required this.moveNavigator});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Center(
        child: this.moveNavigator,
      ),
    );
  }
}


class MoveMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WrapperPage(
      title: "Main",
      moveNavigator: RaisedButton(
        onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => new Page2()
            )
        ),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WrapperPage(
      title: "Page2",
      moveNavigator: RaisedButton(
        onPressed: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) => new Page3()
            )
        ),
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WrapperPage(
      title: "Page3",
      moveNavigator: RaisedButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => new Page4()
          )
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Page4 extends StatelessWidget {
  bool _check = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        if(!_check){
          _check = !_check;
          return Future.value(false);
        }
        return Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MoveMainPage()),
          (Route<dynamic> route) => false
        );
      },
      child: WrapperPage(
        title: "PAGE 4",
        moveNavigator: RaisedButton(
          child: Text("Back"),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}

