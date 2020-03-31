void main() => runApp(MaterialApp(
    home: PopEventCatch(),
  )
);

class PopEventCatch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        print("Main Page back EVENT");
        return Future.value(false);
      },
      child: Scaffold(
        body: Center(
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BackE()
              )
            ),
            child: Text("Move Page 2"),
          ),
        ),
      )
    );
  }
}

class BackE extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        print("PAGE 2 BACK BTN EVENET");
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Page2"),
        ),
        body: Center(
          child: Text("Page 2 Back Event"),
        ),
      ),
    );
  }
}
