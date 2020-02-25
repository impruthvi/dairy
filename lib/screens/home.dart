import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final String uid;
  final String userName;

  Home({Key key, this.uid, this.userName}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(widget.uid),
          ],
        )),
      ),
    );
  }
}
