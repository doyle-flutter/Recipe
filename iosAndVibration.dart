// 실행하고 있는 플랫폼을 체크합니다
// 기기의 진동에대한 기능이 있는지 체크합니다(에뮬레이터는 불가능)
// IOS 에러 해결 : https://stackoverflow.com/questions/54530383/flutter-package-vibrate-0-0-4-is-not-working-in-ios
// 진동 패키지 : https://pub.dev/packages/vibration

import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

void main() => runApp(
  MaterialApp(
    home: MyApp(),
  )
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () async{
            if(await Vibration.hasVibrator() 
               && !await Vibration.hasAmplitudeControl() 
              ) (Theme.of(context).platform == TargetPlatform.android)
              ? Vibration.vibrate(
                 duration: 3000,
                 pattern: [100, 50, 200, 30, 1000, 2000]
                )
              : Vibration.vibrate();
            else{
              print("${Theme.of(context).platform} : Vibration Null");
            }

          },
          child: (Theme.of(context).platform == TargetPlatform.android)
            ? Text("And Vibration")
            : Text("IOS Vibration"),
        ),
      ),
    );
  }
}
