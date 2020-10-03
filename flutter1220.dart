// `20.10.1 Flutter 1.22.0 Update

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  GestureBinding.instance.resamplingEnabled = true;
  return runApp(MaterialApp(home: new NewFlutter1220(),));
}

class NewFlutter1220 extends StatefulWidget {
  @override
  _NewFlutter1220State createState() => _NewFlutter1220State();
}

class _NewFlutter1220State extends State<NewFlutter1220>{

  TextStyle _txtStyle = TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter 1.22.0 버튼 변경"),),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height/5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("1. FlatButton -> TextButton", style: _txtStyle,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FlatButton(onPressed: (){},child: Text("FlatBtn")),
                        Icon(Icons.arrow_right_alt_sharp),
                        TextButton(onPressed: (){}, child: Text("TextBtn"))
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height/5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("2. RaisedButton -> ElevatedButton", style: _txtStyle,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RaisedButton(onPressed: (){},child: Text("RaisedBtn")),
                        Icon(Icons.arrow_right_alt_sharp),
                        ElevatedButton(onPressed: (){}, child: Text("ElevatedBtn"))
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height/5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("3. OutlineButton -> OutlinedButton", style: _txtStyle,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlineButton(onPressed: (){},child: Text("OutlineBtn")),
                        Icon(Icons.arrow_right_alt_sharp),
                        OutlinedButton(onPressed: (){}, child: Text("OutlinedBtn"))
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.red,
                child: Center(child: Text("스크롤을 위한 Container")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
