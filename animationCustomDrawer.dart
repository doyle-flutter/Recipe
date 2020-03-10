
class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> with SingleTickerProviderStateMixin{

  Animation<Offset> animValue;
  AnimationController animationController;

  @override
  void initState() {
    this.animationController = new AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    this.animValue = new Tween<Offset>(begin: Offset(1,0), end: Offset(0,0))
        .animate(this.animationController)
      ..addListener((){setState(() {});});
    super.initState();
  }

  void customDrawerPlay({AnimationController animationController}){
    animationController.forward();
    if(animationController.status.index == 3) animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Center(
              child: RaisedButton(
                child: Text("Click"),
                onPressed: () => this.customDrawerPlay(animationController: this.animationController),
              ),
            ),
            SlideTransition(
              position: this.animValue,
              child: AnimatedBuilder(
                animation: this.animationController,
                builder: (BuildContext context, Widget widget) => Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () => customDrawerPlay(animationController: this.animationController),
                          child: Container(
                            color: this.animationController.status.index == 3 ? Colors.black12 : null
                          ),
                        ),
                      ),
                      Expanded(
                        flex:1,
                        child: Container(
                          color: Colors.red,
                          child: widget,
                        ),
                      ),
                    ],
                  ),
                ),
                child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (BuildContext context, int index) => ListTile(
                      title: Text(index.toString()),
                    )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
