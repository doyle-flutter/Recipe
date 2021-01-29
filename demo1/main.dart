// With Airtable
// - pub : (1) http (2) provider

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GestureBinding.instance.resamplingEnabled = true;
  return runApp(MultiProvider(
    providers: [ChangeNotifierProvider<Data>(create: (_) => Data())],
    child: MaterialApp(
      home: MyApp(),
    ),
  ));
}

class Data with ChangeNotifier {
  List _personData;
  get personData => this._personData;
  set personData(updateData) {
    this._personData = updateData;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  TextEditingController _txt = TextEditingController(text: '');
  Future<void> search(
      {@required BuildContext context, @required Data data}) async {
    if (this._txt.text == "")
      return await showDialog<void>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                content: Text("입력해주세요"),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text("닫기"))
                ],
              ));
    const String _AIRTABLE_KEY = "";
    final String _url =
        "https://api.airtable.com/v0/appwOWIDaRO0TiSDf/Table%201?api_key=${_AIRTABLE_KEY}";
    try {
      final http.Response _res = await http
          .get(_url)
          .timeout(Duration(seconds: 11),
              onTimeout: () => http.Response('["error"]', 404))
          .catchError((e) => http.Response('["error"]', 404),
              test: (err) => false);
      final Map<String, dynamic> _dataMap = json.decode(_res.body);
      final List _result = _dataMap['records'];
      final List _resultData = _result.map((e) {
        if (e['fields']['Title'].toString() == _txt.text) {
          return e;
        }
        return;
      }).toList()
        ..removeWhere((e) => e == null);
      data.personData = _resultData;
    } catch (e) {
      data.personData = ["error"];
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    Data _data = Provider.of<Data>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Demo1"),
      ),
      body: _data.personData == null
          ? Container(
              margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
              child: Column(
                children: [
                  Container(
                    child: Text("Search"),
                  ),
                  Container(
                    child: TextField(
                      controller: _txt,
                      onEditingComplete: () async =>
                          await this.search(context: context, data: _data),
                    ),
                  )
                ],
              ),
            )
          : (_data.personData.length == 1 && _data.personData[0] == 'error')
              ? Container(
                  child: Column(
                    children: [
                      Container(
                        child: Text("error"),
                      ),
                      Container(
                          child: ElevatedButton(
                        child: Text("RE"),
                        onPressed: () {
                          _data.personData = null;
                          return;
                        },
                      ))
                    ],
                  ),
                )
              : Container(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text("Find"),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: ListView.builder(
                              padding: EdgeInsets.all(10.0),
                              itemCount: _data.personData.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  onTap: () {},
                                  title: Text(
                                      "${index + 1} : ${_data.personData[index]['fields']['Title'].toString()}"),
                                );
                              }),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                child: ElevatedButton(
                              child: Text("RE"),
                              onPressed: () {
                                _data.personData = null;
                                return;
                              },
                            ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
