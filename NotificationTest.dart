import 'package:flutter/material.dart';

class ListenerPage extends StatefulWidget {
  @override
  _ListenerPageState createState() => _ListenerPageState();
}

class _ListenerPageState extends State<ListenerPage> {

  ScrollController ct = new ScrollController();

  @override
  void didChangeDependencies() {
    ct.addListener((){
      print("Call");
    });
    super.didChangeDependencies();
  }

  
  @override
  Widget build(BuildContext context) {
//    return Scaffold(
//      body: NotificationListener<ScrollNotification>(
////        onNotification: (bool result){
////          print('$result What ? ');
////          return result;
////        },
//        onNotification: (ScrollNotification sc){
//          // print(sc);
//
////          print(sc.metrics.pixels);
////          print(sc.metrics.maxScrollExtent);
//          if(sc.metrics.pixels == sc.metrics.maxScrollExtent){
//            print("끝까지 내려왔습니다");
//          }
//          return true;
//        },
//        child: ListView.builder(
//          itemCount: 10,
//          //controller: ct,
//          itemBuilder: (context, int index){
//            return Container(
//              height: 200.0,
//              child: Center(
//                child: Text(index.toString()),
//              ),
//            );
//          }
//        ),
//      ),
//    );
//    return Scaffold(
//      body: NotificationListener<TimeNotification>(
//        onNotification: (TimeNotification my){
//          print(my.time);
//          return true;
//        },
//        child: Center(
//          child: RaisedButton(
//            child: Text("asd"),
//            onPressed: (){
//              print("Click");
//              setState(() {
//                TimeNotification(time: "값")..dispatch(context);
//              });
//            },
//          ),
//        ),
//      ),
//    );
  }
}


class TimeNotification extends Notification {
  final String time;

  const TimeNotification({this.time});
}


class Timer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    print(context);
//    print(context.hashCode);
//    print(context.owner.toString());
    return Scaffold(
      appBar: AppBar(
        title: Builder(
          builder: (BuildContext context){
            print(context.widget.toString());
            return FlatButton(
              child: Text("APPBAR"),
              onPressed: (){
                Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text("AAAPPBAR"),
                    )
                );
              },
            );
          },
        ),
      ),
//      body: NotificationListener<TimeNotification>(
//          child: Builder(
//            builder: (BuildContext context) =>
//             FlatButton(
//              child: Text("Get time!"),
//              onPressed: () {
//                final time = DateTime.now().toIso8601String();
//                TimeNotification(time: time)..dispatch(context);
//              },
//            ),
//          ),
//          onNotification: (notification) {
//            print(notification.time);
//            return true;
//          }),

//      body: ListView.builder(
//        itemCount: 4,
//        itemBuilder: (BuildContext context, int index){
////          print(context);
////          print(context.hashCode);
////          print(context.widget);
//          return Container();
//        }
//      ),

//      body: Builder(
//        builder: (BuildContext context){
//          print(context.widget);
//          print(context.owner.runtimeType);
//          return Container(
////            width: MediaQuery.of(context).size.width,
////            height: MediaQuery.of(context).size.height,
//            child: FlatButton(
//              child: Text("ASD"),
//              onPressed: (){
//                print(context.widget);
//              },
//            ),
//          );
//        },
//      )
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FlatButton(
          child: Text("ASD2"),
          onPressed: (){
            print(context.widget);
          },
        ),
      ),
    );
  }
}



class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<MyNoti>(
        onNotification: (MyNoti my){
          print(my.title);
          return true;
        },
        child: Center(
          child: Page2(),
        ),
      ),
    );
  }
}

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text("Click"),
      onPressed: (){
        print(context.widget);
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text("Hi"),
          )
        );
        MyNoti(title: "Click").dispatch(context);
      },
    );
  }
}


class MyNoti extends Notification{
  String title;
  MyNoti({this.title});
}

class Page3 extends StatefulWidget {
  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  @override
  Widget build(BuildContext context) {
    print(context.widget);
    return Scaffold(
      body: NotificationListener<MyNoti>(
        onNotification: (MyNoti my2){
          print(my2.title);
          return false;
        },
        child: Center(
          child: Builder(
            builder: (BuildContext context2){
              return FlatButton(
                child: Text("Click2"),
                onPressed: (){
                  print(context2.widget);
                  Scaffold.of(context2).showSnackBar(
                    SnackBar(
                      content: Text("Click2"),
                    )
                  );
                  MyNoti(title: "Click2").dispatch(context2);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}


class Page4Err extends StatefulWidget {
  @override
  _Page4ErrState createState() => _Page4ErrState();
}

class _Page4ErrState extends State<Page4Err> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<MyNoti>(
        onNotification: (MyNoti my2){
          print(my2.title);
          return false;
        },
        child: Center(
          child: FlatButton(
            child: Text("Click4ERR"),
            onPressed: (){
              print(context.widget);
//              Scaffold.of(context).showSnackBar(
//                  SnackBar(
//                    content: Text("Click4ERR"),
//                  )
//              );
//              MyNoti(title: "Click4ERR").dispatch(context);
            },
          ),
        ),
      ),
    );
  }
}
