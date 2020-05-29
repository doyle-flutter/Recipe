// flutter_sound 5.0.1 (with permission_handler)
// https://pub.dev/packages/flutter_sound

// * And minSDK : 24+
// * permission :
// <uses-permission android:name="android.permission.RECORD_AUDIO"/>
// <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>

// * IOS Target : 9.3+ 
// * info.list
//<key>NSMicrophoneUsageDescription</key>
//<string>Can We Use Your Microphone Please</string>

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

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
      home: MyHomePage(title: 'Flutter Recorde APP'),
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
  String viewTxt = "Recorde Player";

  FlutterSoundRecorder myRecorder;
  FlutterSoundPlayer myPlayer;
  bool check = false;
  bool playCheck = false;

  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    Future.microtask(() async{
      myRecorder = await FlutterSoundRecorder().openAudioSession();
      myPlayer = await FlutterSoundPlayer().openAudioSession();
    });
    super.initState();
  }

  @override
  void dispose(){
    if (myRecorder != null)
    {
      myRecorder.closeAudioSession();
      myPlayer.closeAudioSession();

      myRecorder = null;
      myPlayer = null;
    }
    super.dispose();
  }

  Future<void> _recodeFunc() async{
    PermissionStatus status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) throw RecordingPermissionException("Microphone permission not granted");
    setState(() {
      viewTxt = "Recoding ~";
    });
    if(!check){
      Directory tempDir = await getTemporaryDirectory();
      File outputFile = File('${tempDir.path}/flutter_sound-tmp.aacADTS');
      await myRecorder.startRecorder(toFile: outputFile.path,codec: Codec.aacADTS);
      print("START");
      setState(() {
        check = !check;
      });
      return;
    }
    print("STOP");
    setState(() {
      check = !check;
      viewTxt = "await...";
    });
    await myRecorder.stopRecorder();
    return;
  }

  Future<void> playMyFile() async{
    if(!playCheck){
      Directory tempDir = await getTemporaryDirectory();
      File inFile = File('${tempDir.path}/flutter_sound-tmp.aacADTS');
      try{
        Uint8List dataBuffer = await inFile.readAsBytes();
        print("dataBuffer $dataBuffer");
        setState(() {
          playCheck = !playCheck;
        });
        await this.myPlayer.startPlayer(
            fromDataBuffer: dataBuffer,
            codec: Codec.aacADTS,
            whenFinished: () {
              print('Play finished');
              setState(() {});
            });
      }
      catch(e){
        print(" NO Data");
        _key.currentState.showSnackBar(
          SnackBar(
            content: Text("NO DATA!!!!!!"),
          )
        );
      }
      return;
    }
    await myPlayer.stopPlayer();
    setState(() {
      playCheck = !playCheck;
    });
    print("PLAY STOP!!");
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              viewTxt,
              style: Theme.of(context).textTheme.headline4,
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              child: FloatingActionButton(
                onPressed: _recodeFunc,
                tooltip: 'Increment',
                child: check ? Icon(Icons.stop) :Icon(Icons.play_arrow),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                border: Border.all(width: 2.0, color: Colors.grey[200]),
                borderRadius: BorderRadius.circular(15.0)
              ),
              child: Column(
                children: <Widget>[
                  Text("Play Controller\n(Recorde File)"),
                  IconButton(
                    icon: playCheck ? Icon(Icons.stop) : Icon(Icons.play_circle_filled),
                    onPressed: () async{
                      await playMyFile();
                    },
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
