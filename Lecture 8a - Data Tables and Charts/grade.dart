class Grade{
  int? sid;
  String? grade;

  Grade({this.grade,this.sid});

  String toString(){
    return 'Grade($sid,$grade)';
  }
}