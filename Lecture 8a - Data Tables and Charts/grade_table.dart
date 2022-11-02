import 'package:flutter/material.dart';
import 'frequency_chart.dart';
import 'grade.dart';

class GradesTable extends StatefulWidget {
  const GradesTable({Key? key}) : super(key: key);

  @override
  State<GradesTable> createState() => _GradesTableState();
}

class _GradesTableState extends State<GradesTable> {
  List<Grade>? _grades;
  List? _selectedGrades;
  Grade? _editingGrade;

  @override
  void initState(){
    super.initState();
    _grades = [Grade(sid: 100000001, grade: 'D'),
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

    _selectedGrades = [];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grades Table"),
        actions: [
          IconButton(
              onPressed: (){
                setState(() {
                  _selectedGrades!.forEach(
                          (element) {
                            _grades!.remove(element);
                          }
                  );
                });
              },
              icon: Icon(Icons.delete)
          ),
          IconButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FrequencyChart(
                      grades: _grades
                    ))
                );
              },
              icon: Icon(Icons.insert_chart)
          ),
        ],
      ),
      body: DataTable(
        columns: [
          DataColumn(label: Text("SID")),
          DataColumn(label: Text("Grade")),
        ],
        rows: _grades!.map(
                (Grade grade) => DataRow(
                  selected: _selectedGrades!.contains(grade),
                    onSelectChanged: (selected) {
                      setState(() {
                        if (selected!){
                          _selectedGrades!.add(grade);
                        } else{
                          _selectedGrades!.remove(grade);
                        }
                      });
                    },
                    cells: [
                      DataCell(Text(grade.sid!.toString())),
                      DataCell(_editingGrade != null && _editingGrade == grade ?
                          TextField(
                            controller: TextEditingController(text: grade.grade),
                            onSubmitted: (value){
                              setState(() {
                                grade.grade = value;
                                _editingGrade = null;
                              });
                            },
                          ) :
                          Text(grade.grade!.toString()),
                        showEditIcon: true,
                        onTap: (){
                          setState(() {
                            _editingGrade = grade;
                          });
                        }
                      ),
                    ]
                )
        )
            .toList(),
      ),
    );
  }
}
