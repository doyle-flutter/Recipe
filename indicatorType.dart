// 1. 예측 불가능한
// 2. 예측 가능한
// 3. Future

class IndiPage extends StatefulWidget {
  @override
  _IndiPageState createState() => _IndiPageState();
}

class _IndiPageState extends State<IndiPage>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Indicator Value : Infinity"),),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            
            // 1. 예측 불가능한
            CircularProgressIndicator(),
            LinearProgressIndicator(),
            RefreshProgressIndicator(),
            CupertinoActivityIndicator(radius: 20.0,),
          ],
        ),
      ),
    );
  }

}


//   2. 예측 가능한

//  double indicatorValue = 0;
//  Animation<Color> indicatorValueColor = AlwaysStoppedAnimation<Color>(Colors.red);
//
//  timeWhile(){
//    Timer.periodic(Duration(milliseconds: 500), (t){
//      if(this.indicatorValue >= 10.0) return;
//      else{
//        setState(() {
//          this.indicatorValue++;
//        });
//      }
//    });
//  }

//  @override
//  void initState() {
//    timeWhile();
//    super.initState();
//  }

//      appBar: AppBar(title: Text("Indicator Value : $indicatorValue"),),
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

// 3. FUTURE
//  Future<String> delayFunc() async{
//    String result;
//    await Future.delayed(Duration(seconds: 5),(){
//      return result = "완료";
//    });
//    return result;
//  }

//            FutureBuilder(
//              future: delayFunc(),
//              builder: (BuildContext context, AsyncSnapshot<String> snap){
//                if(!snap.hasData) return CircularProgressIndicator();
//                return Text(snap.data);
//              },
//            )
