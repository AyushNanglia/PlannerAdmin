import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';


class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(
          alignment: Alignment.center,
          child: FirebaseAnimatedList(
            query: FirebaseDatabase.instance.reference().child("Events").orderByChild("event").equalTo("Holi").reference(),
            itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
              Map map=snapshot.value;
              return Text(map["event"]);
            },),
        ),
      ),
    );
  }
}
