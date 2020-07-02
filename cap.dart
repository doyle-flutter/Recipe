// Cap

RepaintBoundary(
  key: scr,
  child: Container(
    height: 300.0,
    width: 100.0,
    color: Colors.yellow,
    child: Text("123"),
  ),
)
                  
floatingActionButton: FloatingActionButton(
  child: Text("CAP"),
  onPressed: ()async {
    RenderRepaintBoundary boundary = scr.currentContext.findRenderObject();
    var image = await boundary.toImage();
    var byteData = await image.toByteData(format: ImageByteFormat.png);
    capImage = byteData.buffer.asUint8List();
    setState(() {});
  },
),
