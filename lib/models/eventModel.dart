

class calEvent{
  String eventName,eventDate,eventMonth,eventYear,eventIsHoliday;

  calEvent({required this.eventName,required this.eventDate,required this.eventMonth,
  required this.eventYear,required this.eventIsHoliday});

  /*factory calEvent.fromJSON(Map<dynamic,dynamic> json){

  }*/

  factory calEvent.fromSnap(Map<dynamic,dynamic> snap){
    return calEvent(
        eventName: snap["event"],
        eventDate: snap["dd"].toString(),
        eventMonth: snap["m"].toString(),
        eventYear: snap["yyyy"].toString(),
        eventIsHoliday: snap["holiday"]
    );
  }

}


class eventList{
  List<calEvent> eventsList=[];
  eventList({required this.eventsList});

  factory eventList.fromJSON(Map<dynamic,dynamic> json){
   return eventList(
       eventsList: parseEvents(json)
   );
  }

  static List<calEvent> parseEvents(recipeJSON){
    var rList=recipeJSON['Events'] as List;
    List<calEvent> eventList=rList.map((data) => calEvent.fromSnap(data)).toList();  //Add this
    return eventList;
  }

}
