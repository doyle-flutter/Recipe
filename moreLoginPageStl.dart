// Main 함수 및 MaterialApp은 별도로 지정해주세요

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainPage extends StatelessWidget {

  final FocusNode _idFocus = new FocusNode();
  final FocusNode _pwFocus = new FocusNode();

  final TextEditingController _idController = new TextEditingController();
  final TextEditingController _pwController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.all(50.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      image: DecorationImage(
                        image: NetworkImage(
                          "https://raw.githubusercontent.com/doyle-flutter/Recipe/master/2019-11-21.webp",
                        ),
                        fit: BoxFit.cover,
                      )
                    ),
                  )
              ),
              Flexible(
                  child: Container(
                    child: Form(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Container(
                              width: MediaQuery.of(context).size.width/2,
                              alignment: Alignment.center,
                              child: TextField(
                                maxLines: 1,
                                focusNode: _idFocus,
                                textInputAction: TextInputAction.next,
                                cursorColor: Colors.black,
                                controller: _idController,
                                autocorrect: true,
                                enabled: true,
                                keyboardType: TextInputType.emailAddress,
                                onSubmitted: (String v)
                                  => this._inputFieldFocusChange(
                                      context: context,
                                      currentFocus: this._idFocus,
                                      nextFocus: this._pwFocus
                                  ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  hintText: "E-Mail",
                                  prefixIcon: Icon(Icons.person,color: Colors.black,),
                                  suffixIcon: this._inputIcon(controller: this._idController, currentFocus: this._idFocus),
                                  border: InputBorder.none
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              width: MediaQuery.of(context).size.width/2,
                              alignment: Alignment.center,
                              child: TextField(
                                maxLines: 1,
                                focusNode: _pwFocus,
                                textInputAction: TextInputAction.done,
                                cursorColor: Colors.black,
                                controller: _pwController,
                                obscureText: true,
                                onSubmitted: (String v){},
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  hintText: "Password",
                                  prefixIcon: Icon(Icons.lock_outline, color: Colors.black,),
                                  suffixIcon: this._inputIcon(
                                    controller: this._pwController,
                                    currentFocus: this._pwFocus),
                                  border: InputBorder.none
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
              ),
              Flexible(
                  child: Column(
                    children: <Widget>[
                      Flexible(
                        child: Container(
                          alignment: Alignment.center,
                          child: MaterialButton(
                            onPressed: this._validation,
                            child: Text("Login"),
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputIcon({TextEditingController controller, FocusNode currentFocus}){
    if(controller.text == "") return null;
    else return IconButton(
      icon: Icon(Icons.clear),
      onPressed: (){
        this.clickClearText(targetVar: controller, currentFocus: currentFocus);
        print(controller.text);
      },
    );
  }

  void _inputFieldFocusChange({
    BuildContext context,
    FocusNode currentFocus,
    FocusNode nextFocus
  }){
    Future.microtask(() => currentFocus.unfocus())
      .then((_) => FocusScope.of(context).requestFocus(nextFocus));
  }

  void clickClearText({
    @required TextEditingController targetVar,
    @required FocusNode currentFocus
  }){
    assert(targetVar != null); assert(currentFocus != null);
    Future.delayed(Duration.zero,(){
      currentFocus.unfocus();
    }).then((_) => targetVar.clear());
  }

  void _validation(){
    print(_idController.text);
    print(_pwController.text);
    bool _isCheck = false;
    /// ...@TODO
    if(_isCheck){
      this._idController.dispose();
      this._pwController.dispose();
    }
  }
}

