


intToMonth3(int x){
  String month;
  switch(x){
    case 1: month="JAN";break;
    case 2: month="FEB";break;
    case 3: month="MAR";break;
    case 4: month="APR";break;
    case 5: month="MAY";break;
    case 6: month="JUN";break;
    case 7: month="JUL";break;
    case 8: month="AUG";break;
    case 9: month="SEP";break;
    case 10: month="OCT";break;
    case 11: month="NOV";break;
    case 12: month="DEC";break;
    default: month="error";break;
  }
  return month;
}

intToMonthComp(int x){
  String month;
  switch(x){
    case 1: month="January";break;
    case 2: month="February";break;
    case 3: month="March";break;
    case 4: month="April";break;
    case 5: month="May";break;
    case 6: month="June";break;
    case 7: month="July";break;
    case 8: month="August";break;
    case 9: month="September";break;
    case 10: month="October";break;
    case 11: month="November";break;
    case 12: month="December";break;
    default: month="error";break;
  }
  return month;
}

intToDay(int x){
  String day;
  switch(x){
    case 1: day="Monday";break;
    case 2: day="Tuesday";break;
    case 3: day="Wednesday";break;
    case 4: day="Thursday";break;
    case 5: day="Friday";break;
    case 6: day="Saturday";break;
    case 7: day="Sunday";break;
    default:day="error!";break;
  }
  return day;
}