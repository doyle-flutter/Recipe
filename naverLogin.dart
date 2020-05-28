Container(
              width: MediaQuery.of(context).size.width/2,
              child: RaisedButton(
                color: Colors.greenAccent[700],
                textColor: Colors.white,
                child: Text("Naver Login"),
                onPressed: () async{
                  String naver_url = "http://127.0.0.1:3000/naverlogin";
                  String _nToken = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => WebviewScaffold(
                        url: naver_url,
                        javascriptChannels: Set.from([
                          JavascriptChannel(
                            name: "james",
                            onMessageReceived: (JavascriptMessage result) async{
                              if(result.message != null) return Navigator.of(context).pop(result.message);
                              return Navigator.of(context).pop();
                            }
                          ),
                        ]),
                      )
                    )
                  );
                  if(_nToken != null) return Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (BuildContext context) => MainPage(userName: _textEditingController.text)
                    ),
                    (route) => false
                  );
                },
              ),
            )
