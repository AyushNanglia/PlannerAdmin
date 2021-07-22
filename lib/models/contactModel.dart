
class Contact{
  String name,desig,category,ip_direct,ip_office,ip_res,ll_off,ll_res,mob;

  Contact({required this.name,required this.desig,required this.category,
  required this.ip_office,required this.ip_direct,required this.ip_res,
    required this.ll_off,required this.ll_res,required this.mob});

  factory Contact.fromSnap(Map<dynamic,dynamic> json){
    return Contact(
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