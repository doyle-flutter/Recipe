// file_picker: ^1.9.0+1
// https://pub.dev/packages/file_picker
// *setUp : https://github.com/miguelpruivo/flutter_file_picker/wiki/Setup
// *해당 버전에서 android_Intent 패키지와 충돌 이슈 -> Intent 기능 구현시 네이티브로 직접 구현

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter File APP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  GlobalKey<ScaffoldState> _skey = new GlobalKey<ScaffoldState>();
  double get btnSize => MediaQuery.of(context).size.width/2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _skey,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: btnSize,
              child: RaisedButton(
                child: Text("File Picker : audio"),
                onPressed: () async{
                  try{
                    var files = await FilePicker.getMultiFile(
                        type: FileType.audio
                    );
                    print(files);
                  }
                  catch(e){
                    _skey.currentState.showSnackBar(
                      SnackBar(
                        content: Text("실제 기기 테스트를 진행해주세요"),
                      )
                    );
                  }

                },
              ),
            ),

            Container(
              width: btnSize,
              child: RaisedButton(
                child: Text("File Picker : image"),
                onPressed: () async{
                  var files = await FilePicker.getMultiFile(
                      type: FileType.image
                  );
                  print(files);
                },
              ),
            ),

            Container(
              width: btnSize,
              child: RaisedButton(
                child: Text("File Picker : any"),
                onPressed: () async{
                  var files = await FilePicker.getMultiFile(
                      type: FileType.any
                  );
                  print(files);
                },
              ),
            ),

            Container(
              width: btnSize,
              child: RaisedButton(
                child: Text("File Picker : video"),
                onPressed: () async{
                  var files = await FilePicker.getMultiFile(
                      type: FileType.video
                  );
                  print(files);
                },
              ),
            ),

            Container(
              width: btnSize,
              child: RaisedButton(
                child: Text("File Picker : media"),
                onPressed: () async{
                  var files = await FilePicker.getMultiFile(
                      type: FileType.media
                  );
                  print(files);
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
