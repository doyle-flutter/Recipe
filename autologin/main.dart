import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider<LoginCheckProvider>(create: (_) => new LoginCheckProvider(),)
    ],
    child: MaterialApp(home: AutoLoginCheck(),)
  )
);

class LocalDbf{
  static const String _AUTO_KEY = "auto";
  static const String _AUTO_ID = "aid";
  static const String _AUTO_TOKEN = "atoken";
  Future<bool> autoCheck() async => await SharedPreferences.getInstance().then((SharedPreferences _pref) => _pref.getBool(_AUTO_KEY) ?? false);
  Future<bool> setCheck({@required bool auto}) async => await SharedPreferences.getInstance().then((SharedPreferences _pref) async => await _pref.setBool(_AUTO_KEY, auto));
  Future<Map<String, String>> userInfo() async => await SharedPreferences.getInstance()
    .then((SharedPreferences _pref){
      final String _id = _pref.getString(_AUTO_ID) ?? "";
      final String _pwnToken = _pref.getString(_AUTO_TOKEN) ?? "";
      if(_id.isEmpty || _pwnToken.isEmpty) return {};
      return {"id":_id, "pw": _pwnToken};
    });
  Future<bool> setUserInfo({@required String id, @required String pwnToken}) async => await SharedPreferences.getInstance().then((SharedPreferences _pref) async{
    final bool _setId = await _pref.setString(_AUTO_ID, id);
    final bool _setPw = await _pref.setString(_AUTO_TOKEN, pwnToken);
    if(!_setId || !_setPw) return false;
    return true;
  });
  Future<bool> clearAutoInfo() async => await SharedPreferences.getInstance().then((SharedPreferences _pref) async => await _pref.clear() ?? false);
}

class Fetch{
  static const String _END_POINT = "http://127.0.0.1:3000";
  Future<bool> postFetch({@required Map<String, dynamic> body, @required Map<String, String> header}) async{
    try{
      http.Response _res = await http.post("$_END_POINT/login",headers: header, body: body).timeout(Duration(seconds: 8),onTimeout: () async => http.Response("false", 400));
      bool _result = json.decode(_res.body);
      return _result;
    }
    catch(e){
      return false;
    }
  }
  void _parse(){} // ... 반환 구조 지정 필요
}

class LoginCheckProvider with ChangeNotifier{
  final LocalDbf _dbf = new LocalDbf();
  final Fetch _fetch = new Fetch();

  bool result;

  LoginCheckProvider(){
    Future.microtask(() async => await check());
    return;
  }

  Future<void> check() async{
    final bool _check = await _dbf.autoCheck();
    if(!_check) return this.result = false;
    final Map<String, String> _body = await _dbf.userInfo();
    if(_body.isEmpty) return this.result = false;
    this.result = await _fetch.postFetch(body: _body, header: {"token":"1"});
    notifyListeners();
  }

  Future<void> logOut() async{
    this.result = !await _dbf.clearAutoInfo();
    notifyListeners();
    return;
  }

  Future<void> login({@required String id, @required String pwnToken}) async{
    final bool _res = await _fetch.postFetch(body: {'id':id, "pw":pwnToken}, header: {"token":"1"});
    if(_res){
      await _dbf.setCheck(auto: true);
      await _dbf.setUserInfo(id: id, pwnToken: pwnToken);
      this.result = true;
    }
    notifyListeners();
  }
}

class AutoLoginCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginCheckProvider _lc = Provider.of<LoginCheckProvider>(context);
    return _lc.result == null
      ? Scaffold(body: Text("로딩"))
      : _lc.result
        ? new MainPage()
        : new LoginPage();
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FocusNode _idFocus;
  FocusNode _pwFocus;

  TextEditingController _idController;
  TextEditingController _pwController;
  
  @override
  void initState() {
    if(!mounted) return;
    Future.microtask((){
      _idFocus = new FocusNode();
      _pwFocus = new FocusNode();
      _idController = new TextEditingController();
      _pwController = new TextEditingController();
      return;
    }).then((_) => setState((){}));
    super.initState();
  }
  
  @override
  void dispose() {
    _idController?.dispose();
    _pwController?.dispose();
    super.dispose();
  }

  LoginCheckProvider _lc;

  @override
  Widget build(BuildContext context) {
    if(_lc == null) _lc = Provider.of<LoginCheckProvider>(context);
    return IgnorePointer(
      ignoring: _idController == null || _pwController == null ? true : false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.all(50.0),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        image: DecorationImage(
                          image: NetworkImage(
                            "https://raw.githubusercontent.com/doyle-flutter/Recipe/master/2019-11-21.webp",
                          ),
                          fit: BoxFit.cover,
                        )
                    ),
                  )
              ),
              Flexible(
                  child: Container(
                    child: Form(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Container(
                              width: MediaQuery.of(context).size.width/2,
                              alignment: Alignment.center,
                              child: TextField(
                                maxLines: 1,
                                focusNode: _idFocus,
                                textInputAction: TextInputAction.next,
                                cursorColor: Colors.black,
                                controller: _idController,
                                autocorrect: true,
                                enabled: true,
                                keyboardType: TextInputType.emailAddress,
                                onSubmitted: (String v)
                                => this._inputFieldFocusChange(
                                    context: context,
                                    currentFocus: this._idFocus,
                                    nextFocus: this._pwFocus
                                ),
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    hintText: "E-Mail",
                                    prefixIcon: Icon(Icons.person,color: Colors.black,),
                                    suffixIcon: this._inputIcon(controller: this._idController, currentFocus: this._idFocus),
                                    border: InputBorder.none
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              width: MediaQuery.of(context).size.width/2,
                              alignment: Alignment.center,
                              child: TextField(
                                maxLines: 1,
                                focusNode: _pwFocus,
                                textInputAction: TextInputAction.done,
                                cursorColor: Colors.black,
                                controller: _pwController,
                                obscureText: true,
                                onSubmitted: (String v){},
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    hintText: "Password",
                                    prefixIcon: Icon(Icons.lock_outline, color: Colors.black,),
                                    suffixIcon: this._inputIcon(
                                        controller: this._pwController,
                                        currentFocus: this._pwFocus),
                                    border: InputBorder.none
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
              ),
              Flexible(
                  child: Column(
                    children: <Widget>[
                      Flexible(
                        child: Container(
                          alignment: Alignment.center,
                          child: MaterialButton(
                            onPressed: this._validation,
                            child: Text("Login"),
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputIcon({TextEditingController controller, FocusNode currentFocus}){
    if(controller?.text == "") return null;
    else return IconButton(
      icon: Icon(Icons.clear),
      onPressed: (){
        this.clickClearText(targetVar: controller, currentFocus: currentFocus);
        print(controller?.text);
      },
    );
  }

  void _inputFieldFocusChange({
    BuildContext context,
    FocusNode currentFocus,
    FocusNode nextFocus
  }){
    Future.microtask(() => currentFocus.unfocus())
        .then((_) => FocusScope.of(context).requestFocus(nextFocus));
  }

  void clickClearText({
    @required TextEditingController targetVar,
    @required FocusNode currentFocus
  }){
    assert(targetVar != null); assert(currentFocus != null);
    Future.delayed(Duration.zero,(){
      currentFocus.unfocus();
    }).then((_) => targetVar.clear());
  }

  Future<void> _validation() async{
    print(_idController.text);
    print(_pwController.text);
    bool _isCheck = false;
    await _lc.login(id: _idController.text, pwnToken: _pwController.text);
    _idController.text = "";
    _pwController.text = "";
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginCheckProvider _lc = Provider.of<LoginCheckProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.error_outline),
            onPressed: () async {
              await _lc.logOut();
            },
          )
        ],
      ),
    );
  }
}
