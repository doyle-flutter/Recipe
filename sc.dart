// scroll controller : Direction

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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

  double hes = 50;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener((){
      if(scrollController.position.userScrollDirection == ScrollDirection.forward){
        setState(() {
          hes = 50;
        });
      }
      else{
        setState(() {
          hes = 0;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                color: Colors.green,
                child: Center(
                  child: Text("Header"),
                ),
              ),
              Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height-200,
                    child: ListView(
                        padding: EdgeInsets.all(0),
                        controller: scrollController,
                        children: [1,2,3,4,5].map((e) => Container(
                          height: 400,
                          alignment: Alignment.center,
                          child: Text(e.toString()),
                        )).toList()
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: hes,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          GestureDetector(
                            child: Container(
                              width:MediaQuery.of(context).size.width/2,
                              color: Colors.red,
                              alignment: Alignment.center,
                              child: Text("Btn1"),
                            ),
                            onTap: (){
                              print("1");
                            },
                          ),
                          GestureDetector(
                            child: Container(
                              width:MediaQuery.of(context).size.width/2,
                              alignment: Alignment.center,
                              color: Colors.blue,
                              child: Text("Btn2"),
                            ),
                            onTap: (){
                              print("2");
                            },
                          ),
                        ],
                      ),
                    ),
                  )

                ],
              ),
            ],
          )
        ),
      ),
    );
  }
}
