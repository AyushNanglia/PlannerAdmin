import 'dart:collection';

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Res.dart';
import 'phoneScreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:expansion_card/expansion_card.dart';
import 'models/categoryModel.dart';
import 'models/contactModel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class contact_scr extends StatefulWidget {
  @override
  _contact_scrState createState() => _contact_scrState();
  var name;
  var index;
  contact_scr({this.name, this.index});
}

class _contact_scrState extends State<contact_scr> {
  DatabaseReference db_ref=FirebaseDatabase.instance.reference();
  late Query _dbRef;
  TextEditingController? _editCont=new TextEditingController();
  TextEditingController? _NameCont,_desigCont,_IPofficeCont,_IPhomeCont,_IPdirectCont,
  _LLhomeCont,_LLofficeCont,_mobileCont=new TextEditingController();
  /*DatabaseReference db_ref=FirebaseDatabase.instance.reference().child("Deans");
  List<category> list=[];*/

  _launchUrl(String number,bool flag)async{
    var dial;
    if(flag==true){
      if (number.length == 4) dial = "tel:01596 $number";
      else dial="tel:$number";
    }
    if (await canLaunch(dial))
      await launch(dial);
  }

  Future addCont(){
    /*Future updateIndex()async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      int prevIndex = pref.getInt("index") ?? 0;
      int currentIndex = prevIndex + 1;
    }*/
    return showDialog(context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("ADD CONTACT",style: TextStyle(color: textColor),),
            backgroundColor: bck_col_0,
            content: SingleChildScrollView(
                child:ListBody(
                  children: [
                    TextField(
                      controller: _NameCont,
                      cursorColor: bck_col_1,
                      style: TextStyle(color:Colors.white),
                      decoration: InputDecoration(
                        focusColor: Colors.white,
                        fillColor: bck_col_1,
                        //border: OutlinedBorder(),
                        labelText: "Name",
                        //hintStyle: TextStyle(color:bck_col_1),
                        labelStyle: TextStyle(color:bck_col_1),
                        //counterStyle: TextStyle(color:bck_col_1),
                      ),
                    ),
                    TextField(
                      controller: _desigCont,
                      cursorColor: bck_col_1,
                      style: TextStyle(color:Colors.white),
                      decoration: InputDecoration(
                        focusColor: Colors.white,
                        fillColor: bck_col_1,
                        //border: OutlinedBorder(),
                        labelText: "Designation",
                        //hintStyle: TextStyle(color:bck_col_1),
                        labelStyle: TextStyle(color:bck_col_1),
                        //counterStyle: TextStyle(color:bck_col_1),
                      ),
                    ),
                    TextField(
                      controller: _mobileCont,
                      cursorColor: bck_col_1,
                      style: TextStyle(color:Colors.white),
                      decoration: InputDecoration(
                        focusColor: Colors.white,
                        fillColor: bck_col_1,
                        //border: OutlinedBorder(),
                        labelText: "Mobile",
                        //hintStyle: TextStyle(color:bck_col_1),
                        labelStyle: TextStyle(color:bck_col_1),
                        //counterStyle: TextStyle(color:bck_col_1),
                      ),
                    ),
                    TextField(
                      controller: _IPofficeCont,
                      cursorColor: bck_col_1,
                      style: TextStyle(color:Colors.white),
                      decoration: InputDecoration(
                        focusColor: Colors.white,
                        fillColor: bck_col_1,
                        //border: OutlinedBorder(),
                        labelText: "IP Office",
                        //hintStyle: TextStyle(color:bck_col_1),
                        labelStyle: TextStyle(color:bck_col_1),
                        //counterStyle: TextStyle(color:bck_col_1),
                      ),
                    ),
                    TextField(
                      controller: _IPdirectCont,
                      cursorColor: bck_col_1,
                      style: TextStyle(color:Colors.white),
                      decoration: InputDecoration(
                        focusColor: Colors.white,
                        fillColor: bck_col_1,
                        //border: OutlinedBorder(),
                        labelText: "IP Direct",
                        //hintStyle: TextStyle(color:bck_col_1),
                        labelStyle: TextStyle(color:bck_col_1),
                        //counterStyle: TextStyle(color:bck_col_1),
                      ),
                    ),
                    TextField(
                      controller: _IPhomeCont,
                      cursorColor: bck_col_1,
                      style: TextStyle(color:Colors.white),
                      decoration: InputDecoration(
                        focusColor: Colors.white,
                        fillColor: bck_col_1,
                        //border: OutlinedBorder(),
                        labelText: "IP Home",
                        //hintStyle: TextStyle(color:bck_col_1),
                        labelStyle: TextStyle(color:bck_col_1),
                        //counterStyle: TextStyle(color:bck_col_1),
                      ),
                    ),
                    TextField(
                      controller: _LLofficeCont,
                      cursorColor: bck_col_1,
                      style: TextStyle(color:Colors.white),
                      decoration: InputDecoration(
                        focusColor: Colors.white,
                        fillColor: bck_col_1,
                        //border: OutlinedBorder(),
                        labelText: "Landline Office",
                        //hintStyle: TextStyle(color:bck_col_1),
                        labelStyle: TextStyle(color:bck_col_1),
                        //counterStyle: TextStyle(color:bck_col_1),
                      ),
                    ),
                    TextField(
                      controller: _LLhomeCont,
                      cursorColor: bck_col_1,
                      style: TextStyle(color:Colors.white),
                      decoration: InputDecoration(
                        focusColor: Colors.white,
                        fillColor: bck_col_1,
                        //border: OutlinedBorder(),
                        labelText: "Landline Home",
                        //hintStyle: TextStyle(color:bck_col_1),
                        labelStyle: TextStyle(color:bck_col_1),
                        //counterStyle: TextStyle(color:bck_col_1),
                      ),
                    ),
                  ],
                )
            ),
            actions: [
              TextButton(
                child: Text("ADD",style: TextStyle(color: textColor),),
                onPressed: ()async{
                  SharedPreferences pref = await SharedPreferences.getInstance();
                  int prevIndex = pref.getInt("index") ?? 1;
                  int currentIndex = prevIndex + 1;
                  FirebaseDatabase.instance.reference().child("${widget.name}/$currentIndex").set(
                      {"Name":_NameCont!.text, "Design":_desigCont!.text, "Mobile":_mobileCont!.text,
                        "IP Home":_IPhomeCont!.text,"IP Direct":_IPdirectCont!.text,"IP Office":_IPofficeCont!.text,
                        "LL Home":_LLhomeCont!.text,"LL Office":_IPofficeCont!.text,"Category":widget.name});

                  _NameCont!.clear();_desigCont!.clear();_mobileCont!.clear();_IPofficeCont!.clear();
                  _IPdirectCont!.clear();_IPhomeCont!.clear();_LLhomeCont!.clear();_LLofficeCont!.clear();
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text("CANCEL",style: TextStyle(color: textColor),),
                onPressed: (){
                  //FirebaseFirestore.instance.collection("Phonebook").doc(Title).delete();
                  _NameCont!.text="";
                  _NameCont!.clear();_desigCont!.clear();_mobileCont!.clear();_IPofficeCont!.clear();
                  _IPdirectCont!.clear();_IPhomeCont!.clear();_LLhomeCont!.clear();_LLofficeCont!.clear();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        }
    );
  }

  Future editCont(String Name,int index){
    String? dropVal="Name";
    return showDialog(context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("EDIT CONTACT",style: TextStyle(color: textColor),),
            backgroundColor: bck_col_0,
            content: SingleChildScrollView(
                child:ListBody(
                  children: [
                  DropdownButtonFormField<String>(
                  value: dropVal,
                  onChanged: (String? newVal){
                    setState(() {
                      dropVal=newVal;
                    });
                  },
                  isExpanded: false,
                  items: <String>["Name","Design","Mobile","IP Direct","IP Home","IP Office",
                    "LL Home","LL Office"]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,style: TextStyle(color: Colors.white),),
                    );
                  }).toList(),
                  dropdownColor: homeButtonColor,
                ),
                    /*DropdownButtonFormField(
                      isExpanded: false,

                        items: <String>[
                          "Meh","Wew","Heh"
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,style: TextStyle(color: Colors.white),),
                          );
                        }).toList(),
                    ),*/
                    TextField(
                      controller: _editCont,
                      cursorColor: bck_col_1,
                      style: TextStyle(color:Colors.white),
                      decoration: InputDecoration(
                        focusColor: Colors.white,
                        fillColor: bck_col_1,
                        //border: OutlinedBorder(),
                        labelText: "New Value",
                        //hintStyle: TextStyle(color:bck_col_1),
                        labelStyle: TextStyle(color:bck_col_1),
                        //counterStyle: TextStyle(color:bck_col_1),
                      ),
                    )
                  ],
                )
            ),
            actions: [
              TextButton(
                child: Text("UPDATE",style: TextStyle(color: textColor),),
                onPressed: (){
                  //print("$dropVal:"+_editCont.text);
                  FirebaseDatabase.instance.reference().child("${widget.name}/$index").update({dropVal!:_editCont!.text});
                  //db_ref.child(index.toString()).update({dropVal!:_editCont!.text});
                  _editCont!.clear();
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text("CANCEL",style: TextStyle(color: textColor),),
                onPressed: (){
                  //FirebaseFirestore.instance.collection("Phonebook").doc(Title).delete();
                  _editCont!.clear();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        }
    );
  }

  Widget phoneCard(String type,String number){
    var butColor;
    var isAvail=true;
    if(number=="0") {
      butColor = Colors.grey;
      isAvail=false;
    } else butColor=Colors.green;
    return Container(
      padding: EdgeInsets.symmetric(horizontal:20.0,vertical:5.0),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(type,style: TextStyle(color: textColor),),
          IconButton(
              icon: Icon(Icons.local_phone_sharp,color: butColor,),
              onPressed:()=>_launchUrl(number, isAvail),
          )
        ],
      ),
    );
  }

  Widget expContact(Map map, int index){
    var stripHeight=MediaQuery.of(context).size.height*0.01;
    Future updateIndex()async{
      SharedPreferences pref=await SharedPreferences.getInstance();
      pref.setInt("index", index);
    }
    return Container(
      //height: MediaQuery.of(context).size.height*0.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        color: homeButtonColor,
      ),
      margin: EdgeInsets.symmetric(horizontal: 15.0,vertical:5.0),
      child: Column(
        children: [
          ExpansionCard(
            background:Container(color:Colors.red[300]),
            //backgroundColor: Colors.amber[300],
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(map["Name"],style:TextStyle(color: textColor,fontSize: MediaQuery.of(context).size.height*0.1*0.3,fontWeight: FontWeight.w300)),
                Text(map["Design"],style:TextStyle(color: textColor,fontStyle: FontStyle.italic,fontSize: MediaQuery.of(context).size.height*0.1*0.2)),
              ],
            ),
            trailing: Icon(Icons.keyboard_arrow_down_sharp,color:textColor),
            children: [
              phoneCard("Mobile", map["Mobile"].toString()),
              phoneCard("IP-Direct",map["IP Direct"].toString()),
              phoneCard("IP-Home",map["IP Home"].toString()),
              phoneCard("IP-Office",map["IP Office"].toString()),
              phoneCard("LL-Home",map["LL Home"].toString()),
              phoneCard("LL-Office",map["LL Office"].toString()),
              IconButton(onPressed:()=>editCont(map["Name"],index), icon: Icon(Icons.edit,color: Colors.white,))
            ],
          ),

        ],
      ),
    );
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseDatabase.instance.setPersistenceEnabled(true);
    //_dbRef=new QueryEvent;
    _dbRef=FirebaseDatabase.instance.reference().child(widget.name);
    _editCont=TextEditingController();
    _NameCont=TextEditingController();
    _desigCont=TextEditingController();
    _mobileCont=TextEditingController();
    _IPdirectCont=TextEditingController();
    _IPhomeCont=TextEditingController();
    _IPofficeCont=TextEditingController();
    _LLhomeCont=TextEditingController();
    _LLofficeCont=TextEditingController();
    //getCont().then((value){});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 255,255, 0.0),
        //backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(widget.name, style:TextStyle(fontWeight: FontWeight.w300,color: appBar_text)),
        centerTitle: true,
        bottomOpacity: 0.0,
        iconTheme: IconThemeData(
          color: appBar_text,
        ),
        actions: [
          IconButton(icon: Icon(Icons.info_outline,color: appBar_text,), onPressed: null)
        ],
      ),
      extendBodyBehindAppBar: true,
      //primary: false,
      resizeToAvoidBottomInset: false,
      body: Container(
        //margin: EdgeInsets.only(top: 150.0),
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
          child: FirebaseAnimatedList(
                query: _dbRef,
                itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                  //Contact cont=snapshot.value;
                  Map map=snapshot.value;
                  return expContact(map, index);
                },

              ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: addCont,
        label: Text("ADD CONTACT"),
        foregroundColor: bck_col_1,
        backgroundColor: textColor,
      ),
    );
  }
}
/*

class dropDown extends StatefulWidget {
  const dropDown({Key? key}) : super(key: key);

  @override
  _dropDownState createState() => _dropDownState();
}

class _dropDownState extends State<dropDown> {

  String? dropVal="Name";
  String? holder;

  void getDropDownItem(){
    setState(() {
      holder = dropVal ;
    });
  }
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: dropVal,


      onChanged: (String? newVal){
        setState(() {
          dropVal=newVal;
        });
      },
      isExpanded: false,
        items: <String>["Name","Design","Mobile","IP Direct","IP Home","IP Office",
        "LL Home","LL Office"]
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value,style: TextStyle(color: Colors.white),),
          );
        }).toList(),
        dropdownColor: homeButtonColor,
    );
  }
}
*/
