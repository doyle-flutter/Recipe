import 'package:flutter/material.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
void main() => runApp(
  MaterialApp(
    home: MyApp(),
    navigatorObservers: <NavigatorObserver>[
      routeObserver
    ],

  )
);

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with RouteAware, WidgetsBindingObserver{

  @override
  void initState() {
    print("1. initState");

    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print("2. didChangeDependencies");

    routeObserver.subscribe(this, ModalRoute.of(context));
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    print("*dispose");

    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("3. Build");
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("Page Move"),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NewPage()
                )
              ),
            ),
            RaisedButton(
              child: Text("Re Build : SetState()"),
              onPressed: () => setState((){}),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void didPop() {
    print("RouteObserver : didPop");
    super.didPop();
  }
  @override
  void didPopNext() {
    print("RouteObserver : didPopNext");
    super.didPopNext();
  }
  @override
  void didPush() {
    print("RouteObserver : didPush");
    super.didPush();
  }
  @override
  void didPushNext() {
    print("RouteObserver : didPushNext");
    super.didPushNext();
  }

  // Widget Binding
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch(state){
      case AppLifecycleState.inactive:
        print("*WidgetsBindingObserver : Inactive");
        break;
      case AppLifecycleState.paused:
        print("*WidgetsBindingObserver : Paused");
        break;
      case AppLifecycleState.resumed:
        print("*WidgetsBindingObserver : Resumed");
        break;
      case AppLifecycleState.detached:
        print("*WidgetsBindingObserver : Suspending");
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void didUpdateWidget(MyApp oldWidget) {
    print("*WidgetsBindingObserver : didUpdateWidget $oldWidget");
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeAccessibilityFeatures() {
    print("*WidgetsBindingObserver : didChangeAccessibilityFeatures");
    super.didChangeAccessibilityFeatures();
  }

  @override
  void didChangeLocales(List<Locale> locale) {
    print("*WidgetsBindingObserver : didChangeLocales $locale");
    super.didChangeLocales(locale);
  }

  @override
  Future<bool> didPopRoute() {
    print("*WidgetsBindingObserver : didPopRoute return super");
    return super.didPopRoute();

  }

}

class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("NEW PAGE"),
      ),
    );
  }
}
