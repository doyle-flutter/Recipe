// Flutter ver 1.21.0
// TEST : IOS, WEB

import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text("Image - Pixabay.com")),
    body: Center(
      child: Container(
        width: 200.0,
        height: 200.0,
        child: Image.network(
          "https://cdn.pixabay.com/photo/2020/08/27/10/24/water-5521696__480.jpg",
          headers: {"User-Agent":"Dart"},
          width: 200.0,
          height: 200.0,
          cacheWidth: 200,
          cacheHeight: 200,
          fit: BoxFit.cover,
          semanticLabel: "image1",
          isAntiAlias: true,
          frameBuilder: (BuildContext context, Widget w, int i, bool b){
            if(i == null) return Container(color: Colors.red,);
            return w;
          },
          loadingBuilder: (BuildContext context, Widget w, ImageChunkEvent e){
            if(e == null) return w;
            return Container(color: Colors.yellow,);
          },
          errorBuilder: (BuildContext context, Object obj, StackTrace st) => Text("ERR !"),
        ),
      ),
    )
  );
}

