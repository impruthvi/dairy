import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milk_delivery_system/screens/Login.dart';
import 'package:milk_delivery_system/screens/home.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();

  TextEditingController emailInputController;
  TextEditingController passwordInputController;
  TextEditingController nameInputController;
  TextEditingController addressInputController;

  @override
  void initState() {
    emailInputController = TextEditingController();
    passwordInputController = TextEditingController();
    nameInputController = TextEditingController();
    addressInputController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: _registerFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(25.0, 70.0, 0.0, 0.0),
                      child: Text(
                        "SignUp",
                        style: GoogleFonts.montserratAlternates(
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(73.0, 0.0, 0.0, 0.0),
                      child: Text(
                        ".",
                        style: TextStyle(
                            fontSize: 107.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: 55.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                            labelText: 'EMAIL',
                            labelStyle: GoogleFonts.montserrat(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber))),
                        controller: emailInputController,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            labelText: 'PASSWORD',
                            labelStyle: GoogleFonts.montserrat(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber))),
                        controller: passwordInputController,
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            labelText: 'Name',
                            labelStyle: GoogleFonts.montserrat(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber))),
                        controller: nameInputController,
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      TextField(
                        decoration: InputDecoration(
                            labelText: 'Address',
                            labelStyle: GoogleFonts.montserrat(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber))),
                        controller: addressInputController,
                      ),
                      SizedBox(
                        height: 30,
                      ),
//
                      Container(
                        height: 40,
                        child: Material(
                          borderRadius: BorderRadius.circular(40),
                          shadowColor: Colors.amberAccent,
                          color: Colors.amber,
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: () {
                              print("cliked");
                              if (_registerFormKey.currentState.validate()) {
                                FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: emailInputController.text,
                                        password: passwordInputController.text)
                                    .then((currentUser) => Firestore.instance
                                        .collection("users")
                                        .document(currentUser.user.uid)
                                        .setData({
                                          "uid": currentUser.user.uid,
                                          "name": nameInputController.text,
                                          "email": emailInputController.text,
                                        })
                                        .then((result) => {
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Home(
                                                            uid: currentUser
                                                                .user.uid,
                                                          )),
                                                  (_) => false),
                                              nameInputController.clear(),
                                              emailInputController.clear(),
                                              passwordInputController.clear(),
                                              addressInputController.clear()
                                            })
                                        .catchError((err) => print(err))
                                        .catchError((err) => print(err)));
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Error"),
                                        content:
                                            Text("The passwords do not match"),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text("Close"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      );
                                    });
                              }
                            },
                            child: Center(
                              child: Text(
                                "REGISTER",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Already Have Account ? ',
                      style: GoogleFonts.montserrat(fontSize: 20),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      child: Text(
                        "LOGIN",
                        style: GoogleFonts.montserrat(
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
