// main.dart 별도

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AngelDeep extends StatefulWidget {
  @override
  _AngelDeepState createState() => _AngelDeepState();
}

class _AngelDeepState extends State<AngelDeep> {

  FetchAll _fetchAll = new FetchAll();
  DeepModel _deepModel;

  @override
  void initState() {
    Future.microtask(() async{
      _deepModel = await _fetchAll.deepData();
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Angel",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 20.0),),
            Container(
              padding: EdgeInsets.all(20.0),
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey)
              ),
              child: _deepModel == null
              ? Text("Loding ...")
              : Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text("1. deepModel.data : ${_deepModel.data} \n"),
                      Text("2. deepModel.datas : ${_deepModel.datas.toString()} \n"),
                      Text("3. deepModel.pathId : ${_deepModel.pathId.toString()} \n"),
                      Text("4. deepModel.headers :${_deepModel.headers.toString()} \n"),
                      Text("5. deepModel.newsGroupBasic : ${_deepModel.newsGroupBasic.toString()} \n"),
                      Text("6. deepModel.newsGroupSubId : ${_deepModel.newsGroupSubId.toString()} \n"),
                      Text("7. deepModel.newsGroupSubId2 : ${_deepModel.newsGroupSubId2.toString()} \n"),
                      Text("8. deepModel.postMapData : ${_deepModel.postMapData.toString()} \n"),
                    ],
                  ),
              )
            )
          ],
        ),
      ),
    );
  }
}

class FetchAll{
  final String _url = 'http://127.0.0.1:3000';

  Future<DeepModel> deepData() async{
    Map<String, dynamic> json = {
      "basic" : _parseHTML(res: await http.get("$_url/")),
      "data" : _parse<String>(res: await http.get("$_url/data")),
      "datas" : _parse<List>(res: await http.get("$_url/datas")),
      "pathId" : _parse(res: await http.get("$_url/path/123")),
      "headers" : _parse(res: await http.get("$_url/headers")),
      "newsGroupBasic" : _parse(res: await http.get("$_url/news/123")),
      "newsGroupSubId" : _parse(res: await http.get("$_url/news/123/subId")),
      "newsGroupSubId2" : _parse(res: await http.get("$_url/news/123/subId2")),
      "postMapData" : _parse(res: await http.post("$_url/datas/map",body: {'data':"Flutter & Angel"}))
    };
    return DeepModel.toMap(json: json);
  }

  T _parse<T>({http.Response res}) => json.decode(utf8.decode(res.bodyBytes));
  String _parseHTML({http.Response res}) => utf8.decode(res.bodyBytes);

}

class DeepModel{
  String basic;
  String data;
  List datas;
  Map<String, dynamic> pathId;
  Map<String, dynamic> headers;
  Map<String, dynamic> newsGroupBasic;
  Map<String, dynamic> newsGroupSubId;
  Map<String, dynamic> newsGroupSubId2;
  Map<String, dynamic> postMapData;

  DeepModel({
    @required this.basic,
    @required this.data,
    @required this.datas,
    @required this.pathId,
    @required this.headers,
    @required this.newsGroupBasic,
    @required this.newsGroupSubId,
    @required this.newsGroupSubId2,
    @required this.postMapData
  });

  factory DeepModel.toMap({@required Map<String, dynamic> json})
    => new DeepModel(
        basic: json['basic'],
        data: json['data'],
        datas: json['datas'],
        pathId: json['pathId'],
        headers: json['headers'],
        newsGroupBasic: json['newsGroupBasic'],
        newsGroupSubId: json['newsGroupSubId'],
        newsGroupSubId2: json['newsGroupSubId2'],
        postMapData: json['postMapData']
      );
}
