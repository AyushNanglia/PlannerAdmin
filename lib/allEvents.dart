import 'dart:ui';
import 'converter.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
//import 'converter.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
//import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'Res.dart';

//import 'package:bits_planner/models/eventModel.dart';

class viewAllEvents extends StatefulWidget {
  @override
  _viewAllEventsState createState() => _viewAllEventsState();
}

class _viewAllEventsState extends State<viewAllEvents> {

  late Query _query;
  //late DatabaseReference dbRef=FirebaseDatabase.instance.reference();
  //List<EventModel> eventsList=[];

 /* @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var dbRef=FirebaseDatabase.instance.reference().child("Calender");
    dbRef.once().then((DataSnapshot snapshot){
      var data=snapshot.value;
      var keys=data.keys;
      eventsList.clear();
      for(var key in keys){
        EventModel event=new EventModel(
          eventName: data[key]["EVENT"],
          eventID: data[key]["ID"],
          eventDate: data[key]["DATE"],
          eventMonth: data[key]["MONTH"],
          eventYear: data[key]["YEAR"],
          eventType: data[key]["TYPE"]
        );
        eventsList.add(event);
        print(eventsList[0].eventName);
      }

    });
  }
  */
  /*Future<List<EventModel>> getList()async{
    //var dbRef=FirebaseDatabase.instance.reference().child("Calender");


    return eventsList;
  }*/

  /*Widget buildEvent(String eventName,Timestamp eventDT,bool isHoliday){
    Color cardColor,fontColor;
    String eventType;
    if(isHoliday==true) {
      cardColor = Colors.yellow[100];
      eventType="Holiday";
    } else {
      cardColor = Colors.white;
      eventType="Event";
    }
    var cardHeight=MediaQuery.of(context).size.height*0.13;
    return GestureDetector(
      onTap: (){
        return showDialog(context: context,
            builder: (BuildContext context){
              return AlertDialog(
                title: Text("Confirm Deletion"),
                content: SingleChildScrollView(
                    child:Text("Are you sure you want to delete the event '$eventName' ?"),
                ),
                actions: [
                  FlatButton(
                    child: Text("Yes"),
                    onPressed: (){
                      FirebaseFirestore.instance.collection('Calendar').doc('${eventDT.toDate().month}').collection("${eventDT.toDate().month}").doc("${eventName}").delete();
                      FirebaseFirestore.instance.collection('Calendar').doc('All').collection("This Sem").doc("${eventName}").delete();
                      Navigator.pop(context);
                    },
                  ),
                  FlatButton(
                    child: Text("No"),
                    onPressed: (){
                      //FirebaseFirestore.instance.collection("Phonebook").doc(Title).delete();
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            }
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        child: Container(
          //clipBehavior: Clip.antiAliasWithSaveLayer,
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          height: cardHeight,
          */   ///BUILD EVENTS

  Widget buildCard(Map map){
    var eveColor;
    if(map["holiday"]=='y')
      eveColor=Colors.yellow[100];
    else eveColor=Colors.white;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0))
      ),
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      height: MediaQuery.of(context).size.height*0.1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(flex:3,child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
                color: homeButtonColor,
                borderRadius: BorderRadius.only(topLeft:Radius.circular(10.0),bottomLeft: Radius.circular(10.0))
            ),
            alignment: Alignment.center,
            child: AutoSizeText(map["event"],maxLines: 2,style: TextStyle(color: textColor,fontWeight: FontWeight.w300,fontSize:MediaQuery.of(context).size.height*0.1*0.25),),
          )),
          Expanded(flex:1,child: Container(
            decoration: BoxDecoration(
                //color: homeButtonColor,
                borderRadius: BorderRadius.only(topRight:Radius.circular(10.0),bottomRight: Radius.circular(10.0)),
                color: eveColor,
            ),
            child: Column(
              children: [
                Expanded(flex:2,child: Container(alignment:Alignment.bottomCenter,child: Text(map["dd"].toString(),style: TextStyle(fontSize:MediaQuery.of(context).size.height*0.1*0.4,color: homeButtonColor),))),
                Expanded(flex:1,child: Container(alignment:Alignment.topCenter,child: Text(intToMonth3(map["m"]),style: TextStyle(fontSize:MediaQuery.of(context).size.height*0.1*0.25,color: homeButtonColor),))),
              ],
            ),
          )),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     FirebaseDatabase.instance.setPersistenceEnabled(true);
    _query=FirebaseDatabase.instance.reference().child("Events");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.0),
        //backgroundColor: Colors.white,
        elevation: 0.0,
        bottomOpacity: 0.0,
        iconTheme: IconThemeData(
          color: appBar_text,
        ),
        centerTitle: true,
        title: Text("EVENTS", style:TextStyle(fontWeight: FontWeight.w300,color: appBar_text)),
        actions: [
          IconButton(icon: Icon(Icons.info_outline,color: appBar_text,), onPressed: null)
        ],
      ),
      extendBodyBehindAppBar: true,
      body:Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                bck_col_0,
                bck_col_1
              ]
            )
          ),
          child: Container(
            margin: EdgeInsets.only(top: 100.0),
           // color: Colors.amber,
            alignment: Alignment.topCenter,
            //width: MediaQuery.of(context).size.width,
            child: FirebaseAnimatedList(
              query: _query,//.orderByChild('dd'),
              itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                Map map=snapshot.value;
                return buildCard(map);
              },

            ),
          ),
        ),
    );
  }
}
