사전 준비 
1. webView 패키지 링크 : https://pub.dev/packages/flutter_webview_plugin
2. 안드로이드 폴더에서 메니패스트 파일에 해당 내용 수정해주세요
 <uses-permission android:name="android.permission.INTERNET" />

    <application
        android:name="io.flutter.app.FlutterApplication"
        android:label="naveropenapi"
        android:icon="@mipmap/ic_launcher"
        android:usesCleartextTraffic="true">
///////////////////////////////////////////////////////////////////////////////////////////


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart' as http;

void main() => runApp(
  MaterialApp(
    home: MainPage(),
  )
);


class MainPage extends StatelessWidget {
  List<String> typeList = ['드라마','판타지','서부', '공포','로맨스'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GridView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: typeList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0
        ),
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: (){
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DetailPage(dataIndex: (index+1),query: typeList[index],)
              )
            );
          },
          child: Container(
            color: Colors.grey[200],
            child: Center(
              child: Text("${typeList[index]}"),
            ),
          ),
        ),
      ),
    );
  }
}


class DetailPage extends StatefulWidget {

  int dataIndex;
  String query;

  DetailPage({this.dataIndex,this.query});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  Future fetch({String query, int genre, int display}) async{
    var res = await http.get(
      "https://openapi.naver.com/v1/search/movie.json?query=$query&display=$display&start=1&genre=$genre",
      headers: {
        "X-Naver-Client-Id":"xiquvEziJUkSU1Vtb6j1",
        "X-Naver-Client-Secret":"iPOlrpCizv"
      }
    );
    return json.decode(res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: fetch(query: widget.query, genre: widget.dataIndex, display: 20),
        builder: (BuildContext context, AsyncSnapshot snap){
          if(!snap.hasData) return Center(child: CircularProgressIndicator());
          List result = snap.data['items'];
          print(result);
          return ListView.builder(
            itemCount: result.length,
            itemBuilder:(context, int index){
              String title = result[index]['title'].toString().replaceAll("<b>","").replaceAll("<\/b>", "");
              return ListTile(
                leading: Text("${index+1}"),
                title: Text(title),
                subtitle: Text(result[index]['subtitle'].toString()),
                trailing: Icon(Icons.chevron_right),
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MovieDetailPage(
                        data: result[index],
                      )
                    )
                  );
                },
              );
            }
          );
        },
      ),
    );
  }
}


class MovieDetailPage extends StatelessWidget {
  dynamic data;
  MovieDetailPage({@required this.data})
   : assert(data != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height-80.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(this.data['image'].toString()),
                      fit: BoxFit.fitHeight
                    )
                  ),
                ), // 이미지
                Container(
                  child: Text(this.data['title'].toString().replaceAll("<b>","").replaceAll("<\/b>", "")),
                ), // 타이틀
                Container(
                  child: Text(
                    (this.data['subtitle'].toString() == null || this.data['subtitle'].toString() == "")
                      ? "SubTitle"
                      : this.data['subtitle'].toString()
                  ),
                ), // 서브타이틀
                Container(
                  child: Text(
                    " ${this.data['userRating'].toString()} / 10.00 "
                  ),
                ), // 별점
                Container(
                  child: Text(
                    "출시년도 : ${this.data['pubDate'].toString()} / 감독 : ${this.data['director'].toString()}"
                  ),
                ), // 출시년도 & 감독
                Container(
                  child: Text("출연진 : ${this.data['actor'].toString()}")
                ), // 배우
                RaisedButton(
                  child: Text("네이버에서 확인하기"),
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => WebviewScaffold(
                        url: this.data['link'].toString(),
                        withJavascript: true,
                      )
                    )
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
