// Model Class를 사용하지 않고 사용하면 처음 배울 때 더욱 쉬울 수 있지만
// 사용할 때에는 굉장히 불편합니다, 구조화된 상태에서는 .(체이닝)을 통해 변수(필드)가
// 보이기 때문입니다 :)

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
              builder: (context, AsyncSnapshot<List> snap){
                if(!snap.hasData) return CircularProgressIndicator();
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.5,
                  child: ListView.builder(
                    itemCount: snap.data.length,
                    itemBuilder: (context, int index){
                      return ListTile(
                        leading: Text(snap.data[index]['id'].toString()),
                        title: Text(snap.data[index]['title'].toString()),
                        subtitle: Text(snap.data[index]['done'].toString()),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => delete(id: snap.data[index]['id']),
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

  Future<List> open() async {
    if(db == null){
      var databasesPath = await getDatabasesPath();
      print(databasesPath); // 저장될 경로

      String path = join(databasesPath, 'demo.db');
      print(path); // 저장 된 DB 파일의 경로

      // await deleteDatabase(path); // DELETE DB

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
    return result;
  }

  Future insert()async{
    await db.insert(tableTodo, {columnTitle: "test_title", columnDone: 1});
    setState((){});
    return;
  }

  Future delete({int id}) async{
    await db.delete(tableTodo, where: "$columnId=?", whereArgs: [id]);
    setState(() {});
    return;
  }

}

