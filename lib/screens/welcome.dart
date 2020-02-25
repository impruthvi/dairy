import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:milk_delivery_system/screens/Login.dart';
import 'package:milk_delivery_system/screens/home.dart';

class IntroScreen extends StatefulWidget {
  IntroScreen({Key key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    FirebaseAuth.instance
        .currentUser()
        .then((currentUser) => {
              if (currentUser == null)
                {Navigator.pushReplacementNamed(context, "/login")}
              else
                {
                  Firestore.instance
                      .collection("users")
                      .document(currentUser.uid)
                      .get()
                      .then((DocumentSnapshot result) =>
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Home(
                                        uid: currentUser.uid,
                                      ))))
                      .catchError((err) => print(err))
                }
            })
        .catchError((err) => print(err));
    super.initState();
  }

  final pageDecoration = PageDecoration(
    contentPadding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
    titleTextStyle:
        GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 250),
    bodyTextStyle:
        GoogleFonts.robotoSlab(fontWeight: FontWeight.bold, fontSize: 150),
  );

  List<PageViewModel> getPages() {
    return [
      PageViewModel(
        title: "SMARTER",
        image: Center(child: Image.asset("assets/milk.png")),
        decoration: PageDecoration(),
        body: "A Smart Way To Order Milk",
      ),
      PageViewModel(
        title: "CONVINIENT",
        image: Center(
            child: Image.asset(
          "assets/basket1.png",
        )),
        decoration: PageDecoration(),
        body: "Get Groceries Deliverd Along With Milk.",
      ),
      PageViewModel(
        title: "RELIABLE",
        image: Center(child: Image.asset("assets/delivery.png")),
        decoration: PageDecoration(),
        body: "Order Befor 11:00 PM And Delivered At 7:00 AM ",
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: IntroductionScreen(
          globalBackgroundColor: Colors.white,
          pages: getPages(),
          animationDuration: 300,
          curve: Curves.bounceInOut,
          dotsDecorator: DotsDecorator(
              activeColor: Colors.amber,
              activeSize: const Size(20.0, 10.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0))),
          done: Text(
            "Done",
            style: GoogleFonts.monda(
                fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
          ),
          onDone: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          },
        ),
      ),
    );
  }
}
