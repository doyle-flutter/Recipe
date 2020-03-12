
class MyApp5 extends StatefulWidget {
  @override
  _MyApp5State createState() => _MyApp5State();
}

class _MyApp5State extends State<MyApp5> with SingleTickerProviderStateMixin{

  Animation<Offset> customDrawer;
  AnimationController customDrawerCt;

  @override
  void initState() {
    customDrawerCt = new AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    customDrawerCt.addListener((){
      setState(() {});
    });
    customDrawer = new Tween(begin: Offset(1,0),end: Offset(0,0)).animate(customDrawerCt);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: IconButton(
                icon: Icon(Icons.menu),
                onPressed: (){
                  this.customDrawerCt.status.index == 3
                      ? this.customDrawerCt.reverse()
                      : this.customDrawerCt.forward();
                },
              ),
            ),
          ),
          SlideTransition(
            position: this.customDrawer,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: (){
                        this.customDrawerCt.reverse();
                      },
                      child: Container(
                          color: this.customDrawerCt.isCompleted ? Colors.grey[300] : null
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      color:Colors.amberAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
