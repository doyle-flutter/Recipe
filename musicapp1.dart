import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    home: MyApp(),
    theme: ThemeData(
      accentColor: Colors.black12,
      appBarTheme: AppBarTheme(
        color: Colors.black
      )
    ),
  )
);

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool playBarCheck = false;
  double playBarHeight = 0;
  double playBarViewHeight = 80.0;
  Map<String, dynamic> currentValue;

  int currentBtmBarIndex = 0;

  PageController mainPageCt;
  ScrollController listCt;
  GlobalKey<ScaffoldState> sKey;

  List<Map<String, dynamic>> songList = songData;

  @override
  void didChangeDependencies() {
    mainPageCt = new PageController(initialPage: 0);
    listCt = new ScrollController();
    sKey = new GlobalKey<ScaffoldState>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: this.sKey,
      appBar: AppBar(
        title: Text("MainPage"),
        centerTitle: true,
        leading: Container(),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.confirmation_number),
            onPressed: (){},
          )
        ],
      ),
      endDrawer: Drawer(),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              PageView(
                controller: this.mainPageCt,
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      itemCount: songList.length,
                      controller: listCt,
                      padding: EdgeInsets.only(bottom: this.playBarHeight),
                      itemBuilder:(BuildContext context, int index) => ListTile(
                        onTap: (){
                          setState(() {
                            if(!this.playBarCheck){
                              this.playBarCheck = true;
                              this.playBarHeight = this.playBarViewHeight;
                              this.listCt.position.animateTo(
                                (this.listCt.offset + playBarHeight),
                                duration: Duration(milliseconds: 500),
                                curve: Curves.linear
                              );
                            }
                            this.currentValue = songList[index];
                          });
                        },
                        leading: Container(
                          width: 72.0,
                          height: 72.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(songList[index]['img'].toString()),
                              fit: BoxFit.cover
                            )
                          ),
                        ),
                        title: Text("${this.songList[index]['title'].toString()} $index"),
                        subtitle: Text("${this.songList[index]['name'].toString()} $index"),
                        trailing: IconButton(
                          icon: this.songList[index]['isCheck'] == false
                            ? Icon(Icons.favorite_border)
                            : Icon(Icons.favorite, color: Colors.red, ),
                          onPressed: (){
                            setState(() {
                              this.songList[index]['isCheck'] = !this.songList[index]['isCheck'];
                            });
                          },
                        ),
                      )
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      itemCount: this.songList.length,
                      padding: EdgeInsets.only(
                        bottom: this.playBarHeight,
                        left: 16.0, right: 16.0
                      ),
                      itemBuilder: (BuildContext context, int index) => Card(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        elevation: 4.0,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: 200.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(this.songList[index]['img'].toString()),
                                  fit: BoxFit.cover
                                )
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              child: Container(
                                color: Colors.red,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "${this.songList[index]['title'].toString()} / ${this.songList[index]['name'].toString()}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ),
                  )
                ],
              ),
              this.playBarCheck == false
                ? Container()
                : playBar(value: this.currentValue),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.black87,
        currentIndex: this.currentBtmBarIndex,
        onTap: (int index) async{
          if(index == 0 || index == 1){
            setState(() {
              this.currentBtmBarIndex = index;
              this.mainPageCt.animateToPage(
                this.currentBtmBarIndex,
                duration: Duration(microseconds: 800),
                curve: Curves.linear
              );
            });
          }
          else if(index == 2){
            this.sKey.currentState.openEndDrawer();
          }
          else{
            currentBtmBarIndex = 0;
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => OtherPage()
              )
            );
          }
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Container()
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.collections),
            title: Container()
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.dehaze),
              title: Container()
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Container()
          ),
        ],
      ),
    );
  }

  Widget playBar({Map<String, dynamic> value}){
    return Positioned(
      bottom: 0,
      child: GestureDetector(
        onTap: (){
          setState(() {
            this.playBarCheck = false;
            this.playBarHeight = 0;
          });
        },
        child: AnimatedContainer(
          duration: Duration(seconds: 1),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: this.playBarHeight,
            color: Colors.grey[300],
            child: ListTile(
              leading: Icon(Icons.play_arrow),
              title: Text("${value['title'].toString()}"),
              subtitle: Text("${value['name'].toString()}"),
              trailing: Container(
                width: 72.0,
                height: 72.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(value['img'].toString()),
                    fit: BoxFit.cover
                  )
                ),
              ),
            )
          ),
        ),
      ),
    );
  }

}


class OtherPage extends StatefulWidget {
  @override
  _OtherPageState createState() => _OtherPageState();
}

class _OtherPageState extends State<OtherPage> {
  EdgeInsetsGeometry _verticalMargin = EdgeInsets.symmetric(vertical: 20.0);
  TextEditingController idCt = new TextEditingController();
  TextEditingController pwCt = new TextEditingController();

  @override
  void didChangeDependencies() {

    super.didChangeDependencies();
  }
  @override
  void dispose() {
    this.idCt.dispose();
    this.pwCt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height-kToolbarHeight-MediaQuery.of(context).padding.top,
            margin: EdgeInsets.symmetric( horizontal: 16.0 ),
            child: Column(
              children: <Widget>[
                Container(
                  margin: this._verticalMargin,
                  height: MediaQuery.of(context).size.height*0.3,
                  child: FlutterLogo(
                    size: MediaQuery.of(context).size.width,
                  ),
                ),
                Container(
                  margin: this._verticalMargin,
                  child: TextField(
                    maxLines: 1,
                    controller: this.idCt,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[200],
                      suffixIcon: this.idCt?.text == null || this.idCt?.text == ""
                        ?null
                        :IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () async{
                            print("Clear");
                            await Future.delayed(
                              Duration(milliseconds: 50),
                              (){
                                this.idCt.clear();
                                FocusScope.of(context).unfocus();
                              }
                            );
                          },
                        ),
                      filled: true,
                      hintText: "ID",
                      border: InputBorder.none,
                    ),
                    onSubmitted: (String value){
                      print(value);
                      setState(() {
                        this.idCt.text = value;
                      });
                    },
                  ),
                ),
                Container(
                  margin: this._verticalMargin,
                  child: TextField(
                    maxLines: 1,
                    controller: this.pwCt,
                    obscureText: true,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[200],
                      filled: true,
                      hintText: "PW",
                      border: InputBorder.none,
                      suffixIcon: this.pwCt?.text == null || this.pwCt?.text == ""
                        ?null
                        :IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () async{
                            print("Clear2");
                            await Future.delayed(
                              Duration(milliseconds: 50),
                              (){
                                this.pwCt.clear();
                                FocusScope.of(context).unfocus();
                              }
                            );
                          },
                        ),
                    ),
                    onSubmitted: (String value){
                      setState(() {
                        this.pwCt.text = value;
                      });
                    },
                  ),
                ),
                Container(
                  margin: this._verticalMargin,
                  child: OutlineButton(
                    highlightedBorderColor: Colors.white,
                    child: Text("Login"),
                    onPressed: (){
                      print("${this.idCt.text} / ${this.pwCt.text}");
                    },
                  ),
                ),
                Container(
                  margin: this._verticalMargin,
                  child: FlatButton(
                    child: Text("Join Us"),
                    onPressed: (){},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


//DATAS
List<Map<String, dynamic>> songData = [
  {
    'img' : 'https://cdn.pixabay.com/photo/2020/02/16/21/26/middle-east-4854847__480.jpg',
    'title'  :'Song Title',
    'name' : 'Singer',
    'isCheck' : false
  },
  {
    'img' : 'https://cdn.pixabay.com/photo/2020/01/31/07/53/cartoon-4807395__480.jpg',
    'title'  :'Song Title',
    'name' : 'Singer',
    'isCheck' : false
  },
  {
    'img' : 'https://cdn.pixabay.com/photo/2020/02/27/08/05/lyon-4883769__480.jpg',
    'title'  :'Song Title',
    'name' : 'Singer',
    'isCheck' : false
  },
  {
    'img' : 'https://cdn.pixabay.com/photo/2019/05/20/09/56/guitar-4216326__480.jpg',
    'title'  :'Song Title',
    'name' : 'Singer',
    'isCheck' : false
  },
  {
    'img' : 'https://cdn.pixabay.com/photo/2020/02/16/21/26/middle-east-4854847__480.jpg',
    'title'  :'Song Title',
    'name' : 'Singer',
    'isCheck' : false
  },
  {
    'img' : 'https://cdn.pixabay.com/photo/2020/01/31/07/53/cartoon-4807395__480.jpg',
    'title'  :'Song Title',
    'name' : 'Singer',
    'isCheck' : false
  },
  {
    'img' : 'https://cdn.pixabay.com/photo/2020/02/27/08/05/lyon-4883769__480.jpg',
    'title'  :'Song Title',
    'name' : 'Singer',
    'isCheck' : false
  },
  {
    'img' : 'https://cdn.pixabay.com/photo/2019/05/20/09/56/guitar-4216326__480.jpg',
    'title'  :'Song Title',
    'name' : 'Singer',
    'isCheck' : false
  },
  {
    'img' : 'https://cdn.pixabay.com/photo/2020/02/16/21/26/middle-east-4854847__480.jpg',
    'title'  :'Song Title',
    'name' : 'Singer',
    'isCheck' : false
  },
  {
    'img' : 'https://cdn.pixabay.com/photo/2020/01/31/07/53/cartoon-4807395__480.jpg',
    'title'  :'Song Title',
    'name' : 'Singer',
    'isCheck' : false
  },
  {
    'img' : 'https://cdn.pixabay.com/photo/2020/02/27/08/05/lyon-4883769__480.jpg',
    'title'  :'Song Title',
    'name' : 'Singer',
    'isCheck' : false
  },
  {
    'img' : 'https://cdn.pixabay.com/photo/2019/05/20/09/56/guitar-4216326__480.jpg',
    'title'  :'Song Title',
    'name' : 'Singer',
    'isCheck' : false
  },
  {
    'img' : 'https://cdn.pixabay.com/photo/2020/02/16/21/26/middle-east-4854847__480.jpg',
    'title'  :'Song Title',
    'name' : 'Singer',
    'isCheck' : false
  },
  {
    'img' : 'https://cdn.pixabay.com/photo/2020/01/31/07/53/cartoon-4807395__480.jpg',
    'title'  :'Song Title',
    'name' : 'Singer',
    'isCheck' : false
  },
  {
    'img' : 'https://cdn.pixabay.com/photo/2020/02/27/08/05/lyon-4883769__480.jpg',
    'title'  :'Song Title',
    'name' : 'Singer',
    'isCheck' : false
  },
  {
    'img' : 'https://cdn.pixabay.com/photo/2019/05/20/09/56/guitar-4216326__480.jpg',
    'title'  :'Song Title',
    'name' : 'Singer',
    'isCheck' : false
  },
  {
    'img' : 'https://cdn.pixabay.com/photo/2020/02/16/21/26/middle-east-4854847__480.jpg',
    'title'  :'Song Title',
    'name' : 'Singer',
    'isCheck' : false
  },
  {
    'img' : 'https://cdn.pixabay.com/photo/2020/01/31/07/53/cartoon-4807395__480.jpg',
    'title'  :'Song Title',
    'name' : 'Singer',
    'isCheck' : false
  },
  {
    'img' : 'https://cdn.pixabay.com/photo/2020/02/27/08/05/lyon-4883769__480.jpg',
    'title'  :'Song Title',
    'name' : 'Singer',
    'isCheck' : false
  },
  {
    'img' : 'https://cdn.pixabay.com/photo/2019/05/20/09/56/guitar-4216326__480.jpg',
    'title'  :'Song Title',
    'name' : 'Singer',
    'isCheck' : false
  },
  {
    'img' : 'https://cdn.pixabay.com/photo/2020/02/16/21/26/middle-east-4854847__480.jpg',
    'title'  :'Song Title',
    'name' : 'Singer',
    'isCheck' : false
  },
  {
    'img' : 'https://cdn.pixabay.com/photo/2020/01/31/07/53/cartoon-4807395__480.jpg',
    'title'  :'Song Title',
    'name' : 'Singer',
    'isCheck' : false
  },
  {
    'img' : 'https://cdn.pixabay.com/photo/2020/02/27/08/05/lyon-4883769__480.jpg',
    'title'  :'Song Title',
    'name' : 'Singer',
    'isCheck' : false
  },
  {
    'img' : 'https://cdn.pixabay.com/photo/2019/05/20/09/56/guitar-4216326__480.jpg',
    'title'  :'Song Title',
    'name' : 'Singer',
    'isCheck' : false
  },  {
    'img' : 'https://cdn.pixabay.com/photo/2020/02/16/21/26/middle-east-4854847__480.jpg',
    'title'  :'Song Title',
    'name' : 'Singer',
    'isCheck' : false
  },
  {
    'img' : 'https://cdn.pixabay.com/photo/2020/01/31/07/53/cartoon-4807395__480.jpg',
    'title'  :'Song Title',
    'name' : 'Singer',
    'isCheck' : false
  },
  {
    'img' : 'https://cdn.pixabay.com/photo/2020/02/27/08/05/lyon-4883769__480.jpg',
    'title'  :'Song Title',
    'name' : 'Singer',
    'isCheck' : false
  },
  {
    'img' : 'https://cdn.pixabay.com/photo/2019/05/20/09/56/guitar-4216326__480.jpg',
    'title'  :'Song Title',
    'name' : 'Singer',
    'isCheck' : false
  }
];
