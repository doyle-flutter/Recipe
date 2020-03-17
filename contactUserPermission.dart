// ver 사용자 직접 권한설정 필요

import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';


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
  Iterable<Contact> _contact;
  List<Contact> result;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Plugin example app'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.bookmark_border),
            onPressed: () async{
              _contact = await ContactsService.getContacts();
               result = _contact.toList();
              setState(() {});
            },
          )
        ],
      ),
      body: this.result == null
      ? Center(child: Text("불러오기"),)
      : ListView.builder(
        itemCount: result.length,
        itemBuilder: (context, int index){
          return ListTile(
            title: Text(result[index].displayName),
          );
        }
      ),
    );
  }
}
