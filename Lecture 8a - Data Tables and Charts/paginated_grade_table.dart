import 'package:flutter/material.dart';
import 'grade_table.dart';
import 'frequency_chart.dart';
import 'grade.dart';
import 'gradesSource.dart';

class PaginatedGradeTable extends StatefulWidget {
  const PaginatedGradeTable({Key? key}) : super(key: key);

  @override
  State<PaginatedGradeTable> createState() => _PaginatedGradeTableState();
}

class _PaginatedGradeTableState extends State<PaginatedGradeTable> {
  GradesDataSource? gradesDataSource;

  @override
  void initState(){
    gradesDataSource = GradesDataSource();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paginated Grades"),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FrequencyChart(
                        grades: gradesDataSource!.getGrades()
                    ))
                );
              },
              icon: Icon(Icons.insert_chart)
          ),
          IconButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => GradesTable()
                    )
                );
              },
              icon: Icon(Icons.table_rows)
          ),


        ],
      ),
      body: PaginatedDataTable(
        header: Text("The Grades"),
        source: gradesDataSource!,
        rowsPerPage: 5,
        columns: [
          DataColumn(label: Text("SID")),
          DataColumn(label: Text("Grade")),
        ],
      ),
    );
  }
}
