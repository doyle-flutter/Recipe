// 얕지만 가볍지는 않길 바라며
// 좀 더 쉬운 코드지만 적용할 수 있도록

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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

  // 체크 리스트 -> 화면 표시
  // 1. 서버와 연결중인가? -> 로딩
  // 2. 서버와 연결되어 값을 받았는가? -> 데이터 표시
  // 3. 서버와 연결이 불가능한가? -> 서버 체크 안내
  // 4. 서버로 요청하는 시간이 초과되었는가?

  // 좀 더 깊은 내용
  // 서버와 연결은 되었지만 서버에서 지연중인가?
  // 서버와 연결은 되었지만 서버가 충돌 또는 에러 등으로 다운되었는가?
  // 사용자의 핸드폰의 네트워크가 와이파이<->LTE 전환되면서 일시적으로 다운 된 것인가?
  // LTE 또는 와이파이 환경에서만 사용할 수 있는가 ?
  // 등...

  // 서버 상태에 따른 코드(Status Code)
  // 2xx connection
  // 3xx redirection MSG
  // 4xx request ERR
  // 5xx server ERR

  // 정상적으로 연결이 될 경우
  Future serverConnect() async{
    print("--------------------- serverConnect START ---------------------");
    var _res = await http.get('http://192.168.0.2:3000/data');
    print(_res);
    print(_res.request); // http://192.168.0.2:3000/data
    print(_res.headers);
    print(_res.body); // "DATA!"
    print(_res.statusCode); // 200
    print(_res.reasonPhrase); // OK
    print(_res.contentLength); // 7
    print(_res.isRedirect); // false
    print(_res.persistentConnection); // true
    print("--------------------- serverConnect END ---------------------");

  }

  // 서버는 동작하지만 해당하는 주소가 없는 경우 또는 주소와 연결이 안될 경우(서버의 특정 주소를 찾지 못할 경우)
  Future notFound() async{
    print("--------------------- notFound ---------------------");
    var _res = await http.get('http://192.168.0.2:3000/date');
    print(_res);
    print(_res.request); // http://192.168.0.2:3000/date
    print(_res.headers);
    print(_res.body); // 404 html
    print(_res.statusCode); // 404
    print(_res.reasonPhrase); // Not Found
    print(_res.contentLength);
    print(_res.isRedirect); // false
    print(_res.persistentConnection); // true
    print("--------------------- notFound END ---------------------");
  }

  // 서버가 종료 되었을 경우(서버를 찾을 수 없을 경우)
  Future serverNotWork() async{
    print("--------------------- serverNotWork ---------------------");
    http.Response _res;
    try{
      _res = await http.get('');
    }
    catch(e){
      _res = http.Response("server ERR", 500);
    }
    print(_res);
    print(_res.request); // null
    print(_res.headers); // {}
    print(_res.body); // server ERR
    print(_res.statusCode); // 500
    print(_res.reasonPhrase); // null
    print(_res.contentLength);
    print(_res.isRedirect); // false
    print(_res.persistentConnection); // true
    print("--------------------- serverNotWork END ---------------------");
  }

  Future<List> fetchDelay() async{
    // timeout을 통해 클라이언트의 지연 또는 서버에서의 지연을 체크할 수 있습니다
    // 좀 더 정확한 구분을 위해서는 서버에서 지연에 대한 값을 발송해야하며
    // 클라이언트는 timeout을 클라이언트의 연결 요청에 대한 지연으로 활용해야합니다
    print("--------------------- fetchDelay ---------------------");
    const String _url = "http://192.168.0.2:3000/dl";
    http.Response _res;
    _res =  await http.get(_url).timeout(
        Duration(seconds: 3),
        onTimeout: (){
          return http.Response('[{"data":"Req Time OUT"}]', 408); // Key 값은 반드시 "" 쌍따옴표를 사용
        }
    );
    print(_res);
    print(_res.request); // null
    print(_res.headers); // {}
    print(_res.body); // [{"data":"Req Time OUT"}]
    print(_res.statusCode); // 408
    print(_res.reasonPhrase); // null
    print(_res.contentLength);
    print(_res.isRedirect); // false
    print(_res.persistentConnection); // true
    print("--------------------- fetchDelay END ---------------------");
    final List _result = json.decode(_res.body);
    return _result; // ["data":{ ... }]
  }

  Future<List> connect() async{
    const String _url = "http://192.168.0.2:3000/dl"; // || /data
    http.Response _res;
    try{
      _res =  await http.get(_url).timeout(
          Duration(seconds: 3),
          onTimeout: (){
            return http.Response('[{"data":"Req Time OUT"}]', 408);
          }
      );
    }
    catch(e){
      _res = http.Response("server ERR", 500);
    }
    if(_res.statusCode == 500) return [{"data":null, "err":"ServerDown"}];
    if(_res.statusCode == 408) return [{"data":null, "err":"Time Out"}];
    final List _result = json.decode(_res.body);
    return _result; // ["data":{ ... }]
  }

  List fetchData;

  @override
  void initState() {
    // * Future 가 비동기니까 두번째 Future는 첫 Future 가 종료되면 실행될까??
    // + delayed 3초 후에 바로 밑의 첫번째 Future.microtask 가 실행될까?
    Future.delayed(
      Duration(seconds: 3),
      () async{
        fetchData = await connect();
        setState(() {});
      }
    );
    Future.microtask(() async{
      print("Delay Play");
      fetchData = await connect();
      setState(() {});
    });
    Future.microtask(() async{
      print("Microtask Play");
      await serverConnect();
      await notFound();
      // await serverNotWork(); // 테스트 : 서버 종료 후 실행
      await fetchDelay();
      setState(() {});
    });

    //* Future 들을 반드시 순서를 보장하려면 어떻게 해야할까?
    Future.microtask(() async{
      print("2-1. Microtask Play");
      await serverConnect();
      await notFound();
      // await serverNotWork(); // 테스트 : 서버 종료 후 실행
      await fetchDelay();
      setState(() {});
      return;
    }).then((_) async{
      print("2-2. Delay Play");
      fetchData = await connect();
      setState(() {});
    });

    // 추가로 생각하면 좋은 내용
    // + delayed 실행 후 microtask 또는 microtask 실행 후 delayed 의 경우 어떻게 해결할까?(다음 단계와 순서만 맞추고 싶을 때)
    // + 첫번째 Future.xxx 의 결과를 두번째 Future.xxx 로 전이(전달) 할 수는 없을까?
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: this.fetchData == null
          ? Text("Loading...", style: TextStyle(color: Colors.red),)
          :  fetchData[0]['data'] == null
              ? Text(fetchData[0]['err'].toString(), style: TextStyle(color: Colors.blue))
              : Text("${fetchData[0]['data'].toString()}"),
      ),
    );
  }
}
