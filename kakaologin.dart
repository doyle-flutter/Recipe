import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
// https://pub.dev/packages/flutter_webview_plugin

void main() {
  runApp(MaterialApp(
    home: Login(),
  ));
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rest API : Login"),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("KakaO Login"),
              onPressed: () async{
                const String _REST_API_KEY = "";
                // 카카오 REST API KEY
                const String _REDIRECT = "http://MyNodejsIP:3000/auth"; 
                // 제품설정 - > 카카오로그인 -> Redirect URI에 등록한 주소(테스트시 로컬주소 등록가능)
                final _host = "https://kauth.kakao.com";
                final _url = "/oauth/authorize?client_id=$_REST_API_KEY&redirect_uri=$_REDIRECT&response_type=code";
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => WebviewScaffold(
                      appBar: AppBar(),
                      withJavascript: true,
                      url: _host+_url,
                      javascriptChannels: Set.from([
                        JavascriptChannel(
                            name: "james",
                            onMessageReceived: (JavascriptMessage result){
                              if(result.message != null){
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => MainPage(
                                      loginType: "카카오 로그인 회원",
                                    )
                                  ),
                                  (Route r) => false
                                );
                                return;
                              }
                              Navigator.of(context).pop();
                              return;
                            }
                        ),
                      ]),
                    )
                  )
                );
              },
            ),
            RaisedButton(
              child: Text("Naver Login(ing...)"),
            )
          ],
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  String loginType;
  MainPage({@required this.loginType});
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.loginType),
        centerTitle: true,
      ),
      body: Center(
        child: Text("Hello World !"),
      ),
    );
  }
}
