import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'Res.dart';
import 'package:flutter_12june/Home.dart';

class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  bool _isLoggedIn=false;
  GoogleSignIn gsignin=GoogleSignIn(scopes: ["email"]);

  login()async{
    try{
      ///await gsignin.signIn();
      //if(gsignin.isSignedIn()==true)
      Navigator.push(context, MaterialPageRoute(builder: (context)=>homePage()));
      setState(() {
        _isLoggedIn=true;
      });

    }
    catch(err){
      print(err);
    }
  }

  logout(){
    gsignin.signOut();
    setState(() {
      _isLoggedIn=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var buttonHeight=MediaQuery.of(context).size.height*0.08;
    return Scaffold(
      body: Container(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(flex:8,
              child: Container(
                //color: Colors.cyan,
                alignment: Alignment.center,
                child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      Text("PLANNER",style: TextStyle(color: textColor,fontWeight: FontWeight.w300,fontSize: buttonHeight),),
                      Text("Calendar | Phonebook",style: TextStyle(color: textColor,fontWeight: FontWeight.w300,fontSize: buttonHeight*0.45)),
                      Container(width: MediaQuery.of(context).size.width*0.6,child: Image(image: AssetImage("images/bits_IAL.png"),fit: BoxFit.fitWidth,),),
                    ]
                ),
              ),
            ),
            Expanded(flex:1,
              child: Container(
                //color:Colors.amberAccent,
                child: GestureDetector(
                    onTap: (){
                      login();
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>homePage()));
                    },
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      height: buttonHeight,
                      width: MediaQuery.of(context).size.width*0.4,
                      decoration:BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),

                        boxShadow: [BoxShadow(
                          offset: Offset(-2.0,2.0),
                          blurRadius: 3.0,
                          color: Colors.black26,
                        )],
                        color: homeButtonColor ,
                      ) ,
                      // color:Colors.cyan[200],
                      child: Row(
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                         // Container(height: buttonHeight*0.5,child: Image(image: AssetImage("images/google_logo.png"),fit: BoxFit.cover,)),
                          Container(alignment:Alignment.center,child: Text("SIGN IN",style: TextStyle(color: textColor,fontWeight: FontWeight.w300,fontSize: buttonHeight*0.4))),
                        ],
                      ),

                    )
                ),
              ),
            ),
            Expanded(flex:6,
              child: Container(
                alignment: Alignment.bottomCenter,
                height: MediaQuery.of(context).size.height*0.1,
                width: MediaQuery.of(context).size.width*0.55,
                child: Image(image:AssetImage("images/bits_logo.png"),fit: BoxFit.cover,),
              ),
            ),
          ],
        ),
        //color: Colors.white,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                bck_col_0,
                bck_col_1,
              ]
          ),
        ),
        alignment: Alignment.center,
      ),
    );
  }
}
