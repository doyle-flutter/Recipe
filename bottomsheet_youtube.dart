@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BottomModalPage"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                child: Text("showModalBottomSheet 1"),
                onTap: () => showModalBottomSheet(
                  context: context,
                  builder: (context) => Container(
                    height: MediaQuery.of(context).size.height*0.3,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        FlatButton(
                          child: Text("닫기", style: TextStyle(color: Colors.red),),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        Text("BottomSheet Notfication 1",),
                      ],
                    ),
                  )
                ),
              ),
              InkWell(
                child: Text("showModalBottomSheet 2"),
                onTap: () => showBottomNotification(context:context),
              ),
              InkWell(
                child: Text("IOS showModalBottomSheet 3"),
                onTap: () => iosShowBottomNotification(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  showBottomNotification({BuildContext context}){
    return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height*0.3,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            FlatButton(
              child: Text("닫기", style: TextStyle(color: Colors.red),),
              onPressed: () => Navigator.of(context).pop(),
            ),
            Text("BottomSheet Notfication 2",),
          ],
        ),
      )
    );
  }

  iosShowBottomNotification(BuildContext context){
    return showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text("시트1"),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text("액션1"),
            onPressed: () => print("액션1"),
          ),
          CupertinoActionSheetAction(
            child: Text("액션2"),
            onPressed: () => print("액션2"),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text("닫기"),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
