class Webs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: MYURL,
      withJavascript: true,
      javascriptChannels: Set.from([
        JavascriptChannel(
          name: "james",
          onMessageReceived: (JavascriptMessage result){
            print("message ${result.message}");
          }
        ),
      ]),
    );
  }
}
