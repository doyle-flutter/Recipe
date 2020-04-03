// 일부 수정하였습니다

class CoronaPage extends StatefulWidget {
  @override
  _CoronaPageState createState() => _CoronaPageState();
}

class _CoronaPageState extends State<CoronaPage> {

  List result;
  var totalCount;
  bool _isScrollRefreshCheck = false;
  RefreshController _refreshController;

  static const END_POINT = 'http://000.000.000:4000/db';

  @override
  void initState() {
    Timer(Duration.zero, () async{
      this.result = await fetch();
      setState(() {
        this.totalCount = result.map((e) => e['infectedCount']).toList().reduce((s,e) => s+e);
      });
    });
    _refreshController = new RefreshController(initialRefresh: false);
    super.initState();
  }

  Future fetch() async{
    var res = await http.get(END_POINT);
    return json.decode(res.body);
  }

  void _onRefresh() async{
    this._isScrollRefreshCheck = true;
    this.result = await fetch();
    setState((){
      this._isScrollRefreshCheck = false;
    });
    _refreshController.refreshCompleted();
  }
  void _onLoading() async{
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: const Text(
          "세계 코로나 바이러스 감염률",
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
      ),
      drawer: new Drawer(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              child: Container(
                color: Colors.red[50],
                child: Center(
                  child: Text("ADMIN Page"),
                ),
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  RaisedButton(
                    child: Text("수정"),
                    onPressed: () async{
                      var res = await http.post("$END_POINT/add/item?query1=q1&query2=q2");
                      List resType = json.decode(res.body);
                      print(resType);
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
      body: new SafeArea(
        child: SmartRefresher(
          enablePullUp: false,
          enablePullDown: true,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          controller: this._refreshController,
          child: _isScrollRefreshCheck == true
          ? CircularProgressIndicator()
          : new SingleChildScrollView(
            child: new Container(
              width: MediaQuery.of(context).size.width,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 20.0, left: 10.0),
                    child: new Text(
                      "국가별 감염자수 / 총 인원 (${this.totalCount?.toString() ?? '--'} 명) ",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  this.result == null
                    ? new CircularProgressIndicator(
                        backgroundColor: Colors.grey,
                        strokeWidth: 8.0,
                      )
                    : this.chartContainer(),
                  new Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 20.0, left: 10.0),
                    child: const Text(
                      "국가별 감염자수",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  (result == null || result.length < 1)
                    ? new CircularProgressIndicator()
                    : this.countryGridView(result: this.result),
                  new Container(
                    height: MediaQuery.of(context).size.height*0.1,
                    alignment: Alignment.center,
                    child: const Text("빠른 쾌유를 빕니다"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget chartContainer(){
    return new Container(
      color: Colors.red,
      height: MediaQuery.of(context).size.height*0.5,
      child: new Row(
        children: this.result.map(
          (e) => this.chartContents(
            country:e['country'],
            percent:(double.parse(e['infectedCount']?.toString())??1.0)/this.totalCount,
          )
        ).toList(),
      ),
    );
  }

  Widget chartContents({@required String country, @required double percent}){
    return this.result == null
    ? new CircularProgressIndicator()
    : new Container(
      width: MediaQuery.of(context).size.width*0.2,
      color: Colors.blue,
      child: new Stack(
        children: <Widget>[
          new Positioned(
            bottom: 40.0,
            left: 0,
            right: 0,
            child: new AnimatedContainer(
              duration: new Duration(seconds: 2),
              color: Colors.purple,
              height: (MediaQuery.of(context).size.height*0.5)*percent,
            ),
          ),
          new Positioned(
            bottom: 20.0,
            left: 0,
            right: 0,
            height: 20.0,
            child: Center(
              child: new Text(
                "감염률 ${(percent*100).floor().toString()}%",
                style: TextStyle(
                    color: Colors.white
                ),
              ),
            ),
          ),
          new Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 20.0,
            child: new Container(
              color: Colors.yellowAccent,
              alignment: Alignment.center,
              child: new Text(country.toString()),
            ),
          ),
        ],
      ),
    );
  }

  Widget countryGridView({@required List result}){
    return new Container(
      width: MediaQuery.of(context).size.width,
      height: 600.0,
      child: new GridView.builder(
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0
          ),
          physics: new NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(10.0),
          itemCount: result.length,
          itemBuilder: (context, int index){
            return new Container(
              height: 200.0,
              color: Colors.grey[200],
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text("${result[index]['country'].toString()}"),
                  new Text("${result[index]['infectedCount'].toString()} 명"),
                  new Text("기준 ${result[index]['date'].toString()}")
                ],
              ),
            );
          }
      ),
    );
  }

}
