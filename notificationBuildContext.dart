import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    home: MyApp(),
  )
);

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  String value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: NotificationListener<MyNotificationModel>(
          onNotification: (MyNotificationModel my){
            setState(() {
              value = my.titleView();
            });
            return false;
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(value ?? '값1'),
              Builder(
                builder: (BuildContext context2){
                  return FlatButton(
                    child: Text("Notification"),
                    onPressed: (){
                      MyNotificationModel(title: "값2").dispatch(context2);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 분리한 로직
class MyNotificationModel extends Notification{
  String title;
  MyNotificationModel({this.title});

  String titleView(){
    return "'${this.title}'(으)로 변경하였습니다";
  }
}



// 예제 2
class MyApp3 extends StatefulWidget {
  @override
  _MyApp3State createState() => _MyApp3State();
}

class _MyApp3State extends State<MyApp3> {

  String value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(value ?? "MyApp3&MyApp4"),),
      body: NotificationListener<MyNotificationModel>(
        onNotification: (MyNotificationModel my2){
          print(my2.titleView());
          setState(() {
            this.value = my2.titleView();
          });
          return true;
        },
        child: MyApp4(),
      ),
    );
  }
}

// 예제 2
class MyApp4 extends StatefulWidget {
  @override
  _MyApp4State createState() => _MyApp4State();
}

class _MyApp4State extends State<MyApp4> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlatButton(
        child: Text("MyApp4 Btn"),
        onPressed: (){
          MyNotificationModel(title: "안녕하세요").dispatch(context);
        },
      ),
    );
  }
}



// 예제 3
class MyApp2 extends StatefulWidget {
  @override
  _MyApp2State createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ScrollNotification"),),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification sc){
          print(sc.metrics.pixels);
          return true;
        },
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Start"),
                Container(
                  height: 1000.0,
                  color: Colors.red[100],
                ),
                Text("End"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
