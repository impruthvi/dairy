import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:milk_delivery_system/screens/Login.dart';
import 'package:milk_delivery_system/screens/home.dart';
import 'package:milk_delivery_system/screens/welcome.dart';
import 'package:milk_delivery_system/screens/signup.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroScreen(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => Home(),
        '/login': (BuildContext context) => Login(),
        '/register': (BuildContext context) => Signup(),
      },
    ),
  );
}
