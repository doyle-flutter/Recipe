// https://pub.dev/packages/image_cropper 
// + With ImagePicker

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

void main() => runApp(
  MaterialApp(
    home: MyApp(),
  )
);

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{

  ImagePicker imagePicker = new ImagePicker();
  GlobalKey<ScaffoldState> gKey = GlobalKey<ScaffoldState>();
  GlobalKey scr = new GlobalKey();

  File croppedFile;
  Uint8List capImage;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // key: gKey,
      body: SingleChildScrollView(
        child: Builder(
          builder: (context2) => Container(
            width: MediaQuery.of(context).size.width,
            child: Container(
              child: Column(
                children: <Widget>[
                  Text("Cropper Image : ", style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                  IconButton(
                    icon: Icon(Icons.image),
                    onPressed: () async{
                      PickedFile imageFile = await imagePicker.getImage(source: ImageSource.gallery);
                      if(imageFile == null ) return;
                      croppedFile = await ImageCropper.cropImage(
                          sourcePath: imageFile.path,
                          aspectRatioPresets: [
                            CropAspectRatioPreset.square,
                            CropAspectRatioPreset.ratio3x2,
                            CropAspectRatioPreset.original,
                            CropAspectRatioPreset.ratio4x3,
                            CropAspectRatioPreset.ratio16x9
                          ],
                          androidUiSettings: AndroidUiSettings(
                              toolbarTitle: 'Cropper',
                              toolbarColor: Colors.deepOrange,
                              toolbarWidgetColor: Colors.white,
                              initAspectRatio: CropAspectRatioPreset.original,
                              lockAspectRatio: false),
                          iosUiSettings: IOSUiSettings(
                            minimumAspectRatio: 1.0,
                          )
                      );
                      setState(() {});
                    },
                  ),
                  croppedFile == null
                    ? Container()
                    : Image.file(croppedFile),
                  Divider(thickness: 15.0),
                  Text("Capture Image : ", style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                  RepaintBoundary(
                    key: scr,
                    child: Container(
                      height: 300.0,
                      width: 200.0,
                      margin: EdgeInsets.all(10.0),
                      color: Colors.yellow,
                      child: Center(
                        child: Text("Capture Target")
                      ),
                    ),
                  ),
                  capImage == null
                    ? Container()
                    : Image.memory(capImage),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text("CAP"),
        onPressed: ()async {
          RenderRepaintBoundary boundary = scr.currentContext.findRenderObject();
          var image = await boundary.toImage();
          var byteData = await image.toByteData(format: ImageByteFormat.png);
          capImage = byteData.buffer.asUint8List();
          setState(() {});
        },
      ),
    );
  }
}
