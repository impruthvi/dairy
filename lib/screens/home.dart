import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:milk_delivery_system/model/usermodel.dart';

class Home extends StatefulWidget {
  final String uid;
  final String userName;

  Home({Key key, this.uid, this.userName}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final databaseReference = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(widget.uid),
            RaisedButton(
              color: Colors.amber,
              onPressed: getData,
              child: Text("Press me"),
            )
          ],
        )),
      ),
    );
  }

  void createRecord() async {
    await databaseReference
        .collection("users")
        .document(widget.uid)
        .updateData({"brand": "Amul", "quantity": "2", "chdo": "qwert"});
    print("done");
  }

  void getData() async {
      /*  For retrieving all user data */
//    databaseReference.collection("users").getDocuments().then(
//          (QuerySnapshot snapshot) => {
//            snapshot.documents
//                .forEach((f) => print('${f.data['name'].toString()}'))
//          },
//        );
//  }
/* For retrieving single user data */


    databaseReference
        .collection('users')
        .document(widget.uid)
        .get()
        .then((string) {
      print(string.data['name']);
    });
  }
}
