import 'package:flutter/material.dart';

// - 상위 위젯에서 값을 받아서 하위 위젯에서 변경하며, 하위 위젯만 다시 그림
//   이 때 상위 위젯의 상태 값은 변경되지 않음
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   GestureBinding.instance.resamplingEnabled = true;
//   return runApp(MaterialApp(
//     home: CustomDrawer(),
//   ));
// }

class CustomDrawer extends StatelessWidget {
  bool check = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CUSTOM : ${this.check}"),
      ),
      body: Container(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              color: Colors.red,
              child: Text(
                "Main",
                style: TextStyle(color: Colors.white),
              ),
            ),
            MyDrawer(
              check: check,
            )
          ],
        ),
      ),
    );
  }
}

class MyDrawer extends StatefulWidget {
  bool check;
  MyDrawer({@required this.check}) : assert(check != null);
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      bottom: 0,
      right: widget.check ? 50.0 : MediaQuery.of(context).size.width - 100.0,
      child: Container(
        color: Colors.blue,
        child: TextButton(
          child: Text(
            "Drawer : ${widget.check}",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            print("DRAWER");
            setState(() {
              widget.check = !widget.check;
            });
          },
        ),
      ),
    );
  }
}

// - 상위 위젯을 다시 그리며 하위 위젯의 상태를 변경
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   GestureBinding.instance.resamplingEnabled = true;
//   return runApp(MaterialApp(
//     home: CustomDrawer2(),
//   ));
// }

class CustomDrawer2 extends StatefulWidget {
  @override
  _CustomDrawer2State createState() => _CustomDrawer2State();
}

class _CustomDrawer2State extends State<CustomDrawer2> {
  bool check = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CUSTOM2 : ${this.check}"),
      ),
      body: Container(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              color: Colors.red,
              child: Text(
                "Main2",
                style: TextStyle(color: Colors.white),
              ),
            ),
            MyDrawer2(
              check: check,
              superState: () => {
                this.setState(() {
                  this.check = !this.check;
                })
              },
            )
          ],
        ),
      ),
    );
  }
}

class MyDrawer2 extends StatelessWidget {
  final bool check;
  final Function superState;
  const MyDrawer2({@required this.check, @required this.superState});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      bottom: 0,
      right: this.check ? 50.0 : MediaQuery.of(context).size.width - 100.0,
      child: Container(
        color: Colors.blue,
        child: TextButton(
          child: Text(
            "Drawer2 : ${this.check}",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            print("DRAWER2");
            superState();
          },
        ),
      ),
    );
  }
}
