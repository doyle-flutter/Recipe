import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {

  String key;
  String key2;

  final myController = TextEditingController();
  final myController2 = TextEditingController();

  @override
  void initState() {
    super.initState();
    myController.addListener((){
      _printLatestValue(myController);
    });
    myController2.addListener((){
      _printLatestValue2(myController2);
    });
  }

  @override
  void dispose() {
    myController.dispose();
    myController2.dispose();
    super.dispose();
  }

  _printLatestValue(TextEditingController ct) {
    setState(() {
      key = ct.text;
      print("value ${key}text field: ${ct.text}");
    });
  }
  _printLatestValue2(TextEditingController ct) {
    setState(() {
      key2 = ct.text;
      print("value ${key2}text field: ${ct.text}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 50.0,),
          customField(
            hint: "입력1",
            ct: myController
          ),
          customField(
            hint: "입력2",
            ct: myController2
          ),
          Container(
            width: 200,
            height: 100,
            alignment: Alignment.center,
            color: Colors.red,
            child: Text(
              key??"1",
              style: TextStyle(
                color: Colors.white
              ),
            ),
          ),
          Container(
            width: 200,
            height: 100,
            alignment: Alignment.center,
            color: Colors.blue,
            child: Text(
              key2??"2",
              style: TextStyle(
                  color: Colors.white
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Container customField({String hint, TextEditingController ct}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          labelText: hint
        ),
        controller: ct,
      ),
    );
  }

}
