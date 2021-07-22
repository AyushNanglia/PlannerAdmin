import 'package:firebase_database/firebase_database.dart';

class Category{
  final String name,desig,category,ip_direct,ip_office,ip_res,ll_off,ll_res,mob;

  Category({required this.name,required this.desig,required this.category,
    required this.ip_direct,required this.ip_office,
    required this.ip_res,required this.ll_off,required this.ll_res,required this.mob});

  //category(this.categoryName);
  //public:
  /*getList(){
    List<category> n_list=["A","B","C","D","E"];
    return n_list;
  }*/

  factory Category.fromJson(Map<dynamic,dynamic> json){
    return Category(
      name: json["Name"],
      desig: json["Design"],
      category: json["Category"],
      ip_direct: json["IP Direct"].toString(),
      ip_office: json["IP Office"].toString(),
      ip_res: json["IP Home"].toString(),
      ll_off: json["LL Office"].toString(),
      ll_res: json["LL Home"].toString(),
      mob: json["Mobile"].toString(),
    );
  }

}