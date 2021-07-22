import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'Home.dart';
import 'Login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
/*
import 'contactList.dart';
import 'models/contactModel.dart';
*/

void main() {
  // Contacts.getField();

  runApp(
      MaterialApp(home: firebase_ini())
  );
}

class firebase_ini extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (BuildContext context, AsyncSnapshot<FirebaseApp> snapshot) {
            if (snapshot.hasError)
              return Center(child: Text("ERROR STARTING THE APP"));
            else if (snapshot.connectionState == ConnectionState.done) {
              FirebaseDatabase.instance.setPersistenceEnabled(true);
              return wrapper();
            } else
              return Center(child: Text("LOADING..."));
          }
      ),
    );
  }
}

class wrapper extends StatefulWidget {
  @override

  _wrapperState createState() => _wrapperState();
}

class _wrapperState extends State<wrapper> {
  bool isLoggedIn=false;
  @override
  Widget build(BuildContext context) {
    if(isLoggedIn==false)
    return loginPage();
    return homePage();

  }
}
