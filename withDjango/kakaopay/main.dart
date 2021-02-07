// (1) HTTP 설정 필요
// (2) 패키지 : webview_flutter 1.0.7(https://pub.dev/packages/webview_flutter)

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GestureBinding.instance.resamplingEnabled = true;
  return runApp(MaterialApp(home: MyApp(),));
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter & Django"),),
      body: Center(
        child: TextButton(
          child: Text("구매"),
          onPressed: () async{
            const String _url = "http://DjangoServer:8000/kakaoPayLogic2";
            String _payResult = await Navigator.of(context).push<String>(
              MaterialPageRoute(builder: (BuildContext context) => Scaffold(
                appBar: AppBar(title: Text("PAY"),),
                body: WebView(
                  initialUrl: _url,
                  javascriptMode: JavascriptMode.unrestricted,
                  javascriptChannels: {
                    JavascriptChannel(
                      name: 'james',
                      onMessageReceived: (JavascriptMessage msg) => Navigator.of(context).pop(msg.message.toString())
                    )
                  },
                ),
              ))
            );
            bool check = json.decode(_payResult);
            if(check == null) return print('NULL');
            return await showDialog<void>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text(check ? "결제 완료" : "결제 실패"),
                actions: [
                  TextButton(
                    child: Text("닫기"),
                    onPressed: () => Navigator.of(context).pop<void>(),
                  )
                ],
              )
            );
          },
        ),
      ),
    );
  }
}

