import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main(){
  runApp(
    MaterialApp(
      home: ChangeNotifierProvider<ChangUIValue>(
        create: (_) => new ChangUIValue(),
        child: IgnorePage()
      ),
    )
  );
}

class IgnorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ChangUIValue checkUI = Provider.of<ChangUIValue>(context);
    print(checkUI.check);
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: IgnorePointer(
                  ignoring: checkUI.check,
                  child: Builder(
                    builder: (BuildContext context2) => RaisedButton(
                      color: !checkUI.check ? Colors.blue : Colors.blue[100],
                      child: Text("접속"),
                      textColor: Colors.white,
                      onPressed: () => loadingProcess(context: context2, checkUI: checkUI),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loadingProcess({ @required ChangUIValue checkUI, @required BuildContext context}) async{
    if(!checkUI.check){
      checkUI.check = true;
      await Future.delayed(Duration(seconds: 5), (){
        print("5 초 동안 지연");
        checkUI.check = false;
      });
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("접속 실패"),));
    }
  }
}

class ChangUIValue with ChangeNotifier{
  bool _check = false;
  bool get check => this._check;
  set check(bool newCheck){
    this._check = newCheck;
    notifyListeners();
  }
}


