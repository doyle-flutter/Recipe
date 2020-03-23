import 'dart:async';
import 'package:flutter/material.dart';

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

  double _cdx = 0;
  double _cdy = 0;

  double get cdx => this._cdx;
  double get cdy => this._cdy;

  set cdx(double newCdx) => this._cdx = newCdx;
  set cdy(double newCdy) => this._cdy = newCdy;

  double boxWidth = 100.0;
  double boxHeight = 100.0;

  @override
  void initState() {
    Future.microtask((){
      _cdx = MediaQuery.of(context).size.width/2-(this.boxWidth/2);
      _cdy = MediaQuery.of(context).size.height/2-(this.boxHeight/2);
    }).then((_) => setState((){}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTapDown: (TapDownDetails td){
          setState(() {
            this.cdx = td.globalPosition.dx-(this.boxWidth/2);
            this.cdy = td.globalPosition.dy-(this.boxHeight/2);
          });
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black,
          child: Stack(
            children: <Widget>[
              Transform.translate(
                offset: Offset(cdx, cdy),
                child: Container(
                  width: this.boxWidth,
                  height: this.boxHeight,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}





