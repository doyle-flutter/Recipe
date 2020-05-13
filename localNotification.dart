// * pubspec.yaml
//  flutter_local_notifications: ^1.4.3
//  ( https://pub.dev/packages/flutter_local_notifications )

// * IOS(Objective-C) : Runner > AppDelegate.m
// ...
//  if (@available(iOS 10.0, *)) {
//   [UNUserNotificationCenter currentNotificationCenter].delegate = (id<UNUserNotificationCenterDelegate>) self;
//  }
// return [...];
// }
// @end

// * Android : AndroidManifest.xml
//    <uses-permission android:name="android.permission.INTERNET" />
//    <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
//    <uses-permission android:name="android.permission.VIBRATE" />

// <application ... android:usesCleartextTraffic="true"> 

// * Android Notification Imag path : android > app > src > main > res > drawable/app_icon.png

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  AndroidNotificationDetails androidNotificationDetails;
  IOSNotificationDetails iosNotificationDetails;
  NotificationDetails notificationDetails;

  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;

  Future onDidReceiveLocalNotification(int id, String title, String body, String payload) async {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
        CupertinoAlertDialog(
          title: Text(title),
          content: Text(body),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Ok'),
              onPressed: () async {
//              Navigator.of(context, rootNavigator: true).pop();
//              await Navigator.push(
//                context,
//                MaterialPageRoute(
//                  builder: (context) => SecondScreen(payload),
//                ),
//              );
              },
            )
          ],
        ),
    );
  }

  Future selectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
//    await Navigator.push(
//      context,
//      MaterialPageRoute(builder: (context) => SecondScreen(payload)),
//    );
  }

  @override
  void initState() {

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

    androidInitializationSettings = new AndroidInitializationSettings('app_icon');
    iosInitializationSettings = IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification,);
    initializationSettings = new InitializationSettings(androidInitializationSettings, iosInitializationSettings);

    androidNotificationDetails = new AndroidNotificationDetails("chid", "chname", "chdes",);
    iosNotificationDetails = new IOSNotificationDetails();
    notificationDetails = new NotificationDetails(androidNotificationDetails, iosNotificationDetails);

    flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: selectNotification);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          icon: Icon(Icons.data_usage),
          onPressed: () async{
            await flutterLocalNotificationsPlugin.show(0, "TITLE", "DES", notificationDetails);
          },
        ),
      ),
    );
  }
}
