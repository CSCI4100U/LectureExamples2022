String twoDigits(int value){
  String result = '';
  if (value < 10){
    result += '0';
  }
  return result + value.toString();
}

String toDateString(int year, int month, int day){
  return year.toString() + '/' + twoDigits(month) + '/' +
  twoDigits(day).toString();
}

String toTimeString(int hour, int minute){
  return twoDigits(hour) + ":" + twoDigits(minute);
}

String getWeekDayNameByIndex(int index){
  if (index == 1){
    return 'monday';
  }
  if (index == 2){
    return 'tuesday';
  }
  if (index == 3){
    return 'wednesday';
  }
  if (index == 4){
    return 'thursday';
  }
  if (index == 5){
    return 'friday';
  }
  if (index == 6){
    return 'saturday';
  }
  return 'sunday';
}