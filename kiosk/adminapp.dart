import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(
  home: MainPage(),
  debugShowMaterialGrid: false,
  debugShowCheckedModeBanner: false,
  showSemanticsDebugger: false,
));

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with WidgetsBindingObserver{

  IO.Socket _socket;
  bool socketConnectionCheck = false;
  List<ImageModel> _imgs;
  bool reFetchCheck = false;
  TextEditingController _imgUrlValue = new TextEditingController(text: "");
  final MethodChannel _nativeCall = const MethodChannel("samples.flutter.dev/action");
  final String _endPoint = "http://:3000";
  bool _playBtn = false;

  Future<void> socketCheck() async => Stream.periodic(Duration(seconds: 2),(t) => {
    _socket.connected ? this.socketConnectionCheck = true: this.socketConnectionCheck = false
  })..listen((event){
    setState((){});
  });

  Future<List<ImageModel>> kioskDataFetch() async{
    final String _url = "$_endPoint/imgs";
    try{
      http.Response res = await http.get(_url)
          .timeout(Duration(seconds: 5), onTimeout: () async => http.Response("[]",404));
      if(res.statusCode != 200) return [];
      final List<dynamic> _json = json.decode(res.body);
      return this.parseData(data: _json);
    }
    catch(e){
      return [];
    }
  }

  List<ImageModel> parseData({List data}) => data.map((json) => ImageModel.fromJson(json)).toList();

  Future<void> callFunc() async{
    dynamic number = <String, dynamic>{"number":"010-1234-4321"};
    await _nativeCall.invokeMethod("callFunc", number);
    return;
  }

  Future camFunc() async {
    await _nativeCall.invokeMethod("camFunc");
    return;
  }

  Future<bool> uploadImgUrl({@required String src}) async{
    final String _url = "$_endPoint/img/uploadimgurl";
    final _body = {"src":"src"};
    try{
      http.Response res = await http.post(_url, body: json.encode(_body))
        .timeout(Duration(seconds: 5), onTimeout: () async => http.Response("false",404));
      if(res.statusCode != 200) return false;
      final List<dynamic> _json = json.decode(res.body);
      return true;
    }
    catch(e){
      return false;
    }
  }

  Color socketCheckColor() => _socket == null ? Colors.white : this.socketConnectionCheck ? Colors.blue : Colors.red;
  String socketCheckComments() => _socket == null ? "연결 중입니다" : this.socketConnectionCheck ? "Flutter Kiosk Admin APP" : "연결 시도 중입니다";

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    Future.microtask(() async{
      _socket = IO.io(
        _endPoint,
        <String, dynamic>{
          'transports': ['websocket'],
          'autoConnect': false,
        })..connect();
      return;
    })
    .then((_) async => await this.socketCheck())
    .then((_) async => _socket.emit("platformCheck", "${DateTime.now()} : ${Platform.isAndroid ? "Android 접속" : "IOS 접속"}"))
    .then((_) async => setState((){}))
    .then((_) async => _imgs = await this.kioskDataFetch())
    .then((_) async => setState((){}))
    .catchError((e) async{
      return;
    }, test: (e) => false);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch(state){
      case AppLifecycleState.resumed:{
        print("resumed");
        _socket.emit("platformCheck", "${DateTime.now()} : ${Platform.isAndroid ? "Android 재접속" : "IOS 재접속"}");
        Future.microtask(() => setState(() => reFetchCheck = true))
          .then((_) async => _imgs = await kioskDataFetch())
          .then((_) => setState(() => reFetchCheck = false))
          .catchError((e) async {
            setState(() => reFetchCheck = true);
            return;
          }, test: (e) => false);

        break;
      }
      case AppLifecycleState.inactive:{
        print("inactive");
        break;
      }
      case AppLifecycleState.detached:{
        print("detached");
        break;
      }
      case AppLifecycleState.paused:{
        _socket.emit("platformCheck", "${DateTime.now()} : ${Platform.isAndroid ? "Android 종료" : "IOS 종료"}");
        print("paused");
        break;
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    print("종료");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: this.socketCheckColor(),
        title: Text(this.socketCheckComments()),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () async => showModalBottomSheet(context: context, builder: (BuildContext context) => BottomSheet(
              onClosing: () => false,
              builder: (BuildContext context) => Container(
                padding: EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          "연결 오류 해결 방법",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text("1. 서버가 정상 구동 중인지 확인합니다")
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text("2. 사용하는 모바일 기기의 인터넷을 확인합니다")
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text("3. 서버도 정상적으로 동작하며, 모바일 기기에도 문제가 없다면 서버PC를 재부팅합니다")
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        child: MaterialButton(
                          child: Text("문의 전화 연결"),
                          color: Colors.red[400],
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                          onPressed: this.callFunc,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )),
          )
        ],
      ),
      body: _body(),
      drawer: Drawer(
        child: ListTile(
          title: Text("이미지 관리"),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => ImgAdminPage()
            )
          ),
        ),
      ),
    );
  }

  Widget _body() => bodyWrapper();
  Widget bodyWrapper() => SafeArea(
    child: SingleChildScrollView(
      child: Builder(
        builder: (BuildContext context) => Container(
          width: MediaQuery.of(context).size.width,
          child: this.reFetchCheck
            ? _reFetchErrBody(context: context)
            : this.socketConnectionCheck
              ? _connectionBody()
              : _disConnectionBody(),
          // child: _connectionBody(),
        ),
      ),
    ),
  );
  Widget _disConnectionBody() => Builder(
    builder: (BuildContext context) => Container(
      height: MediaQuery.of(context).size.height-AppBar().preferredSize.height,
      child: Center(
        child: Text("네트워크 또는 서버 연결을 확인해주세요"),
      ),
    ),
  );
  Widget _connectionBody() => Builder(
    builder: (BuildContext context) => Container(
      child: _imgs.isEmpty
        ? uploadWidget()
        : viewWidget()
    ),
  );
  Widget uploadWidget() => Builder(
    builder: (BuildContext context) => Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Text("이미지를 업로드할 수 있습니다"),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  child: Text("갤러리 및 카메라"),
                ),
                MaterialButton(
                  child: Text("URL 업로드"),
                  onPressed: () => showBottomSheet(
                    context: context,
                    builder: (BuildContext context) => BottomSheet(
                      onClosing: () => false,
                      builder: (context) => Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width/1.50,
                              margin: EdgeInsets.symmetric(vertical: 20.0),
                              child: TextField(
                                controller: _imgUrlValue,
                                maxLines: 1,
                                minLines: 1,
                                decoration: InputDecoration(
                                  filled: true,
                                  hintText: "ex) https://www.image..."
                                ),
                              )
                            ),
                            IgnorePointer(
                              ignoring: false,
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    MaterialButton(
                                      color: Colors.blue,
                                      textColor: Colors.white,
                                      child: Text("업로드"),
                                      onPressed: () async{
                                        if(_imgs.length >= 3){
                                          Scaffold.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text("이미지는 3개이상 등록할 수 없습니다"),
                                            )
                                          );
                                          return;
                                        }
                                        final bool _check = await this.uploadImgUrl(src: _imgUrlValue.text);
                                        print(_check);
                                        _imgUrlValue.text = "";
                                        setState(() {});
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    MaterialButton(
                                      child: Text("취소"),
                                      textColor: Colors.white,
                                      color: Colors.red,
                                      onPressed: () => Navigator.of(context).pop(),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
  Widget viewWidget() => Builder(
    builder: (BuildContext context) => Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              children: _imgs.map((ImageModel e) => Draggable(
                  feedback: Container(
                    color: Colors.red,
                    width: MediaQuery.of(context).size.width/_imgs.length,
                    height: MediaQuery.of(context).size.width/_imgs.length,
                  ),
                  data: e,
                  onDragCompleted: (){},
                  onDragEnd: (de){},
                  childWhenDragging: Opacity(
                    opacity: 0.5,
                    child: Container(
                      width: MediaQuery.of(context).size.width/_imgs.length,
                      height: MediaQuery.of(context).size.width/_imgs.length,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(e.src),
                          fit: BoxFit.cover
                        )
                      ),
                      child: Text(
                        _imgs.indexOf(e).toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0
                        ),
                      ),
                    ),
                  ),
                  child: DragTarget(
                    onAccept: (ImageModel i) async{
                      int selectIndex = _imgs.indexOf(i);
                      int targetIndex = _imgs.indexOf(e);
                      bool _check = await showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          content: Text("변경하시겠습니까?"),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("변경"),
                              onPressed: () => Navigator.of(context).pop(true),
                            ),
                            FlatButton(
                              child: Text("취소"),
                              onPressed: () => Navigator.of(context).pop(false),
                            )
                          ],
                        )
                      ) ?? false;
                      if(!_check) return;
                      http.Response _res = await http.post("$_endPoint/img/change/index/$selectIndex/$targetIndex}");
                      bool _serverCheck = json.decode(_res.body);
                      if(_serverCheck){
                        setState(() {
                          _imgs.removeAt(selectIndex);
                          _imgs.insert(targetIndex, i);
                        });
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text("변경"),
                          )
                        );
                      }
                      return;
                    },
                    builder:(context, List<ImageModel> i, k) => Container(
                      width: MediaQuery.of(context).size.width/_imgs.length,
                      height: MediaQuery.of(context).size.width/_imgs.length,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(e.src),
                              fit: BoxFit.cover
                          )
                      ),
                      child: Text(
                        _imgs.indexOf(e).toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0
                        ),
                      ),
                    ),
                  ),
                )).toList(),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            child: FloatingActionButton(
              child: Icon(_playBtn ? Icons.play_arrow : Icons.stop),
              onPressed: () async{
                _socket.emit("onStart", _playBtn);
                setState((){
                  _playBtn = !_playBtn;
                });
              },
            )
          ),
        ],
      ),
    ),
  );
  Widget _reFetchErrBody({@required BuildContext context}) => Container(
    height: MediaQuery.of(context).size.height,
    child: Center(
      child: Text("다시 불러오기에 실패하였습니다, 재접속해주세요"),
    ),
  );
}

class ImageModel{
  int id;
  String src;
  ImageModel({@required this.id, @required this.src});

  factory ImageModel.fromJson(json) => ImageModel(
    id: json['id'] as int,
    src: json['src'] as String
  );
}

class ImgAdminPage extends StatefulWidget {
  @override
  _ImgAdminPageState createState() => _ImgAdminPageState();
}

class _ImgAdminPageState extends State<ImgAdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
