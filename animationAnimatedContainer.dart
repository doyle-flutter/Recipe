//custom Drawer 1


class WidthAnimation extends StatefulWidget {
  @override
  _WidthAnimationState createState() => _WidthAnimationState();
}

class _WidthAnimationState extends State<WidthAnimation> {

  double animWidth = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: IconButton( icon: Icon(Icons.menu),
                onPressed: () => setState(() => animWidth = MediaQuery.of(context).size.width),
              ),
            ),
          ),
          Positioned(
            top: 0, bottom: 0, left: 0,
            child: AnimatedContainer(
              width: this.animWidth,
              height: MediaQuery.of(context).size.height,
              duration: Duration(milliseconds: 300),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Container(color: Colors.red),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () => setState(() => this.animWidth = 0),
                      child: Container(color: Colors.grey[300]),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
