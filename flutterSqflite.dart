// Flutter Widget - Sqflite  

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() => runApp(
  MaterialApp(
    home: LocalSql(),
  )
);

final String tableTodo = 'todo';
final String columnId = '_id';
final String columnTitle = 'title';
final String columnDone = 'done';

class LocalSql extends StatefulWidget {
  @override
  _LocalSqlState createState() => _LocalSqlState();
}

class _LocalSqlState extends State<LocalSql> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder(
              future: open(),
              builder: (context, AsyncSnapshot<List<Model>> snap){
                if(!snap.hasData) return CircularProgressIndicator();
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.5,
                  child: ListView.builder(
                    itemCount: snap.data.length,
                    itemBuilder: (context, int index){
                      return ListTile(
                        leading: Text(snap.data[index].id.toString()),
                        title: Text(snap.data[index].title.toString()),
                        subtitle: Text(snap.data[index].done.toString()),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => delete(id: snap.data[index].id),
                        ),
                      );
                    }
                  ),
                );
              },
            ),
            RaisedButton(
              child: Text("insert"),
              onPressed: () => insert(),
            )
          ],
        ),
      ),
    );
  }


  Database db;

  Future<List<Model>> open() async {
    if(db == null){
      var databasesPath = await getDatabasesPath();
      print(databasesPath);
      String path = join(databasesPath, 'demo.db');
      print(path);

      // await deleteDatabase(path);

      db = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
            await db.execute('''
          create table $tableTodo ( 
          $columnId integer primary key autoincrement, 
          $columnTitle text not null,
          $columnDone integer not null)
          '''
            );
          }
      );
      setState(() {});
      return [];
    }
    setState(() {});
    List<Map<String, dynamic>> result = await db.query(tableTodo);
    return result.map( (e) => Model.toJson(json: e)).toList();
  }

  Future insert()async{
    await db.insert(tableTodo, {columnTitle: "test_title", columnDone: 2});
    setState((){});
    return;
  }

  Future delete({int id}) async{
    await db.delete(tableTodo, where: "$columnId=?", whereArgs: [id]);
    setState(() {});
    return;
  }

}


class Model{
  String title;
  int id;
  int done;

  Model({this.title,this.done,this.id});

  factory Model.toJson({ Map<String, dynamic> json }) => Model(
    id: json[columnId], title: json[columnTitle], done: json[columnDone]
  );

}

