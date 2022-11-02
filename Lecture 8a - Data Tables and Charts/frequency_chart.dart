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
              // charts.Series(
              //
              // )
            ],
            animate: true,
            vertical: true,
          ),
        ),
      ),
    );
  }
}
