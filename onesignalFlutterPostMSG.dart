// OneSignal
// 기기 간 서로 ID를 알고 있을 경우 서버요청을 직접 거치지 않고 PushMSG를 발송할 수 있음
// IOS 테스트 완료(에뮬레이터 -> SE2)

class MyApp3 extends StatefulWidget {
  @override
  _MyApp3State createState() => _MyApp3State();
}

class _MyApp3State extends State<MyApp3> {
  @override
  void initState() {
    Future.microtask(() async{
      OneSignal.shared.init(
          "_",
          iOSSettings: {
            OSiOSSettings.autoPrompt: false,
            OSiOSSettings.inAppLaunchUrl: false
          }
      );
      OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);
      await OneSignal.shared.promptUserForPushNotificationPermission(fallbackToSettings: true);
      OSPermissionSubscriptionState state = await OneSignal.shared.getPermissionSubscriptionState();
      print("pushToken : ${state.subscriptionStatus.pushToken}");
      print("userId : ${state.subscriptionStatus.userId}"); // the user's APNS or FCM/GCM push token
      // userId : 앱 삭제 후 재설치시 변경 됨(테스크 종료 후 재실행에서는 변함없음)
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
            GestureDetector(
              onTap: () async{
                print("POST");
                final targetUserId = "";
                var i = await OneSignal.shared.postNotification(
                  OSCreateNotification(
                    playerIds: [targetUserId],
                    content: "this is a test from OneSignal's Flutter SDK",
                    heading: "Test Notification"
                  )
                );
                print("i : $i");
              },
              child: Container(
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
            ),
            Text(
              "Flutter 1.17.x 이상\nIOS 테스트 완료",
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
