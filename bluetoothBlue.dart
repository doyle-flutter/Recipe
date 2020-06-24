// 패키지 : https://pub.dev/packages/flutter_blue

// * And : Manifest.xml
//    <uses-permission android:name="android.permission.BLUETOOTH_ADMIN" />
//    <uses-permission android:name="android.permission.BLUETOOTH" />
//    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
//    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />

// * IOS : info.plist
// <key>NSBluetoothAlwaysUsageDescription</key>
// <string>Need BLE permission</string>
// <key>NSBluetoothPeripheralUsageDescription</key>
// <string>Need BLE permission</string>
// <key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
// <string>Need Location permission</string>
// <key>NSLocationAlwaysUsageDescription</key>
// <string>Need Location permission</string>
// <key>NSLocationWhenInUseUsageDescription</key>
// <string>Need Location permission</string>


  final FlutterBlue blue = FlutterBlue.instance;

  @override
  void initState() {
    blue.scanResults.listen((results) {
      print("검색 중 ...");
      print("results : $results");
      if(results.isNotEmpty){
        setState(() {
          result = results;
        });
      }
    });
    blue.connectedDevices
        .asStream()
        .listen((List<BluetoothDevice> devices) {
      for (BluetoothDevice device in devices) {
        print("device : $device");
      }
    });
    super.initState();
  }

  List result;
  bool check = false;
  String viewTxt = "대기중...";

  Future blueBtn() async{
    setState(() {
      check = true;
      viewTxt = "검색중...";
    });
    var bl =  await blue.startScan(
      scanMode: ScanMode.balanced,
        allowDuplicates:true,timeout: Duration(seconds: 12))
      .timeout(Duration(seconds: 12), onTimeout: () async{
        await blue.stopScan();
        setState(() {
          check = false;
          viewTxt = "ERR";
        });
      });
    print("startScan : $bl");

    await Future.delayed(Duration(seconds: 13), () async {
      await blue.stopScan();
      setState(() {
        check = false;
        if(this.result == null) viewTxt = "대기중...";
      });
    });
    return;
  }
  
  // Build() 안에 작성해주세요 :)
  RaisedButton(
    child: Text("Blue"),
    onPressed: this.blueBtn,
  ),
  Container(
    padding: EdgeInsets.all(10.0),
    color: check ? Colors.blue : Colors.red,
    child: Text(result?.toString()?? this.viewTxt)
  ),
