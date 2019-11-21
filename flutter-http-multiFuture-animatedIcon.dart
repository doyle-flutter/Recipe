import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() async => runApp(
  MaterialApp(
    home: MyApp(),
  )
);

class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin{


  Future getst() async{
    return await Future.delayed(
      Duration(seconds: 3),
        () => "asd"
    );
  }
  Future getit() async{
    return await Future.delayed(
        Duration(seconds: 1),
            () => 123
    );
  }
  Future getData() async{
    String url = "https://jsonplaceholder.typicode.com/photos";
    final res = await http.Client().get(url);
    return parse(res.body);
  }

  parse(String responseBody){
    final parseData = json.decode(responseBody).cast<Map<String, dynamic>>();
    print("************Start parsed ****************");
    print(responseBody);
    print("************parsed END****************");
    return parseData.map<Photo>((v) => Photo.fromJson(v)).toList();
  }

  AnimationController _iconAnim;
  bool _isAnim;
  StreamController _sc;

  @override
  void initState() {
    _isAnim = false;
    _iconAnim = new AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200
      )
    );
    _sc = StreamController();
    getData().then((v){print(v[0].title);_sc.add(v);});
    super.initState();
  }

  @override
  void dispose() {
    _iconAnim?.dispose();
    _sc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: EdgeInsets.only(
          top: 50.0
        ),
        child: Column(
          children: <Widget>[
            IconButton(
              icon: AnimatedIcon(
                icon: AnimatedIcons.arrow_menu,
                progress: _iconAnim,
              ),
              onPressed: (){
                (!_isAnim) ? _iconAnim.forward() : _iconAnim.reverse();
                _isAnim = !_isAnim;

              },
            ),
            StreamBuilder(
              stream: _sc.stream,
              builder: (context, snap){
                if(snap.hasData){
                  return Container(
                    width: 50,
                    height: 50,
                    child: Text(snap.data[0].title.toString()),
                  );
                }
                else{
                  return Container(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            FutureBuilder(
              future: getst(),
              builder: (context, snap1){
                return Text(snap1.data.toString());
              },
            ),
            FutureBuilder(
              future: getit(),
              builder: (context, snap2){
                return Text(snap2.data.toString());
              },
            ),
            FutureBuilder(
              future: Future.wait(
                [
                  getst(),
                  getit(),
                  getData(),
                ]
              ),
              builder: (context, snaplist){
                if(snaplist.hasData){
                  return Column(
                    children: <Widget>[
                      Text(snaplist.data[0].toString()),
                      Text(snaplist.data[1].toString()),
                      Container(
                        width: 500,
                        height: 200,
                        child: ListView.builder(
                          itemCount:(snaplist.data[2].length > 10) ? 10 : snaplist.data[2].length,
                          itemBuilder: (BuildContext context, int index){
                            return Container(
                                width: 500,
                                child: Text(snaplist.data[2][index].id.toString())
                            );
                          }
                        ),
                      )
                    ],
                  );
                }
                else{
                  return Container(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}


class Photo {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photo({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      albumId: json['albumId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
    );
  }
}
