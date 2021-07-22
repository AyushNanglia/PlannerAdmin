import 'test.dart';
import 'models/eventModel.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'allEvents.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';
//import 'addEvent.dart';
import 'Res.dart';
import 'state_mgmt.dart';
import 'package:shared_preferences/shared_preferences.dart';

class cal_scr extends StatefulWidget {
  @override
  _cal_scrState createState() => _cal_scrState();
}

class _cal_scrState extends State<cal_scr> {

 // List<Event> events;
  //late Controll _calCon;
  late Query _query;
  DateTime _focusedDay=DateTime.now();


  Widget eveList(int m){
    int x=DateTime.now().month;
    FirebaseDatabase.instance.reference().child("value").once().then((DataSnapshot snap) {
      x=snap.value;
     // print(x);
    });
    //eveList(month);
    return FirebaseAnimatedList(
      query: _query.orderByChild("m").equalTo(m),
      itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
        Map map=snapshot.value;
        //print(map);
        return buildCard(map);
      },

    );
  }

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
      height: MediaQuery.of(context).size.height*0.08,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(flex:3,child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
                color: homeButtonColor,
                borderRadius: BorderRadius.only(topLeft:Radius.circular(5.0),bottomLeft: Radius.circular(5.0))
            ),
            alignment: Alignment.center,
            child: AutoSizeText(map["event"],maxLines: 2,style: TextStyle(color: textColor,fontWeight: FontWeight.w300,fontSize:MediaQuery.of(context).size.height*0.1*0.25),),
          )),
          Expanded(flex:1,child: Container(
            decoration: BoxDecoration(
              //color: homeButtonColor,
              borderRadius: BorderRadius.only(topRight:Radius.circular(5.0),bottomRight: Radius.circular(5.0)),
              color: eveColor,
            ),
            child: Container(alignment:Alignment.center,child: Text(map["dd"].toString(),style: TextStyle(fontSize:MediaQuery.of(context).size.height*0.1*0.4,color: homeButtonColor),)),
          )),
        ],
      ),
    );
  }


  int update_month(int month) => month = DateTime.now().month;

  setPref(int x)async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    pref.setInt("month", x);
    print("set $x");
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _query=FirebaseDatabase.instance.reference().child("Events");
    setPref(DateTime.now().month);
    //update_Month(3);
    //_query.orderByChild("m").equalTo(4).once().then((DataSnapshot snap) {
    //_calCon=CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return updateMonth(
      child: Scaffold(
        backgroundColor: bck_col_0,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.0),
          //backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text("CALENDER", style:TextStyle(fontWeight: FontWeight.w300,color: appBar_text)),
          centerTitle: true,
          bottomOpacity: 0.0,
          iconTheme: IconThemeData(
            color: appBar_text,

          ),
          actions: [
            IconButton(icon: Icon(Icons.info_outline,color: appBar_text,), onPressed: null)
          ],
        ),
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        body: Container(
          height: MediaQuery.of(context).size.height*1.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  bck_col_0,
                  bck_col_1,
                ]
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                      height: MediaQuery.of(context).size.height*0.1,
                    ),

                TableCalendar(
                      /*calendarController: _calCon,
                      initialCalendarFormat: CalendarFormat.month,*/
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      headerStyle: HeaderStyle(
                        titleCentered: true,
                          formatButtonVisible: false,
                          //centerHeaderTitle: true,
                          titleTextStyle: TextStyle(fontSize:15.0,fontWeight: FontWeight.bold,color: textColor),
                          ),
                      calendarStyle: CalendarStyle(
                        defaultTextStyle: TextStyle(color:Colors.white),
                        weekendTextStyle: TextStyle(color:Colors.red),
                          /*holidayStyle: TextStyle(color:Colors.red),
                          selectedColor: Colors.lightBlue[900],
                          todayColor: Colors.lightBlue[700],*/
                          ),
                      availableGestures: AvailableGestures.horizontalSwipe,
                      daysOfWeekStyle: DaysOfWeekStyle(
                          weekendStyle: TextStyle(fontWeight: FontWeight.bold,color: textColor),
                          weekdayStyle: TextStyle(fontWeight: FontWeight.bold,color: textColor),
                          ),
                  firstDay: DateTime.utc(2000,01,01),
                  lastDay: DateTime.utc(3000,01,01),
                  focusedDay: _focusedDay,
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                    print(">>>>>${_focusedDay.month}");
                    /*FirebaseDatabase.instance.reference().child("prefs").set(
                        {"value": _focusedDay.month});*/
                    //update_Month(_focusedDay.month);
                    setState(() {
                      setPref(_focusedDay.month);
                      //update_Month(_focusedDay.month);
                     // update_Month(_focusedDay.month);
                      print("->${update_month(_focusedDay.month)}");

                      eveList(3);
                    });
                  },
                    ),

                /*Container(
                  child: monthEvents()
                ),*/
                Container(
                      //color: Colors.white,
                      height: MediaQuery.of(context).size.height*0.3,
                      width: MediaQuery.of(context).size.width,
                    child: monthEvents(),
                    ),
                  ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Test()));//viewAllEvents()));
          },
          label: Text("VIEW EVENTS"),
          backgroundColor: homeButtonColor,
        ),
        //floatingActionButton:
      ),
    );



  }

  update_Month(int m){
    monthFromCal.of(context).updMonth(m);
    //print(provider);
    print("&_$m");
    //provider.updMonth(m);
    print("&__$m");
  }
}

class monthEvents extends StatefulWidget {
  //const monthEvents({Key? key}) : super(key: key);
 /* int month=DateTime.now().month;
  monthEvents({required this.month});*/

  @override
  _monthEventsState createState() => _monthEventsState();
}

class _monthEventsState extends State<monthEvents> {

  late Query _q;
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
      height: MediaQuery.of(context).size.height*0.08,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(flex:3,child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
                color: homeButtonColor,
                borderRadius: BorderRadius.only(topLeft:Radius.circular(5.0),bottomLeft: Radius.circular(5.0))
            ),
            alignment: Alignment.center,
            child: AutoSizeText(map["event"],maxLines: 2,style: TextStyle(color: textColor,fontWeight: FontWeight.w300,fontSize:MediaQuery.of(context).size.height*0.1*0.25),),
          )),
          Expanded(flex:1,child: Container(
            decoration: BoxDecoration(
              //color: homeButtonColor,
              borderRadius: BorderRadius.only(topRight:Radius.circular(5.0),bottomRight: Radius.circular(5.0)),
              color: eveColor,
            ),
            child: Container(alignment:Alignment.center,child: Text(map["dd"].toString(),style: TextStyle(fontSize:MediaQuery.of(context).size.height*0.1*0.4,color: homeButtonColor),)),
          )),
        ],
      ),
    );
  }

  int getPref(){
    int y;
    SharedPreferences prefs=SharedPreferences.getInstance() as SharedPreferences;
    y=prefs.getInt("month")!;
    print("get ${prefs.getInt("month")}");
    return y;
  }

  int _month=DateTime.now().month;

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    _q=FirebaseDatabase.instance.reference().child("Events");
    //_month=getPref();
    //_month=getInt();
  }

  @override
  Widget build(BuildContext context) {
    final Month=monthFromCal.of(context).month;
    print("~$Month");
    return FirebaseAnimatedList(

      query: _q.orderByChild("m").equalTo(3),
      itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
        Map map=snapshot.value;
        return buildCard(map);
      },
    );
  }
}

