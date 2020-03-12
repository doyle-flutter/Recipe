// custom drawer 2


class MyApp4 extends StatefulWidget {
  @override
  _MyApp4State createState() => _MyApp4State();
}

class _MyApp4State extends State<MyApp4> with SingleTickerProviderStateMixin{

  Animation<Offset> anim;
  AnimationController animCt;

  @override
  void initState() {
    Future.delayed(Duration.zero, (){
      return MediaQuery.of(context).size.width;
    })
    .then((double v){
      animCt = new AnimationController(vsync: this, duration: Duration(milliseconds: 500))..addListener(() => setState((){}));
      anim = new Tween(begin: Offset(-v,0), end: Offset(0,0)).animate(this.animCt);
      setState(() {});
    });

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
            child: IconButton(
              icon: Icon(Icons.menu),
              onPressed: (){
                if(this.animCt.isCompleted) return this.animCt.reverse();
                return this.animCt.forward();
              },
            ),
          ),
          Positioned(
            top:0,
            left:0,
            bottom:0,
            child: Transform.translate(
              offset: this.anim?.value ?? Offset(0,0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Row(
                  children: <Widget>[
                    Expanded(flex: 3,
                      child: Container(color: Colors.blue),
                    ),
                    Expanded(flex: 1,
                      child: GestureDetector(
                        onTap: (){
                          if(this.animCt.isCompleted) return this.animCt.reverse();
                          return this.animCt.forward();
                        },
                        child: Container(color: this.animCt.isCompleted ? Colors.grey[300] : null)),
                    )
                  ],
                )
              ),
            ),
          )
        ],
      )
    );
  }
}
