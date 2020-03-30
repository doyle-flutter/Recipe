// JAVA

//    private static final String CHANNEL2 = "android.foreground";

//        new MethodChannel(flutterEngine.getDartExecutor(), CHANNEL2).setMethodCallHandler(
//            (call, result) -> {
//                result.success("foreground SERVICE");
//                moveTaskToBack(true);
//            });


  var _androidAppRetain = MethodChannel("android.foreground");

  @override
  void initState() {
    if (Platform.isAndroid) {
      _androidAppRetain.invokeMethod("wasActivityKilled").then((result) {
        print("******************* wasActivityKilled result : $result");
      });
    }
    super.initState();
  }
