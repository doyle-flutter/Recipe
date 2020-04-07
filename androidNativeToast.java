public class MainActivity extends FlutterActivity {

  private static final String NEW_PAGE_TOAST = "samples.flutter.dev/newpagetoast";
  @Override
  public void configureFlutterEngine(FlutterEngine flutterEngine) {
    // GeneratedPluginRegistrant.registerWith(flutterEngine);

    new MethodChannel(
      flutterEngine.getDartExecutor().getBinaryMessenger(), NEW_PAGE_TOAST)
        .setMethodCallHandler(((call, result)
          -> Toast.makeText(this,"Android MainActivity : Toast", Toast.LENGTH_LONG).show()));
  }
}
