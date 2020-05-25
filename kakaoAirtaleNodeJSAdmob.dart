import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginCheck(),
        )
      ],
      child: MaterialApp(
        home: SplashPage(),
      ),
    )
  );
}

class LoginCheck with ChangeNotifier{

  final String _key = "userid";

  Future<String> get getId async => await SharedPreferences.getInstance().then((SharedPreferences preferences) => preferences.getString(_key));

  set getId(v) => throw "ERR!";
  setId(String value) async{
    await SharedPreferences.getInstance().then((SharedPreferences preferences) => preferences.setString(_key, value));
    notifyListeners();
    return;
  }

  deleteUser() async{
    await SharedPreferences.getInstance().then((SharedPreferences preferences) => preferences.clear());
    notifyListeners();
    return;
  }

}

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void didChangeDependencies() {
    Timer(Duration(seconds: 2), () => Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (BuildContext context) => LoginCheckPage()
    )));
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Hello ! World"),
      ),
    );
  }
}

class LoginCheckPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<LoginCheck>(context).getId,
      builder: (BuildContext context, AsyncSnapshot<String> snap){
        if(!snap.hasData) return Login();
        return MainPage(userName: snap.data);
      }

    );
  }
}

class Air{
  final String _KEY = "";
  final String _DOC_KEY = "";
  final String _TABLE_NAME = "User";
  final String _TABLE_NAME_TABLE1 = "Table 1";
  final String _TABLE_TYPE = "Grid view";

  Future<http.Response> _connect() async => await http.get("https://api.airtable.com/v0/$_DOC_KEY/$_TABLE_NAME?api_key=$_KEY&view=$_TABLE_TYPE");
  Future<http.Response> _send({@required Map<String, dynamic> data}) async{
    Map<String, String> header = {"Content-Type" : "application/json"};
    try{
      return await http.post(
          "https://api.airtable.com/v0/$_DOC_KEY/$_TABLE_NAME?api_key=$_KEY&view=$_TABLE_TYPE",
          headers: header,
          body: json.encode(data)
      );
    }
    catch(e){
      return null;
    }
  }
  Future<http.Response> _targetConnect({@required String tableName}) async => await http.get("https://api.airtable.com/v0/$_DOC_KEY/$tableName?api_key=$_KEY&view=$_TABLE_TYPE");
  Future<List> getTable1() async {
    var res = await _targetConnect(tableName: _TABLE_NAME_TABLE1);
    Map<String, dynamic> _result = json.decode(res.body);
    return _result['records'];
  }

  Future<bool> createAirUser({
    @required String name,
    @required String loginType,
    @required String kToken,
    fToken = ""
  }) async{
    Map<String, dynamic> data = {
      "records": [
        {
          "fields": {
            "Name": name,
            "LoginType": loginType,
            "kToken":kToken,
            "fToken":fToken,
          }
        }
      ]
    };
    var _result = await _send(data: data);
    Map<String, dynamic> _resultData = json.decode(_result.body);
    if(_resultData == null || _resultData.isEmpty) return false;
    return true;
  }
  // ['fields']
  Future<List<dynamic>> readAirUser() async{
    var res = await _connect();
    final  _result = json.decode(res.body);
    return _result['records'];
  }

  Future<bool> updateAirUser() async{

  }
  Future<bool> deleteAirUser() async{

  }
}

class KLogin{
  final String _REST_API_KEY = "";
  // 카카오 REST API KEY
  final String _REDIRECT = "http://192.168.0.0:3000/auth";
  // 제품설정 - > 카카오로그인 -> Redirect URI에 등록한 주소(테스트시 로컬주소 등록가능)

  Future<String> kakaOLogin({@required BuildContext context}) async{
    final _host = "https://kauth.kakao.com";
    final _url = "/oauth/authorize?client_id=$_REST_API_KEY&redirect_uri=$_REDIRECT&response_type=code";
    String _check = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => WebviewScaffold(
          appBar: AppBar(),
          withJavascript: true,
          url: _host+_url,
          javascriptChannels: Set.from([
            JavascriptChannel(
              name: "james",
              onMessageReceived: (JavascriptMessage result) async{
                if(result.message != null) return Navigator.of(context).pop(result.message);
                return Navigator.of(context).pop();
              }
            ),
          ]),
        )
      )
    );
    if(_check == null) return null;
    return _check;
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  KLogin kLogin = new KLogin();
  Air air = new Air();

  String _loginType;
  TextEditingController _textEditingController;
  @override
  void initState() {
    if(!mounted) return;
    _textEditingController = new TextEditingController(text: "");
    super.initState();
  }

  LoginCheck _loginCheck;

  @override
  void didChangeDependencies() {
    if(_loginCheck == null){
      _loginCheck = Provider.of<LoginCheck>(context);
      return;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _textEditingController?.dispose();
    super.dispose();
  }

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
            Container(
              width: MediaQuery.of(context).size.width/2,
              alignment: Alignment.centerLeft,
              child: Text(" 사용할 이메일"),
            ),
            Container(
              width: MediaQuery.of(context).size.width/2,
              margin: EdgeInsets.only(bottom: 20.0),
              child: TextField(
                controller: _textEditingController,
                maxLines: 1,
                minLines: 1,
                decoration: InputDecoration(
                  hintText: "E-Mail",
                  filled: true,
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width/2,
              child: RaisedButton(
                child: Text("KakaO Login"),
                color: Colors.yellow[400],
                onPressed: () async{
                  this._loginType = "KAKAO";
                  final String _kToken = await kLogin.kakaOLogin(context: context);
                  if(_kToken == null) return;
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) => WillPopScope(
                      onWillPop: () => Future.value(false),
                      child: BottomSheet(
                        builder: (context) => Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("처리중"),
                              CircularProgressIndicator()
                            ],
                          )
                        ),
                        onClosing: (){},
                      ),
                    )
                  );
                  final bool _sendCheck = await air.createAirUser(
                    name: _textEditingController.text,
                    loginType: _loginType,
                    kToken: _kToken
                  );
                  if(!_sendCheck) return;
                  await _loginCheck.setId(_textEditingController.text);
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (BuildContext context) => MainPage(
                        userName: this._textEditingController.text,
                      )
                    ),
                    (route) => false
                  );
                  return;
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width/2,
              child: RaisedButton(
                child: Text("Naver Login(ing...)"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Ad{
  static final MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['flutterio', 'beautiful apps'],
    contentUrl: 'https://flutter.io',
    childDirected: false,
    testDevices: <String>[],
  );

  BannerAd myBanner;

  BannerAd createBn() => BannerAd(
    adUnitId: BannerAd.testAdUnitId, // Your ID
    size: AdSize.smartBanner,
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      print("BannerAd event is $event");
    },
  );


  InterstitialAd myInterstitial = InterstitialAd(
    adUnitId: InterstitialAd.testAdUnitId, // Your ID
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      print("InterstitialAd event is $event");
    },
  );

  RewardedVideoAd videoAd = RewardedVideoAd.instance;
//  videoAd..load(adUnitId: RewardedVideoAd.testAdUnitId, targetingInfo: targetingInfo)..show();
}

class MainPage extends StatefulWidget {
  final String userName;
  const MainPage({@required this.userName});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String userFcmToken;
  LoginCheck _loginCheck;
  List _airTable1;

  Ad _ad = new Ad();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    Future.microtask(() async{
      await firebaseCloudMessaging_Listeners();
      setState(() {});
      return;
    }).then((_) async{
      _airTable1 = await new Air().getTable1();
      setState(() {});
      return;
    }).then((_) async{
      if(_ad.myBanner == null) _ad.myBanner = _ad.createBn()..load();
      _ad.myBanner.show();
      return;
    });
    super.initState();
  }
  Future<void> firebaseCloudMessaging_Listeners() async{

    if (Platform.isIOS) iOS_Permission();

    print("AND Start");
    await _firebaseMessaging.getToken().then((token) async{
      print('token:'+token);
      userFcmToken = token;
      return;
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');

      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void iOS_Permission() {
    print("IOS Start");
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true)
    );
    _firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings){
        print("Settings registered: $settings");
      });
  }

  @override
  void didChangeDependencies() {
    if(_loginCheck == null){
      _loginCheck = Provider.of<LoginCheck>(context);
      return;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UserName [ ${widget.userName} ]"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async{
              await _loginCheck.deleteUser();
              await _ad.myBanner.dispose();
              return Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context)=> LoginCheckPage()
                ),
              );
            },
          )
        ],
      ),
      body: _airTable1 == null
      ? Center(
        child: CircularProgressIndicator(),
      )
      : GridView.builder(
        itemCount: _airTable1.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0
        ),
        padding: EdgeInsets.only(bottom: 60.0),
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: () async{
            if(_ad.myBanner != null){
              _ad.myBanner.dispose();
              _ad.myBanner = _ad.createBn()..load();
            }
            var check = await Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (BuildContext context) => DetailPage(
                    data: _airTable1[index]['fields'],
                  )
              )
            );
            if(check == null) _ad.myBanner.show();
            return;
          },
          child: GridTile(
            header: Container(
              padding: EdgeInsets.only(
                left: 10.0,
                top: 10.0
              ),
              child: Text(
                index.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ),
            child: Image.network(
              _airTable1[index]['fields']['Imgsrc'][0]['thumbnails']['large']['url'].toString(),
              fit: BoxFit.cover,
              cacheHeight: int.parse(_airTable1[index]['fields']['Imgsrc'][0]['thumbnails']['large']['height'].toString()),
              cacheWidth: int.parse(_airTable1[index]['fields']['Imgsrc'][0]['thumbnails']['large']['width'].toString()),
            ),
            footer: Container(
              padding: EdgeInsets.only(left: 10.0),
              color: Colors.white60,
              child: Text(
                _airTable1[index]['fields']['Title'].toString(),
              ),
            ),
          ),
        )
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final data;
  const DetailPage({this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.data['Title'].toString()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  this.data['Imgsrc'][0]['thumbnails']['large']['url'].toString(),
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.all(20.0),
                child: Text(this.data['Des'].toString()),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    MaterialButton(
                      color: Colors.red,
                      child: Container(
                        width: 60.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(Icons.shopping_cart,color: Colors.white,size: 16.0,),
                            Text("구매"),
                          ],
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      textColor: Colors.white,
                      onPressed: (){

                      },
                    ),
                    MaterialButton(
                      color: Colors.red,
                      child: Container(
                        width: 60.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(Icons.shopping_cart,color: Colors.white,size: 16.0,),
                            Text("구매"),
                          ],
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      textColor: Colors.white,
                      onPressed: (){

                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
