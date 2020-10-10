// Ver.
// Flutter 1.22.0
// Dart 2.10.0

import 'dart:convert';
import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  GestureBinding.instance.resamplingEnabled = true;
  return runApp(
    MaterialApp(
      home: new MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final TextEditingController _txt = new TextEditingController(text: "");
  final String _url = 'http://127.0.0.1:port/mail';
  bool btnChcek = true;

  @override
  void dispose() {
    _txt?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width*0.50,
              child: TextField(
                controller: _txt,
                decoration: InputDecoration(
                  hintText: "내용을 입력해주세요",
                  border: InputBorder.none,
                  fillColor: Colors.grey[300],
                  filled: true,
                ),
                onSubmitted: btnChcek ? (String _) async => await _sending(context: context, txt: _txt) : null,
              ),
            ),
            ElevatedButton(
              onPressed: btnChcek ? () async => await _sending(context: context, txt: _txt) : null,
              child: Text("발송")
            )
          ],
        ),
      ),
    );
  }

  Future<void> _sending({@required TextEditingController txt, @required BuildContext context}) async{
    setState(() {
      btnChcek = !btnChcek;
    });
    final bool _check = await _sendMailBtn(txt: txt.text);
    txt.text = "";
    if(!_check){
      await showDialog<void>(
        context: context,
        builder: (context)
          => AlertDialog(
            title: Text("메일 발송 오류입니다!"),
            actions: [
              TextButton(onPressed: () => Navigator.of(context).pop(), child: Text("닫기"))
            ],
          ));
    }
    setState(() {
      btnChcek = !btnChcek;
    });
    return;
  }

  Future<bool> _sendMailBtn({@required String txt}) async{
    if(txt == null || txt.isEmpty || txt.length < 3) return false;
    Map<String, String> _header = {'User-Agent':""};
    if(Platform.isAndroid) _header['User-Agent'] = "and";
    if(Platform.isIOS) _header['User-Agent'] = "ios";
    if(_header['User-Agent'] == "") return false;
    final Map<String, String> _body = {'txt':txt};
    try{
      final http.Response _res = await http.post(_url,headers: _header, body: _body)
          .timeout(Duration(seconds: 8), onTimeout: () async => new http.Response("false", 404));
      if(_res.statusCode != 200) return false;
      final bool _result = json.decode(_res.body);
      return _result;
    }
    catch(e){
      return false;
    }
  }
}
