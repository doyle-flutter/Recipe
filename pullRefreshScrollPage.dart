// https://pub.dev/packages/pull_to_refresh

class ScrollPage extends StatefulWidget {

  @override
  _ScrollPageState createState() => _ScrollPageState();
}

class _ScrollPageState extends State<ScrollPage> {

  List data = [1,2,3];
  int up = 4;

  RefreshController _refreshController = new RefreshController();

  void _onRefresh() async{
    await Future.delayed(Duration(milliseconds: 1000));
    print("onRefresh");
    setState(() {
      this.data.add(this.up++);
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    await Future.delayed(Duration(milliseconds: 1000));
    print("onLoading");
    _refreshController.loadComplete();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Scroll Refresh"),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onLoading: _onLoading,
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: this.data.map(
              (e) => Container(
                child: Center(child: Text(e.toString())),
                margin: EdgeInsets.all(10.0),
                height:MediaQuery.of(context).size.height/5
              ),
            ).toList(),
          ),
        ),
      )
    );
  }
}
