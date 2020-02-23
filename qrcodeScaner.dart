// qrscan: ^0.2.17
// flutter_webview_plugin: ^0.3.10+1

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:qrscan/qrscan.dart' as scanner;

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          icon: Icon(Icons.camera),
          onPressed: () async{
// - GALLERY
//            String cameraScanResult = await scanner.scanPhoto();

            String cameraScanResult = await scanner.scan();
            print('$cameraScanResult');
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DetailPage(url: cameraScanResult,)
              )
            );
          },
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  String url;
  DetailPage({this.url});
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(),
      url: this.url,
    );
  }
}
