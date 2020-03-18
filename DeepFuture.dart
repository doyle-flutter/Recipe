// 연속 사용 및 예외 처리


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  int resultInt;

  Future<int> fetch() async{
    return await Future.delayed(Duration(seconds: 4), ()async{
      resultInt = 44;
      return 44;
    });
  }

  Future<String> firstFuture() async{
    return await Future.delayed(Duration(seconds: 1), ()async{
      return "첫 번째";
    });
  }
  Future<String> twoFuture() async{
    return await Future.delayed(Duration(seconds: 1), ()async{
      return "두 번째";
    });
  }
  Future<String> thrFuture() async{
    return await Future.delayed(Duration(seconds: 1), ()async{
      return "세 번째";
    });
  }

  Future<String> errFuture() async{
    throw 'err';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Futures'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              child: Text("Future Start"),
              onPressed: () async{
                int result = await fetch().timeout(Duration(seconds: 2),onTimeout: (){
                  resultInt = 22;
                  return 22;
                });
                print("result : $result");
                print("resultInt : $resultInt");

              },
            ),
            RaisedButton(
              child: Text("Future After"),
              onPressed: (){
                print("After resultInt : $resultInt");
              },
            ),

            RaisedButton(
              child: Text("Future ERR 1"),
              onPressed: () async{
                String result = await errFuture().catchError((e){
                  return 'err';
                });
                print(result);
              },
            ),
            RaisedButton(
              child: Text("Many ERR 2"),
              onPressed: () async{
                String result = await errFuture()
                  .then((String value1) async{
                    return value1;
                  },onError:(e){
                    return "Catch ERR";
                  });
                print(result);
              },
            ),


            // 순서가 중요할 때
            RaisedButton(
              child: Text("Many Future Play 1"),
              onPressed: () async{
                String result1 = await firstFuture();
                print(result1);

                String result2 = await twoFuture();
                print(result2);

                String result3 = await thrFuture();
                print(result3);
              },
            ),

            // 앞의 실행 한 내용의 값을 다음 함수에 사용할 때
            RaisedButton(
              child: Text("Many Future Play 2"),
              onPressed: () async{
                String result = await firstFuture().then((String value1) async{
                  return await twoFuture().then((String value2) async{
                    return await thrFuture().then((String value3){
                      return "$value1 $value2 $value3";
                    });
                  });
                });
                print(result);
              },
            ),

            RaisedButton(
              child: Text("Many Future Play 3"),
              onPressed: () async{
                String result = await firstFuture()
                  .then(
                    (String value1) async{
                      print("First $value1");
                      return value1;
                    },
                    onError: (e){
                      print("FirstFuture1 ERR");
                      return "ERR";
                    }
                  )
                  .then(
                    (String value2){
                      print("Two $value2");
                      return "$value2 두 번째";
                    },
                    onError: (e){
                      print("FirstThenFuture2 ERR");
                      return "ERR2";
                    }
                  )
                  .then(
                    (String value3){
                      print("Thr $value3");
                      return '$value3 세 번째';
                    },
                    onError: (e){
                      print("FirstThenFuture2 ERR");
                      return "ERR2";
                    }
                  )
                .catchError((e){
                  print("chanong Catch ERR");
                  return "CatchERR";
                });
                print("최종 : $result");
              },
            ),
          ],
        ),
      )
    );
  }
}
