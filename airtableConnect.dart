// * Example :
//  (1) AirTable airTable = AirTable(key: "YOUR_API_KEY", tableName: "TABLE_NAME");
//  (2) bool _check = await airTable.connect();
//  (3) print("_check $_check");
//  (4) print("Data : ${airTable.result}");

// * Dependencies - http: 

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AirTable{

  final String key;
  final String tableName;

  final String _endPoint = "https://api.airtable.com/v0/appwOWIDaRO0TiSDf/";

  Map<String, dynamic> _result;
  Map<String, dynamic> get result => this._result;
  set result(Map<String, dynamic> serverData){
    this._result = serverData;
    return;
  }

  AirTable({
    @required this.key,
    @required this.tableName,
  }):assert(key != null), assert(tableName != null);

  Future<bool> connect() async => Future.microtask(() async => await _net());

  Future<bool> _net() async{
    final String _url = _endPoint + this.tableName + "?api_key=" + this.key;
    try{
      final http.Response _res = await http.get(_url)
        .timeout(Duration(seconds: 8), onTimeout: () async => new http.Response("[]", 404));
      if(_res.statusCode != 200){
        this.result = {};
        return false;
      }
      final Map<String, dynamic> _resBody = json.decode(_res.body);
      this.result = _resBody;
      return true;
    }
    catch(e){
      this.result = {};
      return false;
    }
  }
}
