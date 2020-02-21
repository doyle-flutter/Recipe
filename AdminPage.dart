
class AdMinPage extends StatefulWidget {
  @override
  _AdMinPageState createState() => _AdMinPageState();
}

class _AdMinPageState extends State<AdMinPage> {

  Future<List> fetch() async{
    var res = await http.get('$END_POINT/db');
    return json.decode(res.body);
  }

  Future updateInfectedCounter({int targetIndex}) async{
    return await http.post('$END_POINT/admin/infacted/up',
      body:{
        'id': targetIndex.toString()
      }
    );
  }
  Future updateInfectedCounterDown({int targetIndex}) async{
    return await http.post('$END_POINT/admin/infacted/down',
        body:{
          'id': targetIndex.toString()
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("관리자APP"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: fetch(),
          builder: (BuildContext context, AsyncSnapshot<List> snap){
            if(!snap.hasData) return CircularProgressIndicator();
            return Container(
              child: ListView.builder(
                itemCount: snap.data.length,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: ListTile(
                      leading: Text(snap.data[index]['country']),
                      title: Text("치료 중 : ${snap.data[index]['infectedCount'].toString()}"),
                      subtitle: Container(
                        child: Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.keyboard_arrow_up),
                              onPressed: () async{
                                await updateInfectedCounter(targetIndex: snap.data[index]['id']).then((_){
                                  setState(() {});
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.keyboard_arrow_down),
                              onPressed: () async{
                                await updateInfectedCounterDown(targetIndex: snap.data[index]['id']).then((_){
                                  setState(() {});
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      trailing: Container(
                        width: 100.0,
                        child: Row(
                          children: <Widget>[
                            IconButton(
                             icon: Icon(Icons.update),
                             onPressed: (){
                               setState(() {
                                 print("asd");
                               });
                             },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: (){},
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              ),
            );
          },
        ),
      ),
    );
  }
}
