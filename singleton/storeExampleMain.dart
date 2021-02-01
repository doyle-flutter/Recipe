import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import './store.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GestureBinding.instance.resamplingEnabled = true;
  return runApp(MaterialApp(home: SingletonEx(),));
}

class SingletonEx extends StatefulWidget {
  @override
  _SingletonExState createState() => _SingletonExState();
}

class _SingletonExState extends State<SingletonEx> {
  Store store;
  @override
  void initState() {
    Future.microtask(() async {
      this.store = await Future.delayed(Duration(seconds: 5), () async {
        return await Store.getInstance();
      });
      print("this.store.data : ${this.store.data}");
      this.store.data = {'my': 'data'};
      print("this.store.data : ${this.store.data}");
      if (!mounted) return;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("StoreExample"),
      ),
      body: Center(
        child: Text(
          "this.store : ${this.store?.data ?? 'not yet'}",
          style: TextStyle(
            fontSize: 30.0,
            color: this.store?.data == null ? Colors.red : Colors.blue
          ),
        ),
      ),
    );
  }
}
