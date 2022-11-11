class Chore{
  int? id = 0;
  String? name = "";
  String? assignedTo = "";
  String? icon = "";
  String? repeat = "";
  String? date = "";
  String? time = "";

  int? sunday = 0;
  int? monday = 0;
  int? tuesday = 0;
  int? wednesday = 0;
  int? thursday = 0;
  int? friday = 0;
  int? saturday = 0;

  Chore({
    this.id,this.name,this.icon,this.date,this.time, this.repeat})
  {
    this.sunday=0;
    this.monday=0;
    this.tuesday=0;
    this.wednesday=0;
    this.thursday=0;
    this.friday=0;
    this.saturday=0;
  }

  Chore.fromMap(Map<String, dynamic> map){
    this.id = map['id'];
    this.name = map['name'];
    this.icon = map['icon'];
    this.assignedTo = map['assignedTo'];
    this.repeat = map['repeat'];
    this.date = map['date'];
    this.time = map['time'];

    this.sunday = map.containsKey('sunday') ? map['sunday'] : 0;
    this.monday = map.containsKey('monday') ? map['monday'] : 0;
    this.tuesday = map.containsKey('tuesday') ? map['tuesday'] : 0;
    this.wednesday = map.containsKey('wednesday') ? map['wednesday'] : 0;
    this.thursday = map.containsKey('thursday') ? map['thursday'] : 0;
    this.friday = map.containsKey('friday') ? map['friday'] : 0;
    this.saturday = map.containsKey('saturday') ? map['saturday'] : 0;
  }

  //TYPING REQUIRED
Map<String, Object> toMap(){
    return {
      'id': this.id ?? 0,
      'name': this.name ?? '',
      'assignedTo': this.assignedTo ?? '',
      'icon': this.icon ?? '',
      'repeat': this.repeat ?? '',
      'time': this.time ?? '',
      'date': this.date ?? '',
      'sunday': this.sunday ?? 0,
      'monday': this.monday ?? 0,
      'tuesday': this.tuesday ?? 0,
      'wednesday': this.wednesday ?? 0,
      'thursday': this.thursday ?? 0,
      'friday': this.friday ?? 0,
      'saturday': this.saturday ?? 0,
    };
  }

  String getWeekDaySummary(){
    String result = '';
    if (this.sunday != 0) result += 'Su';
    if (this.monday != 0) result += 'Mo';
    if (this.tuesday != 0) result += 'Tu';
    if (this.wednesday != 0) result += 'We';
    if (this.thursday != 0) result += 'Th';
    if (this.friday != 0) result += 'Fr';
    if (this.saturday != 0) result += 'Sa';

    return result;
  }

  String toString(){
    String weekDaySummary = getWeekDaySummary();
    return 'Chore(id: $id, name: $name, assignedTo: $assignedTo, '
        'icon: $icon, repeat: $repeat, date: $date, time: $time, '
        'weekDays: $weekDaySummary';
  }

}