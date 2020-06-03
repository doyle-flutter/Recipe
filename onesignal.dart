// https://pub.dev/packages/onesignal_flutter

import 'package:flutter/material.dart';

import 'package:onesignal_flutter/onesignal_flutter.dart';
void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    Future.microtask(() async{
      OneSignal.shared.init(
          "59ac71cc-fc3b-4125-a8fe-abbc51cf1409",
          iOSSettings: {
            OSiOSSettings.autoPrompt: false,
            OSiOSSettings.inAppLaunchUrl: false
          }
      );
      OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);
      await OneSignal.shared.promptUserForPushNotificationPermission(fallbackToSettings: true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 200.0,
              height: 200.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    "https://files.readme.io/6110aa5-small-onesignal_copy.png"
                  )
                )
              ),
            ),
            Text(
              "Flutter 1.17.x 이상",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0
              ),
            ),
          ],
        ),
      ),
    );
  }
}
