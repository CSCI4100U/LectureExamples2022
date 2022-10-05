import 'package:flutter/material.dart';

class ScheduledEvent{
  String? name;
  DateTime? dateTime;

  ScheduledEvent({this.dateTime, this.name});

  String toString(){
    return "$name at ($dateTime)";
  }

}


class ScheduleEventPage extends StatefulWidget {
  final String? title;
  const ScheduleEventPage({Key? key, this.title}) : super(key: key);


  @override
  State<ScheduleEventPage> createState() => _ScheduleEventPageState();
}

class _ScheduleEventPageState extends State<ScheduleEventPage> {

  TextStyle style = TextStyle(fontSize: 30);
  String? eventName = "";
  DateTime? eventTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    DateTime rightNow = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            style: style,
            onChanged: (value){
              setState(() {
                eventName = value;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                  onPressed: (){
                    showDatePicker(
                        context: context,
                        initialDate: rightNow,
                        firstDate: rightNow,
                        lastDate: DateTime(2100),
                    ).then( (value) {
                      setState(() {
                        eventTime = DateTime(
                          value!.year,
                          value.month,
                          value.day,
                          eventTime!.hour,
                          eventTime!.minute,
                          eventTime!.second);
                      }
                      );
                    }
                    );
                  },
                  child: Text("Date", style: style,)
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(toDateString(eventTime!), style: style,
                ),
              ),
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                  onPressed: (){
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(
                          hour: rightNow.hour,
                          minute: rightNow.minute
                      ),
                    ).then( (value) {
                      setState(() {
                        eventTime = DateTime(
                            eventTime!.year,
                            eventTime!.month,
                            eventTime!.day,
                            value!.hour,
                            value.minute);
                      }
                      );
                    }
                    );
                  },
                  child: Text("Time", style: style,)
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(toTimeString(eventTime!), style: style,
                ),
              ),
            ],
          ),
          ElevatedButton(
              onPressed: (){
                Navigator.of(context).pop(
                  ScheduledEvent(name: eventName,
                    dateTime: eventTime
                  )
                );
              },
              child: Text("Save", style: style,)
          ),
        ],
      ),
    );
  }
}

String twoDigits(int value){
  if (value > 9){
    return "$value";
  }
  return "0$value";
}

String toDateString(DateTime date){
  return "${date.year}-${twoDigits(date.month)}-${twoDigits(date.day)}";
}

String toTimeString(DateTime date){
  return "${twoDigits(date.hour)}:${twoDigits(date.minute)}";
}