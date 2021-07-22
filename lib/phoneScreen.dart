import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'Res.dart';
import 'contactsScreen.dart';
import 'models/categoryModel.dart';
class phone_scr extends StatefulWidget {
  @override
  _phone_scrState createState() => _phone_scrState();
}

class _phone_scrState extends State<phone_scr> {

  DatabaseReference db_ref=FirebaseDatabase.instance.reference();
  List<Category> list=[];

  TextEditingController _addCat=new TextEditingController();

  Future delCat(String title){
    return showDialog(context: context,
                                builder: (BuildContext context){
                                  return AlertDialog(
                                    title: Text("Confirm Deletion"),
                                    content: SingleChildScrollView(
                                        child:ListBody(
                                          children: [
                                            Text("Are you sure you want to delete the category '$title' ?"),
                                            Text(" "),
                                            Text("All it's contents will be permanently deleted",style:TextStyle(color:Colors.red,fontSize: 12.0))
                                          ],
                                        )
                                    ),
                                    actions: [
                                      FlatButton(
                                        child: Text("Yes"),
                                        onPressed: (){
                                          FirebaseFirestore.instance.collection("Phonebook").doc(title).delete();
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
  }

  Future addCat(){
    return showDialog(context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("ADD CATEGORY",style: TextStyle(color: textColor),),
            backgroundColor: bck_col_0,
            content: SingleChildScrollView(
                child:ListBody(
                  children: [
                    TextField(
                      controller: _addCat,
                      cursorColor: bck_col_1,
                      style: TextStyle(color:Colors.white),
                      decoration: InputDecoration(
                      focusColor: Colors.white,
                      fillColor: bck_col_1,
                      //border: OutlinedBorder(),
                      labelText: "Category",
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
                child: Text("ADD",style: TextStyle(color: textColor),),
                onPressed: (){
                  FirebaseFirestore.instance.collection("Phonebook").doc(_addCat.text).set(
                      {"title":_addCat.text});
                  _addCat.clear();
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text("CANCEL",style: TextStyle(color: textColor),),
                onPressed: (){
                  //FirebaseFirestore.instance.collection("Phonebook").doc(Title).delete();
                  _addCat.clear();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        }
    );
  }


  Widget categoryCard(String Title,int index){
    var cardHeight=MediaQuery.of(context).size.height*0.1;
    var cardWidth=MediaQuery.of(context).size.width*0.7;
    return GestureDetector(
      onTap: (){
       Navigator.push(context, MaterialPageRoute(builder: (context)=>contact_scr(name: Title,index: index,)));
      },
      child: Container(
        height: cardHeight,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        width: cardWidth,
        margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
        //padding: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          color: Color.fromRGBO(72, 120, 142, 50.0),
          boxShadow: [BoxShadow(
            offset: Offset(0.0,7.0),
            color: Colors.black38,
            blurRadius: 7.0,
          )],
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        alignment: Alignment.center,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(flex:7,
              child: Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(Title,style:TextStyle(color:textColor,fontWeight:FontWeight.w300,fontSize: cardHeight*0.3)),
                    Row(
                      children: [
                        Icon(Icons.arrow_forward_ios_sharp,color:textColor),
                        //IconButton(onPressed: null,
                          //  icon: Icon(Icons.edit,color:Colors.white,size: cardHeight*0.4,)),
                        IconButton(
                          splashColor: Colors.red[300],
                          splashRadius: 5.0,
                          icon: Icon(Icons.delete,color:Colors.redAccent,size: cardHeight*0.4,),
                          onPressed:()=>delCat(Title),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(flex:3,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Expanded(flex:1,child: Container(height:cardHeight*0.05,width:cardWidth,color:Colors.amber)),
                    Expanded(flex:1,child: Container(height:cardHeight*0.05,width:cardWidth,color:Colors.blue)),
                    Expanded(flex:1,child: Container(height:cardHeight*0.05,width:cardWidth,color:Colors.red)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _addCat=TextEditingController();
    list=[];
    db_ref.once().then((DataSnapshot? snapshot) {
      for(int i=0; i<snapshot!.value.length; i++){
        list.add(Category.fromJson(snapshot.value[i]));
        print(list.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.0),
        //backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text("PHONEBOOK", style:TextStyle(fontWeight: FontWeight.w300,color: appBar_text)),
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
      body: Container(
        height: MediaQuery.of(context).size.height*1.0,
        width: MediaQuery.of(context).size.width*1.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              bck_col_0,
              bck_col_1
            ]
          ),
        ),
        child: Container(
              height: MediaQuery.of(context).size.height*0.8,
              width: MediaQuery.of(context).size.width*0.9,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Phonebook").snapshots(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return categoryCard(snapshot.data.docs[index]['title'], index);
                },

              );
            },),
            ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: addCat,
          label: Text("Add Category"),
        foregroundColor: bck_col_1,
        backgroundColor: textColor,
      ),

    );
  }
}
