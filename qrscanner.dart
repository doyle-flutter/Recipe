import 'package:flutter/material.dart';
import 'package:flutter_qr_reader/flutter_qr_reader.dart';


class QrScannerPage extends StatefulWidget {
  @override
  _QrScannerPageState createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {

  QrReaderViewController _controller;
  String data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Transform.translate(
                offset: Offset(MediaQuery.of(context).size.width/3,1.0),
                child: QrReaderView(
                  width: MediaQuery.of(context).size.width/3,
                  height: MediaQuery.of(context).size.width/3,
                  callback: (QrReaderViewController container) {
                    this._controller = container;
                    _controller.startCamera(onScan);
                  },
                ),
              ),
            ),
            Flexible(
              child: Container(
                child: Text("QR Code - James"),
              ),
            )
          ],
        ),
      ),
    );
  }
  void onScan(String v, List<Offset> offsets) {
    setState(() {
      data = v;
      print(data);
    });
    _controller.stopCamera();
  }
}
