import 'package:comprehensive08/model/chore_model.dart';
import 'package:comprehensive08/utils.dart';
import 'package:flutter/material.dart';

import 'menu.dart';
import 'model/chore.dart';

class DailySchedule extends StatefulWidget {
  const DailySchedule({Key? key}) : super(key: key);

  @override
  State<DailySchedule> createState() => _DailyScheduleState();
}

class _DailyScheduleState extends State<DailySchedule> {
  final _choreModel = ChoreModel();
  DateTime _date = DateTime.now();
  List<Chore>? _chores;


  @override
  Widget build(BuildContext context) {
    _reload();
    return Scaffold(
      appBar: AppBar(
          title: Text("Daily Schedule"), actions: Menu.createMenu(context)),
      body: Column(children: [
        Container(
          margin: const EdgeInsets.all(10.0),
          child: Center(
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        _date = _date.subtract(Duration(days: 1));
                      });
                      _reload();
                    },
                    iconSize: 50.0,
                    icon: Icon(Icons.arrow_left)),
                Expanded(
                    child: Text(
                  toDateString(_date.year, _date.month, _date.day),
                  textScaleFactor: 2.0,
                  textAlign: TextAlign.center,
                )),
                IconButton(
                    onPressed: () {
                      setState(() {
                        _date = _date.add(Duration(days: 1));
                      });
                      _reload();
                    },
                    iconSize: 50.0,
                    icon: Icon(Icons.arrow_right)),
              ],
            ),
          ),
        ),
        //TODO: ADD EXPANDED CHORE BUILDER
        Expanded(
          child: ListView.builder(
            itemCount: _chores == null ? 0 : _chores!.length,
            itemBuilder: (context, index) {
              return Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(padding: EdgeInsets.all(16.0), child: Image.asset((_chores![index].icon!), scale: 2.0,)),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: getWidgets(_chores![index]),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),


      ]),
    );
  }


  List<Widget> getWidgets(Chore chore) {
    List<Widget> results = [];

    if (chore.name != null) {
      results.add(Align(alignment: Alignment.centerLeft, child: Text(chore.name!, textAlign: TextAlign.left, textScaleFactor: 2.0,)));
    }
    if (chore.assignedTo != null) {
      results.add(Align(alignment: Alignment.centerLeft, child: Text(chore.assignedTo!, textAlign: TextAlign.left, textScaleFactor: 1.5,)));
    }
    if (chore.repeat != null) {
      String repeatMessage = chore.repeat ?? '';
      if (chore.repeat == 'Daily' || chore.repeat == 'Weekly') {
        if (chore.time != null) {
          repeatMessage += ' @ ' + chore.time!;
        }
        results.add(Align(alignment: Alignment.centerLeft, child: Text(repeatMessage, textAlign: TextAlign.left,)));
        if (chore.repeat == 'Weekly') {
          String weeklyMessage = chore.getWeekDaySummary();
          results.add(Align(alignment: Alignment.centerLeft, child: Text(weeklyMessage, textAlign: TextAlign.left,)));
        }
      } else {
        results.add(Align(alignment: Alignment.centerLeft, child: Text('Not repeated', textAlign: TextAlign.left,)));
        String dateTimeMessage = '';
        if (chore.date != null) {
          dateTimeMessage = (chore.date ?? '');
        }
        if (chore.time != null) {
          dateTimeMessage += ' @ ' + (chore.time ?? '');
        }
        results.add(Align(alignment: Alignment.centerLeft, child: Text(dateTimeMessage, textAlign: TextAlign.left,)));
      }
    }
    return results;
  }

  void _reload() {
    // get the correct day's chores
    _choreModel.getChoresByDate(null, _date).then((chores) {
      setState(() {
        _chores = chores;
      });
    });
  }
}
