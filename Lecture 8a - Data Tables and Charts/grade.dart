class Grade{
  int? sid;
  String? grade;

  Grade({this.grade,this.sid});

  String toString(){
    return 'Grade($sid,$grade)';
  }
}

class GradeFrequency{
  String? grade;
  int? frequency;

  GradeFrequency({this.grade, this.frequency});

  String toString(){
    return 'GradeFrequency($grade,$frequency)';
  }
}