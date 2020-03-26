// 1. 예측 불가능한
// 2. 예측 가능한

class IndiPage extends StatefulWidget {
  @override
  _IndiPageState createState() => _IndiPageState();
}

class _IndiPageState extends State<IndiPage>{

  Future<String> delayFunc() async{
    String result;
    await Future.delayed(Duration(seconds: 3),(){
      return result = "완료";
    });
    return result;
  }


  double indicatorValue = 0;

  timeWhile(){
    Timer.periodic(Duration(milliseconds: 500), (t){
//      if(this.indicatorValue >= 10.0) return;
//      else{
//        setState(() {
//          this.indicatorValue++;
//        });
//      }
    });
  }


  Animation<Color> indicatorValueColor = AlwaysStoppedAnimation<Color>(Colors.red);

  @override
  void initState() {
    timeWhile();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(title: Text("Indicator Value : $indicatorValue"),),
      appBar: AppBar(title: Text("Indicator Value : Infinity"),),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            CircularProgressIndicator(),
            LinearProgressIndicator(),
            RefreshProgressIndicator(),
            CupertinoActivityIndicator(radius: 20.0,),
          ],
        ),

//            CircularProgressIndicator(
//              value: this.indicatorValue*0.1,
//              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
//            ),
//            LinearProgressIndicator(
//              value: this.indicatorValue*0.1,
//              valueColor: indicatorValueColor,
//            ),
//            RefreshProgressIndicator(
//              value: this.indicatorValue*0.1,
//              valueColor: this.indicatorValueColor,
//            ),
//            CupertinoActivityIndicator(
//              radius: 20.0,
//              animating: false,
//            ),
      ),
    );
  }

}
