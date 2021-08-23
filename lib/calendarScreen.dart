import 'package:flutter_12june/converter.dart';

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

  Future checkUpdate()async{
    SharedPreferences p=await SharedPreferences.getInstance();
    int? bool=p.getInt("toUpdate");
    if(bool==1){
      rebuildAllChildren(context);
      p.setInt("toUpdate", 0);
    }
  }

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }
    (context as Element).visitChildren(rebuild);
  }

  Future<int> getPref()async{
    int y;
    SharedPreferences prefs=await SharedPreferences.getInstance();
    y=prefs.getInt("month")!;
    print("get ${prefs.getInt("month")}");
    return y;
  }

  List<calEvent> eventList=[];

  Widget eventCard(String event,int date, int month,String isHoliday){
    var buttonHeight=MediaQuery.of(context).size.height*0.09;
    Color? eventColor=Colors.white;
    if(isHoliday=='y')
      eventColor=Colors.yellow[100];
    return Container(
      height: buttonHeight,
      width: MediaQuery.of(context).size.width*0.8,
      margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
      decoration: BoxDecoration(
        color: bck_col_1,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Row(
        children: [
          Expanded(flex: 7,
            child: Container(
              decoration: BoxDecoration(
                color: bck_col_1,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              alignment: Alignment.center,
              child: AutoSizeText(event,maxLines:2,style: TextStyle(color: textColor,fontSize: buttonHeight*0.25,fontWeight: FontWeight.w300),),
            ),
          ),
          Expanded(flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: eventColor,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("$date",style: TextStyle(color: bck_col_1,fontSize: buttonHeight*0.4),),
                  Text(intToMonth3(month),style: TextStyle(color: bck_col_1,fontSize: buttonHeight*0.2),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eventList=<calEvent>[];
    DatabaseReference dbRef=FirebaseDatabase.instance.reference().child("Events");
    dbRef.once().then((DataSnapshot snap){
      var keys=snap.key;
      var index=snap.value.length;
      var value=snap.value;
      for(int i=0; i<index; i++){
        calEvent event=new calEvent(
          eventName:value[i]['event'],
          eventYear:value[i]['yyyy'],
          eventIsHoliday:value[i]['holiday'],
          eventMonth:value[i]['m'],
          eventDate:value[i]['dd'],
        );
        eventList.add(event);
      }
      setState(() {});
      print("> ${eventList[1].eventName}");
    });

    _query=FirebaseDatabase.instance.reference().child("Events");
    setPref(DateTime.now().month);
    //update_Month(3);
    //_query.orderByChild("m").equalTo(4).once().then((DataSnapshot snap) {
    //_calCon=CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    checkUpdate();
    String? dropVal="January";
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
                      height: MediaQuery.of(context).size.height*0.09,
                    ),

                TableCalendar(
                      /*calendarController: _calCon,
                      initialCalendarFormat: CalendarFormat.month,*/
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      //currentDay: ,
                      headerStyle: HeaderStyle(
                        titleCentered: true,
                          formatButtonVisible: false,
                          //centerHeaderTitle: true,
                          titleTextStyle: TextStyle(fontSize:15.0,fontWeight: FontWeight.bold,color: textColor),
                          ),
                      calendarStyle: CalendarStyle(
                        selectedDecoration: BoxDecoration(color: textColor),
                        selectedTextStyle: TextStyle(color: bck_col_0),
                        todayDecoration: BoxDecoration(color: bck_col_1,shape: BoxShape.circle),
                        todayTextStyle: TextStyle(color: textColor),
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
                  onPageChanged: (focusedDay)async {
                        SharedPreferences p=await SharedPreferences.getInstance();
                        p.setInt("toUpdate", 1);
                    _focusedDay = focusedDay;
                    setState(() {
                      setPref(_focusedDay.month);
                    });
                    //super.initState();
                  },
                    ),
                Container(
                  height: MediaQuery.of(context).size.height*0.5,
                  width: MediaQuery.of(context).size.width*1.0,
                  child: FirebaseAnimatedList(
                    query: _query,
                    itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                      Map map=snapshot.value;
                      return eventCard(map["event"],map["dd"],map["m"],map["holiday"]);
                    },
                  )
                ),

                  //color: Colors.white,
                /*Container
                  child: monthEvents()
                ),*/

                /*Container(
                      //color: Colors.white,
                      height: MediaQuery.of(context).size.height*0.3,
                      width: MediaQuery.of(context).size.width,
                    child: monthEvents(Month: eventList[0].eventDate)
                  *//*FutureBuilder(
                      future: getPref(),
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        int m=snapshot.data;
                        if(snapshot.hasData) {
                          return monthEvents(
                          Month: m,
                        );
                      } else return Container(child: Text("No Data!"),);

                      },
                    ),*//*
                    ),*/


              ],
            ),
          ),
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
  int Month=DateTime.now().month;
  monthEvents({required this.Month});

  //SharedPreferences pref=SharedPreferences.getInstance() as SharedPreferences;
  //monthEvents(this.pref);

  @override
  _monthEventsState createState() => _monthEventsState();
}

class _monthEventsState extends State<monthEvents> {

  /*Future<int> getPref()async{
    int y;
    SharedPreferences prefs=await SharedPreferences.getInstance();
    y=prefs.getInt("month")!;
    //print("get ${prefs.getInt("month")}");
    return y;
  }*/

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

  Future checkUpdate()async{
    SharedPreferences p=await SharedPreferences.getInstance();
    int? bool=p.getInt("toUpdate");
    if(bool==1){
      setState(() {
        cal_scr();
      });
      p.setInt("toUpdate", 0);
    }
  }


  int _month=DateTime.now().month;

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    _q=FirebaseDatabase.instance.reference().child("Events");
    widget.Month=DateTime.now().month;
    //getPref();
    //_month=getPref();
    //_month=getInt();
  }

  @override
  Widget build(BuildContext context) {
    final Month=monthFromCal.of(context).month;
    // print("~$Month");
    return FirebaseAnimatedList(
      query: _q.orderByChild("m").equalTo(widget.Month),
      itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
        Map map=snapshot.value;
        //checkUpdate();
        return buildCard(map);
      },
    );
  }
/*Widget build(BuildContext context) {
    final Month=monthFromCal.of(context).month;
   // print("~$Month");
    return FutureBuilder(
      future: getPref(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        int m=snapshot.data ?? DateTime.now().month;
        print("GET $m");

        return FirebaseAnimatedList(
          query: _q.orderByChild("m").equalTo(m),
          itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
            Map map=snapshot.value;
            return buildCard(map);
          },
        );
      },

    );
  }*/
}

///DropDown List
/*DropdownButtonFormField<String>(
                    value: dropVal,
                    onChanged: (String? newVal){
                      setState(() {
                        dropVal=newVal;
                      });
                    },
                    isExpanded: false,
                    items: <String>["January","February","March","April","May","June",
                      "July","August","September","October","November","December"]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,style: TextStyle(color: Colors.white),),
                      );
                    }).toList(),
                    dropdownColor: homeButtonColor,
                  ),*/