import 'Login.dart';
import 'converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'Res.dart';
import 'calendarScreen.dart';
import 'phoneScreen.dart';

class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  bool _isLoggedIn=false;
  GoogleSignIn gsignin=GoogleSignIn(scopes: ["email"]);

  logout(){
    gsignin.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context)=>loginPage()));
    setState(() {
      _isLoggedIn=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var controllerHeight=MediaQuery.of(context).size.height*0.4;
    var emptyScreenHeight=MediaQuery.of(context).size.height*0.6;
    var buttonHeight=controllerHeight*0.3;
    var buttonWidth=MediaQuery.of(context).size.width*0.8;
    //Color bck=Colors.pink;
    //var userName=gsignin.currentUser!.displayName;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.0),
        elevation: 0.0,
        bottomOpacity: 0.0,
        iconTheme: IconThemeData(
          color: appBar_text,
        ),
        actions: [
          IconButton(icon: Icon(Icons.info_outline,color: appBar_text,), onPressed:()=> logout())
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        height:MediaQuery.of(context).size.height*1.0,
        width:MediaQuery.of(context).size.width*1.0,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  bck_col_0,
                  bck_col_1,
                ]
            )
        ),
        child: Column(
          children: [
            Container(
              height:MediaQuery.of(context).size.height*0.3 ,
              width:MediaQuery.of(context).size.width*0.7,
              child: FlutterAnalogClock(
                dialPlateColor: Color.fromRGBO(255, 255, 255, 0.0),
                centerPointColor: clockColor,
                borderColor: clockColor,
                hourHandColor: clockColor,
                minuteHandColor: clockColor,
                showTicks: false,
                showSecondHand: false,
                showNumber: false,
                secondHandColor: clockColor,
              ),
            ),
            Container(
              height:MediaQuery.of(context).size.height*0.2 ,
              width:MediaQuery.of(context).size.width*0.9,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                      child: Text(DateTime.now().day.toString(),style: TextStyle(fontWeight: FontWeight.w200,color: dateColor,fontSize: MediaQuery.of(context).size.height*0.15),)),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(intToMonthComp(DateTime.now().month),style: TextStyle(color: monthColor,fontWeight: FontWeight.w300,fontSize: MediaQuery.of(context).size.height*0.2*0.35),),
                        Text(intToDay(DateTime.now().weekday),style: TextStyle(color: dayColor,fontWeight: FontWeight.w300,fontSize: MediaQuery.of(context).size.height*0.2*0.25),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width*1.0,
              height: MediaQuery.of(context).size.height*0.2*0.5,
              //color:Colors.white,
              child: Row(
                children: [
                  Expanded(flex:6,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>cal_scr()));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height*0.2*0.5,
                        decoration: BoxDecoration(
                          color: homeButtonColor,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(15.0),bottomRight: Radius.circular(15.0)),
                        ),
                        child:Text("Calender",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.2*0.25,color: textColor,fontWeight: FontWeight.w300),),
                      ),
                    ),
                  ),
                  Expanded(flex:4,child: Container()),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width*1.0,
              height: MediaQuery.of(context).size.height*0.2*0.5,
              //color:Colors.white,
              child: Row(
                children: [
                  Expanded(flex:4,child: Container()),
                  Expanded(flex:6,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>phone_scr()));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height*0.2*0.5,
                        decoration: BoxDecoration(
                          color: homeButtonColor,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0),bottomLeft: Radius.circular(15.0)),
                        ),
                        child:Text("Phonebook",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.2*0.25,color: textColor,fontWeight: FontWeight.w300),),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
      ),
    );
  }
}
