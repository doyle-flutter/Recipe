class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> with TickerProviderStateMixin{

  Animation<Offset> animValue;
  AnimationController animationController;
  AnimationController iconAnimController;

  @override
  void initState() {
    this.animationController = new AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    this.animValue = new Tween<Offset>(begin: Offset(1,0), end: Offset(0,0))
        .animate(this.animationController)
          ..addListener((){setState(() {});});
    this.iconAnimController = new AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    super.initState();
  }

  @override
  void dispose() {
    this.animationController.dispose();
    this.iconAnimController.dispose();
    super.dispose();
  }

  void customDrawerPlay({AnimationController animationController}){
    this.animationController.forward();
    this.iconAnimController.forward();
    if(animationController.status.index == 3){
      this.animationController.reverse();
      this.iconAnimController.reverse();
    }
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
              child: GestureDetector(
                onTap: () => this.customDrawerPlay(animationController: this.animationController),
                child: AnimatedIcon(
                  icon: AnimatedIcons.menu_arrow,
                  color: this.animationController.status.index == 3 ? Colors.white24 : Colors.black,
                  progress: this.iconAnimController,
                ),
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
                            color: this.animationController.status.index == 3
                              ? Colors.black12
                              : null
                          ),
                        ),
                      ),
                      Expanded(
                        flex:1,
                        child: Container(
                          color: Colors.white38,
                          child: widget
                        ),
                      ),
                    ],
                  ),
                ),
                child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (BuildContext context, int index) => Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: ListTile(
                        onTap: (){},
                        leading: Text(index.toString()),
                        title: Text("Menu $index"),
                        subtitle: Text("Menu SubTitle"),
                        trailing: Icon(Icons.chevron_right),
                      ),
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
