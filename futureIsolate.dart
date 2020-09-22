// jank on Flutter

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  static int myComputeFunc(int i) => i;
  Future<int> myResultFunc({@required int v}) async => await compute(myComputeFunc, v);

  @override
  void initState() {
    Future(()async => print(await myResultFunc(v: 123)));
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) => Scaffold(body: Center(child: Text("Compute")));
}

