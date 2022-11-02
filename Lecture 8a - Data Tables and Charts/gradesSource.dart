import 'package:flutter/material.dart';
import 'grade.dart';

class GradesDataSource extends DataTableSource{
  List<Grade>? _grades;
  Function(bool)? onSelectChanged;

  GradesDataSource({this.onSelectChanged}){

    this._grades = [Grade(sid: 100000001, grade: 'D'),
      Grade(sid: 100000002, grade: 'C+'),
      Grade(sid: 100000003, grade: 'B-'),
      Grade(sid: 100000004, grade: 'A+'),
      Grade(sid: 100000005, grade: 'A-'),
      Grade(sid: 100000006, grade: 'F'),
      Grade(sid: 100000007, grade: 'D'),
      Grade(sid: 100000008, grade: 'C+'),
      Grade(sid: 100000009, grade: 'C-'),
      Grade(sid: 100000010, grade: 'D'),
      Grade(sid: 100000011, grade: 'B-'),
      Grade(sid: 100000012, grade: 'D'),
      Grade(sid: 100000013, grade: 'A+'),
      Grade(sid: 100000014, grade: 'C'),
      Grade(sid: 100000015, grade: 'D'),
      Grade(sid: 100000016, grade: 'C'),
      Grade(sid: 100000017, grade: 'B'),
      Grade(sid: 100000018, grade: 'B+'),
      Grade(sid: 100000019, grade: 'C-'),
      Grade(sid: 100000020, grade: 'C'),
      Grade(sid: 100000021, grade: 'A'),
      Grade(sid: 100000022, grade: 'A+'),
      Grade(sid: 100000023, grade: 'D'),
    ];

  }

  getGrades(){
    return _grades;
  }

  @override
  DataRow getRow(int index){
    Grade grade = _grades![index];
    int page = index ~/ _grades!.length;
    return DataRow.byIndex(
      index: index,
        cells: [
          DataCell(Text("${grade.sid}")),
          DataCell(Text("${grade.grade}")),
        ]
    );
  }

  @override
  int get rowCount => _grades!.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}