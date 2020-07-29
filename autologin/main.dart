import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider<LoginProvider>(create: (_) => new LoginProvider(),)
    ],
    child: MaterialApp(
      home: LoginCheckViewModel(),
    ),
  )
);

class LocalDbfLoginCheck{
  static const String _CHECK_KEY = "loginCheck";
  static const String _ID_KEY = "idCheck";
  static const String _TOKEN_KEY = "tokenCheck";
  Future<LocalDbfUserInfo> localDbfCheck() async => await SharedPreferences.getInstance().then((SharedPreferences _pref){
    final bool _check =_pref.getBool(_CHECK_KEY) ?? false;
    final String _id = _pref.getString(_ID_KEY) ?? "";
    final String _token = _pref.getString(_TOKEN_KEY) ?? "";
    return LocalDbfUserInfo.getData(id: _id, token: _token, check: _check);
  });
  Future<bool> localDbfSet({@required bool check}) async => await SharedPreferences.getInstance().then((SharedPreferences _pref) => _pref.setBool(_CHECK_KEY, check)).then((bool _saveCheck) => _saveCheck);
}

class LocalDbfUserInfo{
  final String id;
  final String token;
  final bool check;
  const LocalDbfUserInfo({@required this.id, @required this.token, @required this.check});
  factory LocalDbfUserInfo.getData({@required String id, @required String token, @required bool check}) => new LocalDbfUserInfo(id: id, token: token,check: check);
}

class UserLoginInfo{
  static Map<String, String> toJson({@required String id, @required String token}) => {'id':id, 'token':token};
}

class UserInfo{
  final String id;
  final String pw;
  const UserInfo({@required this.id, @required this.pw}):assert(id != null), assert(pw != null);
  factory UserInfo.setData({@required Map<String, dynamic> json}) => new UserInfo(id: json['id'] as String, pw: json['pw'] as String);
}

class ConnectServer{
  static const String _END_POINT = "http://192.168.0.2:3000";
  static const Map<String, String> _HEADER_SETTING = {"token":"1"}; // JWT, sha ... Logic
  Future<Map<String, dynamic>> _loginPost({@required String id, @required String token}) async{
    const String _url = "$_END_POINT/login";
    try{
      final http.Response _res = await http.post(_url, headers: _HEADER_SETTING, body: UserLoginInfo.toJson(id: id, token: token)).timeout(Duration(seconds: 8), onTimeout: () async => new http.Response("false", 400));
      final Map<String, dynamic> _userInfoJson = json.decode(_res.body);
      return _userInfoJson;
    }
    catch(e){
      return null;
    }
  }
}

class LoginPost extends ConnectServer{
  Future<UserInfo> login({@required String id, @required String token}) async{
    final Map<String, dynamic> _result = await super._loginPost(id: id, token: token) ?? {};
    if(_result.isEmpty) return null;
    return UserInfo.setData(json: _result); //{id}
  }
}

class LoginProvider with ChangeNotifier{
  LocalDbfLoginCheck _loginCheck = new LocalDbfLoginCheck();
  LoginPost _post = new LoginPost();
  Future<bool> autoLoginCheck() async{
    LocalDbfUserInfo _user = await _loginCheck.localDbfCheck();
    if(!_user.check || _user.id.isEmpty || _user.token.isEmpty){
      return false;
    }
    UserInfo _connectUserInfo = await _post.login(id: _user.id, token: _user.token);
    if(_connectUserInfo == null){
      return false;
    }
    return true;
  }
  // net -> setter
}

class LoginCheckViewModel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginProvider _lg = Provider.of<LoginProvider>(context);
    return FutureBuilder(
      future: _lg.autoLoginCheck(),
      builder: (BuildContext context,AsyncSnapshot<bool> snap){
        return Scaffold(
          appBar: AppBar(title: Text(snap.data.toString()),),
        );
      },
    );
  }
}
