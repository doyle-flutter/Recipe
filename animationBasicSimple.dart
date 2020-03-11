import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
    home: SimpleAnim(),
  )
);

class SimpleAnim extends StatefulWidget {
  @override
  _SimpleAnimState createState() => _SimpleAnimState();
}

class _SimpleAnimState extends State<SimpleAnim> with SingleTickerProviderStateMixin{

  Animation<double> incrementValue;
  AnimationController controller;

  double animatedContainerWidth = 0.0;

  @override
  void initState() {
    this.controller = new AnimationController(vsync: this, duration: Duration(seconds: 1))
      ..addListener((){setState(() {});});
    this.incrementValue = new Tween(begin: 0.0, end: 300.0).animate(this.controller);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // 1
                RaisedButton(
                  onPressed: () => this.controller.forward(),
                  child: Text("Animation Width")
                ),
                Container(
                  width: this.incrementValue.value,
                  height: MediaQuery.of(context).size.height/3,
                  color: Colors.red,
                ),
                // 2
                RaisedButton(
                    onPressed: () => this.controller.forward(),
                    child: Text("Animation Transform")
                ),
                Transform.rotate(
                  angle: this.incrementValue.value,
                  child: Icon(Icons.person),
                ),
                // 3
                RaisedButton(
                  onPressed: () => setState(() => this.animatedContainerWidth = 300.0),
                  child: Text("AnimatedContainer Width")
                ),
                AnimatedContainer(
                  duration: Duration(seconds: 1),
                  width: this.animatedContainerWidth,
                  height: MediaQuery.of(context).size.height/3,
                  color: Colors.blue,
                  curve: Curves.linear,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
