import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

// HTTP
// GET / POST
// ... PUT, DELETE, HEAD, PATCH, OPTIONS, TRACE, CONNECT

// URL : http(s)://IP:Port/path1/path2?queryString=""&queryqueryString2=""
//       -> http(s)://domain.com(net,shop....)/path1/path2?queryString=""&queryqueryString2=""

// Request(SEND) : Encode - String
// Response(GET) : Decode - Map<String, dynamic> || List

// 1. GET
// - url    // String
// - header // Map<String, String>

// 2. POST
// - url    // String
// - header // Map<String, String>
// - body   // Map<String, dynamic> || json.encode() : String
//    xxx - -> Map<String, dynamic>
//    non - -> json.encode( Map<String, dynamic> ) : String

/// 1. GET ///////////////////
/// USER Check : HEADER
/// DATA : URL

/// 1-1
Future httpGet() async{
  var res = await http.get(
    "http://192.168.1.0:3000",
    headers: <String, String>{ "TYPE" : "Value" }
  );
  print(res.headers);
  print(res.body);
  print(json.decode(res.body));
}
/// 1-2-1
Future httpGetForm({@required String url, @required Map<String, String> header}) async{
  var res = await http.get(url, headers: header);
  print(res.headers);
  print(res.body);
  print(json.decode(res.body));
}
/// 1-2-2
Future httpGetConnect() async{
  String url = "";
  Map<String, String> header = {"TYPE":"VALUE"};
  var res = await httpGetForm(url: url, header: header);
  print(res);
}

/// 2. POST ///////////////////
/// USER Check : HEADER
/// DATA : Body

/// 2-1-1
Future httpPost() async{
  var res = await http.post(
    "http://192.168.1.0:3000",
    headers: <String, String>{ "TYPE" : "Value" },
    body: json.encode( <String, dynamic>{ "KEY" : ["value1", 2,3,4, false] } ),
    //  "application/json"
    // (defaults) encoding: Encoding.getByName('utf8')
  );
  print(res.headers);
  print(res.body);
  print(json.decode(res.body));
}

Future httpPostXxx() async{
  var res = await http.post(
    "http://192.168.1.0:3000",
    headers: <String, String>{ "TYPE" : "Value" },
    body: <String, dynamic>{ "KEY" : ["value1", 2,3,4, false] },
    //  "application/x-www-form-urlencoded"
    // (defaults) encoding: Encoding.getByName('utf8')
  );
  print(res.headers);
  print(res.body);
  print(json.decode(res.body));
}

/// 2-2-1
Future httpPostForm({@required String url, @required Map<String, String> header, @required Map<String, dynamic> body}) async{
  var res = await http.post(url, headers: header,body: json.encode(body),encoding: Encoding.getByName('utf8'));
  print(res.headers);
  print(res.body);
  print(json.decode(res.body));
}

Future httpPostXxxForm({@required String url, @required Map<String, String> header, @required Map<String, dynamic> body}) async{
  var res = await http.post(url, headers: header,body: body);
  print(res.headers);
  print(res.body);
  print(json.decode(res.body));
}

/// 2-2-2
Future httpPostConnect() async{
  String url = "";
  Map<String, String> header = { "TYPE" : "VALUE" };
  Map<String, dynamic> body = { "KEY" : [ "value", 1, 2, 34, 5, {}, true] };
  var res = await httpPostForm(url: url, header: header, body: body);
  print(res);
}
Future httpPostXxxConnect() async{
  String url = "";
  Map<String, String> header = { "TYPE" : "VALUE" };
  Map<String, dynamic> body = { "KEY" : [ "value", 1, 2, 34, 5, {}, true] };
  var res = await httpPostXxxForm(url: url, header: header, body: body);
  print(res);
}
