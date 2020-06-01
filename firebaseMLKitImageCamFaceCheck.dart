// https://youtu.be/ru1Vkm6iWME 

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/foundation.dart';
import 'dart:ui' as ui show Image;
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:math' as Math;

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

  double get btnSize => MediaQuery.of(context).size.width/2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smile To Face App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
                child: Text('Add Smile to Face from Image'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => FaceDetectionFromImage(),
                    ),
                  );
                }),
            RaisedButton(
                child: Text('Add Smile to Face from Live Camera'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => FaceDetectionFromLiveCamera(),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}


class FaceDetectionFromLiveCamera extends StatefulWidget {
  FaceDetectionFromLiveCamera({Key key}) : super(key: key);

  @override
  _FaceDetectionFromLiveCameraState createState() =>
      _FaceDetectionFromLiveCameraState();
}

class _FaceDetectionFromLiveCameraState
    extends State<FaceDetectionFromLiveCamera> {


  FaceDetector faceDetector;
  List<Face> faces;
  CameraController _camera;

  bool _isDetecting = false;
  CameraLensDirection _direction = CameraLensDirection.back;

  @override
  void initState() {
    faceDetector = FirebaseVision.instance.faceDetector();
    _initializeCamera();
    super.initState();

  }

  void _initializeCamera() async {
    CameraDescription description = await getCamera(_direction);
    ImageRotation rotation = rotationIntToImageRotation(
      description.sensorOrientation,
    );

    _camera = CameraController(
      description,
      ResolutionPreset.low
    );
    await _camera.initialize();

    _camera.startImageStream((CameraImage image) {
      if (_isDetecting) return;

      _isDetecting = true;

      detect(image, FirebaseVision.instance.faceDetector().processImage,
          rotation)
          .then(
            (dynamic result) {
          setState(() {
            faces = result;
          });

          _isDetecting = false;
        },
      ).catchError(
            (_) {
          _isDetecting = false;
        },
      );
    });
  }

  Widget _buildResults() {
    const Text noResultsText = const Text('No results!');

    if (faces == null || _camera == null || !_camera.value.isInitialized) {
      return noResultsText;
    }

    CustomPainter painter;

    final Size imageSize = Size(
      _camera.value.previewSize.height,
      _camera.value.previewSize.width,
    );

    painter = SmilePainterLiveCamera(imageSize, faces);

    return CustomPaint(
      painter: painter,
    );
  }

  Widget _buildImage() {
    return Container(
      constraints: const BoxConstraints.expand(),
      child: _camera == null
          ? const Center(
        child: Text(
          'Initializing Camera...',
          style: TextStyle(
            color: Colors.green,
            fontSize: 30.0,
          ),
        ),
      )
          : Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CameraPreview(_camera),
          _buildResults(),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              color: Colors.white,
              height: 50.0,
              child: ListView(
                children: faces.map(
                  (face) => Text(
                    face.boundingBox.center.toString()
                  )
                ).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleCameraDirection() async {
    if (_direction == CameraLensDirection.back) {
      _direction = CameraLensDirection.front;
    } else {
      _direction = CameraLensDirection.back;
    }

    await _camera.stopImageStream();
    await _camera.dispose();

    setState(() {
      _camera = null;
    });

    _initializeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Face Detection with Smile"),
      ),
      body: _buildImage(),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleCameraDirection,
        child: _direction == CameraLensDirection.back
            ? const Icon(Icons.camera_front)
            : const Icon(Icons.camera_rear),
      ),
    );
  }
}

class FaceDetectionFromImage extends StatefulWidget {
  @override
  _FaceDetectionFromImageState createState() => _FaceDetectionFromImageState();
}

class _FaceDetectionFromImageState extends State<FaceDetectionFromImage> {
  bool loading = true;
  ui.Image image;
  List<Face> faces;
  final FaceDetector faceDetector = FirebaseVision.instance.faceDetector();

  Future<ui.Image> _loadImage(File file) async {
    final data = await file.readAsBytes();
    return await decodeImageFromList(data);
  }

  void pickAndProcessImage() async {
    final File file = await ImagePicker.pickImage(source: ImageSource.gallery);
    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(file);
    faces = await faceDetector.processImage(visionImage);
    image = await _loadImage(file);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Face detection with Smile'),
      ),
      body: Center(
        child: loading
            ? Text('Press The floating Action Button for load image!')
            : FittedBox(
          child: SizedBox(
            width: image.width.toDouble(),
            height: image.height.toDouble(),
            child: FacePaint(
              painter: SmilePainter(image, faces),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickAndProcessImage,
        child: Icon(Icons.image),
      ),
    );
  }
}

typedef HandleDetection = Future<List<Face>> Function(FirebaseVisionImage image);

Future<CameraDescription> getCamera(CameraLensDirection dir) async {
  return await availableCameras().then(
        (List<CameraDescription> cameras) => cameras.firstWhere(
          (CameraDescription camera) => camera.lensDirection == dir,
    ),
  );
}

Uint8List concatenatePlanes(List<Plane> planes) {
  final WriteBuffer allBytes = WriteBuffer();
  planes.forEach((Plane plane) => allBytes.putUint8List(plane.bytes));
  return allBytes.done().buffer.asUint8List();
}

FirebaseVisionImageMetadata buildMetaData(
    CameraImage image,
    ImageRotation rotation,
    ) {
  return FirebaseVisionImageMetadata(
    rawFormat: image.format.raw,
    size: Size(image.width.toDouble(), image.height.toDouble()),
    rotation: rotation,
    planeData: image.planes.map(
          (Plane plane) {
        return FirebaseVisionImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList(),
  );
}

Future<List<Face>> detect(
    CameraImage image,
    HandleDetection handleDetection,
    ImageRotation rotation,
    ) async {
  return handleDetection(
    FirebaseVisionImage.fromBytes(
      concatenatePlanes(image.planes),
      buildMetaData(image, rotation),
    ),
  );
}

ImageRotation rotationIntToImageRotation(int rotation) {
  switch (rotation) {
    case 0:
      return ImageRotation.rotation0;
    case 90:
      return ImageRotation.rotation90;
    case 180:
      return ImageRotation.rotation180;
    default:
      assert(rotation == 270);
      return ImageRotation.rotation270;
  }
}


class FacePaint extends CustomPaint {
  final CustomPainter painter;

  FacePaint({this.painter}) : super(painter: painter);
}

class SmilePainter extends CustomPainter {
  final ui.Image image;
  final List<Face> faces;

  SmilePainter(this.image, this.faces);

  @override
  void paint(Canvas canvas, Size size) {
    if (image != null) {
      canvas.drawImage(image, Offset.zero, Paint());
    }

    final paintRectStyle = Paint()..color = Colors.transparent;

    //Draw Body
    final paint = Paint()..color = Colors.yellow;

    for (var i = 0; i < faces.length; i++) {
      final radius =
          Math.min(faces[i].boundingBox.width, faces[i].boundingBox.height) / 2;
      final center = faces[i].boundingBox.center;
      final smilePaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = radius / 8;
      canvas.drawRect(faces[i].boundingBox, paintRectStyle);
      canvas.drawCircle(center, radius, paint);
      canvas.drawArc(
          Rect.fromCircle(
              center: center.translate(0, radius / 8), radius: radius / 2),
          0,
          Math.pi,
          false,
          smilePaint);
      //Draw the eyes
      canvas.drawCircle(Offset(center.dx - radius / 2, center.dy - radius / 2),
          radius / 8, Paint());
      canvas.drawCircle(Offset(center.dx + radius / 2, center.dy - radius / 2),
          radius / 8, Paint());
    }
  }

  @override
  bool shouldRepaint(SmilePainter oldDelegate) {
    return image != oldDelegate.image || faces != oldDelegate.faces;
  }
}

class SmilePainterLiveCamera extends CustomPainter {
  final Size imageSize;
  final List<Face> faces;

  SmilePainterLiveCamera(this.imageSize, this.faces);

  @override
  void paint(Canvas canvas, Size size) {
    final paintRectStyle = Paint()..color = Colors.transparent;
//      ..color = Colors.red
//      ..strokeWidth = 10.0
//      ..style = PaintingStyle.stroke;

    final paint = Paint()..color = Colors.yellow;
    for (var i = 0; i < faces.length; i++) {
      //Scale rect to image size
      final rect = _scaleRect(
        rect: faces[i].boundingBox,
        imageSize: imageSize,
        widgetSize: size,
      );

      //Radius for smile circle
      final radius = Math.min(rect.width, rect.height) / 2;

      //Center of face rect
      final Offset center = rect.center;

      final smilePaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = radius / 8;

      //Draw rect border
       canvas.drawRect(rect, paintRectStyle);

      //Draw body
       canvas.drawCircle(center, radius, paint);

      //Draw mouth
      canvas.drawArc(
          Rect.fromCircle(
              center: center.translate(0, radius / 8), radius: radius / 2),
          0,
          Math.pi,
          false,
          smilePaint);

      //Draw the eyes
      canvas.drawCircle(Offset(center.dx - radius / 2, center.dy - radius / 2),
          radius / 8, Paint());
      canvas.drawCircle(Offset(center.dx + radius / 2, center.dy - radius / 2),
          radius / 8, Paint());
    }
  }

  @override
  bool shouldRepaint(SmilePainterLiveCamera oldDelegate) {
    return imageSize != oldDelegate.imageSize || faces != oldDelegate.faces;
  }
}

Rect _scaleRect({
  @required Rect rect,
  @required Size imageSize,
  @required Size widgetSize,
}) {
  final double scaleX = widgetSize.width / imageSize.width;
  final double scaleY = widgetSize.height / imageSize.height;

  return Rect.fromLTRB(
    rect.left.toDouble() * scaleX,
    rect.top.toDouble() * scaleY,
    rect.right.toDouble() * scaleX,
    rect.bottom.toDouble() * scaleY,
  );
}
