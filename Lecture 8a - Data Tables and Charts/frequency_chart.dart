import 'package:flutter/material.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;
import 'grade.dart';

class FrequencyChart extends StatefulWidget {
  FrequencyChart({Key? key, this.grades}) : super(key: key);

  List<Grade>? grades;

  @override
  State<FrequencyChart> createState() => _FrequencyChartState();
}

class _FrequencyChartState extends State<FrequencyChart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grade Frequency"),

      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SizedBox(
          height: 500,
          child: charts.BarChart(
            [
              charts.Series(
                id: "Grade Frequency Data",
                domainFn: (gf,_) => gf.grade,
                measureFn: (gf,_) => gf.frequency,
                data: _calculateGradeFrequencies()
              )
            ],
            animate: true,
            vertical: true,
          ),
        ),
      ),
    );
  }
  List<GradeFrequency> _calculateGradeFrequencies(){
    Map<String,int> frequencies = {
      'A+' : 0,
      'A' : 0,
      'A-' : 0,
      'B+' : 0,
      'B' : 0,
      'B-' : 0,
      'C+' : 0,
      'C' : 0,
      'C-' : 0,
      'D' : 0,
      'F' : 0,
    };
    for (Grade grade in widget.grades!){
      int? frequency = frequencies[grade.grade!];
      frequencies[grade.grade!] = frequency!+1;
    }

    var grades = ['A+','A','A-','B+','B','B-','C+','C','C-','D','F',];
    return grades.map(
            (grade) => GradeFrequency(
              grade: grade,
              frequency: frequencies[grade]
            ))
        .toList();
  }
}
