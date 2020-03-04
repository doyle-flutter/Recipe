// pubspec.yaml

// dependencies:
//  firebase_admob: ^0.9.1+3

import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';

void main() => runApp(
  MaterialApp(
    home: GoogleAdmobPage(),
  )
);

class GoogleAdmobPage extends StatefulWidget {
  @override
  _GoogleAdmobPageState createState() => _GoogleAdmobPageState();
}

class _GoogleAdmobPageState extends State<GoogleAdmobPage> {

  MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['키워드'],
    contentUrl: '주소',
    childDirected: false,
    testDevices: <String>[],
  );

  BannerAd myBanner() => BannerAd(
    adUnitId: BannerAd.testAdUnitId,
    size: AdSize.smartBanner,
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      print("BannerAd event is $event");
    },
  );

  @override
  void didChangeDependencies() {
    myBanner()..load()..show();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("GOOGLE ADMOB"),
      ),
    );
  }
}
