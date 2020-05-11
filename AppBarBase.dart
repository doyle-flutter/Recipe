import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    home: AppBarBase(),
    theme: ThemeData(
      accentColor: Colors.white10
    ),
  )
);


class AppBarBase extends StatefulWidget {
  @override
  _AppBarBaseState createState() => _AppBarBaseState();
}

class _AppBarBaseState extends State<AppBarBase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AppBar Title"),
        centerTitle: true,
        actions: <Widget>[
        // 아.최.몇
//          IconButton(
//            icon: Icon(Icons.brightness_5),
//            onPressed: (){},
//          ),
//          IconButton(
//            icon: Icon(Icons.brightness_5),
//            onPressed: (){},
//          ),
//          IconButton(
//            icon: Icon(Icons.brightness_5),
//            onPressed: (){},
//          ),
//          IconButton(
//            icon: Icon(Icons.brightness_5),
//            onPressed: (){},
//          ),
//          IconButton(
//            icon: Icon(Icons.brightness_5),
//            onPressed: (){},
//          ),
//          IconButton(
//            icon: Icon(Icons.brightness_5),
//            onPressed: (){},
//          ),
//          IconButton(
//            icon: Icon(Icons.brightness_5),
//            onPressed: (){},
//          ),
//          IconButton(
//            icon: Icon(Icons.brightness_5),
//            onPressed: (){},
//          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.send,color: Colors.white,),
        backgroundColor: Colors.red,
        onPressed: (){},
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        notchMargin: 20.0,
        elevation: 10.0,
        clipBehavior: Clip.antiAlias,
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 100.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.brightness_1),
                onPressed: (){},
              ),
              IconButton(
                icon: Icon(Icons.brightness_1),
                onPressed: (){},
              ),
              IconButton(
                icon: Icon(Icons.brightness_1),
                onPressed: (){},
              ),
              IconButton(
                icon: Icon(Icons.brightness_1),
                onPressed: (){},
              ),
              IconButton(
                icon: Icon(Icons.brightness_1),
                onPressed: (){},
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(),
      endDrawer: Drawer(),
    );
  }
}
