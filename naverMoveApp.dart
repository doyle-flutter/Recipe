import 'dart:convert';
import 'package:flutter/material.dart';
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
        "X-Naver-Client-Secret":"3BWmTiM7eS"
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
          return ListView.builder(
            itemCount: result.length,
            itemBuilder:(context, int index){
              return ListTile(
                leading: Text("${index+1}"),
                title: Text(result[index]['title'].toString()),
                subtitle: Text(result[index]['subtitle'].toString()),
                trailing: Icon(Icons.chevron_right),
              );
            }
          );
        },
      ),
    );
  }
}


