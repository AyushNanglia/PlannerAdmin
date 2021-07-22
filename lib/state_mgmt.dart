import 'package:flutter/material.dart';

class updateMonth extends StatefulWidget {
 final Widget child;
  const updateMonth({Key? key,required this.child}) : super(key: key);

  @override
  _updateMonthState createState() => _updateMonthState();
}

class _updateMonthState extends State<updateMonth> {
  int month=DateTime.now().month;

  void updMonth(int newMonth){
    setState(() =>
      month=newMonth
    );
    //print("***$newMonth");
  }

  @override
  Widget build(BuildContext context)=>monthFromCal(
      child: widget.child,
      month: month,
      newMonth: this,
  );
}


class monthFromCal extends InheritedWidget {
  final int month;
  final _updateMonthState newMonth;
  const monthFromCal({
    Key? key,
    required Widget child,
    required this.month,
    required this.newMonth

  }) : super(key: key, child: child);

  static _updateMonthState of(BuildContext context)=>context.dependOnInheritedWidgetOfExactType<monthFromCal>()!.newMonth; /*{
    final monthFromCal? result = context.dependOnInheritedWidgetOfExactType<monthFromCal>();
    assert(result != null, 'No monthFromCal found in context');
    return result!;
  }*/


  @override
  bool updateShouldNotify(monthFromCal old) {
    return old.month!=month;
  }
}