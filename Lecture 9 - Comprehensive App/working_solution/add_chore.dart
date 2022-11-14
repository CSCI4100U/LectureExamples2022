import 'package:comprehensive08/select_icon.dart';
import 'package:comprehensive08/utils.dart';
import 'package:flutter/material.dart';

import 'model/chore.dart';
import 'model/person.dart';
import 'model/person_model.dart';

class AddChore extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Chore")),
        body: AddChoreForm(),
      );
  }
}


class AddChoreForm extends StatefulWidget {

  @override
  State<AddChoreForm> createState() => _AddChoreFormState();
}

class _AddChoreFormState extends State<AddChoreForm> {
  //TYPING BELOW REQUIRED
  final _formKey = GlobalKey<FormState>();
  Chore _chore = Chore();
  final _personModel = PersonModel();
  List<String> _peopleNames = [];
  String _iconImage = 'assets/icons8-info-100.png';
  bool _showDaysOfWeek = false;
  bool _showDate = true;

  void _initPeopleNames(){
    //_personModel.insertPerson(null, Person(id: 1, name: "Alice"));
    //_personModel.insertPerson(null, Person(id: 2, name: "Bob"));
    _personModel.getAllPeopleNames(null).then((peopleNames){
      setState(() {
        _peopleNames = peopleNames;
      });
    });
  }

  @override
  void initState(){
    super.initState();
    _initPeopleNames();
  }

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();

    if (_chore == null){
      _chore = Chore();
      _chore.icon = _iconImage;
      _chore.date = toDateString(now.year, now.month, now.day);
      _chore.time = toTimeString(now.hour, now.minute);
    }



    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Chore Name",
                    labelText: "Name:",

                  ),
                  autofocus: true,
                  validator: (value){
                    if (value!.isEmpty){
                      return 'This field is required';
                    }
                    else{
                      return null;
                    }
                  },
                  onSaved: (value) => setState(()=>_chore.name = value),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 16.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    hint: Text("Assigned To:"),
                    value: _chore.assignedTo,
                    onChanged: (String? value) => setState(() {
                      _chore.assignedTo = value;
                    }),
                    items: _peopleNames
                        .map<DropdownMenuItem<String>>((String? value){
                      return DropdownMenuItem<String>(
                          child: Text(value!),
                          value: value,
                      );
                    }
                    ).toList(),
                  ),
                ),
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text("icon:"),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                        onPressed: (){
                          showDialog(context: context,
                              builder: (BuildContext context){
                                return IconSelector.getIconSelectorDialog(context);
                              }).then((selectedIcon){
                                setState(() {
                                  _iconImage = selectedIcon;
                                  _chore.icon = selectedIcon;
                                });
                          });
                        },
                        child: Text("Select"),
                    ),
                    Expanded(
                        child: Image.asset(_iconImage, height: 50),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 16.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    hint: Text("Repeat Interval"),
                    value: _chore.repeat,
                    items: ['None','Daily','Weekly']
                    .map((value) => DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    )).toList(),
                    onChanged: _updateRepeat,
                  ),
                ),
              ),
              !_showDate ? Container() : ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text("Date:"),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                        onPressed: (){
                          showDatePicker(context: context, 
                              initialDate: now, 
                              firstDate: now, 
                              lastDate: DateTime(2100)
                          ).then((value) {
                                setState(() {
                                  _chore.date = toDateString(value!.year, value.month, value.day);
                                });
                          }
                          );
                        } , 
                        child: Text("Select")),
                    Expanded(
                        child: Text(_chore == null || _chore.date == null ? toDateString(now.year, now.month , now.day) : _chore.date!),
                    ),
                  ],
                ),
              ),

              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text("Time:"),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                        onPressed: (){
                          showTimePicker(context: context,
                              initialTime: TimeOfDay(hour: now.hour, minute: now.minute),

                          ).then((value) {
                            setState(() {
                              _chore.time = toTimeString(value!.hour, value.minute);
                            });
                          }
                          );
                        } ,
                        child: Text("Select")),
                    Expanded(
                      child: Text(_chore == null || _chore.time == null ? toTimeString(now.hour, now.minute) : _chore.time!),
                    ),
                  ],
                ),
              ),

              !_showDaysOfWeek ? Container() : ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text("Days of the week"),
                ),
                subtitle: Column(
                  children: [
                    Row(
                      children: [
                        Text('Sunday'),

                        Checkbox(
                            value: _chore.sunday == null || _chore.sunday == 0 ? false : true,
                            onChanged: (value){
                              setState(() {
                                _chore.sunday = value == null || value == false ? 0 : 1;
                              });
                            }),

                        Text('Monday'),

                        Checkbox(
                            value: _chore.monday == null || _chore.monday == 0 ? false : true,
                            onChanged: (value){
                              setState(() {
                                _chore.monday = value == null || value == false ? 0 : 1;
                              });
                            }),
                      ],
                    ),
                    Row(
                      children: [
                       Text('Tuesday'),

                        Checkbox(
                            value: _chore.tuesday == null || _chore.tuesday == 0 ? false : true,
                            onChanged: (value){
                              setState(() {
                                _chore.tuesday = value == null || value == false ? 0 : 1;
                              });
                            }),

                        Text('Wednesday'),

                        Checkbox(
                            value: _chore.wednesday == null || _chore.wednesday == 0 ? false : true,
                            onChanged: (value){
                              setState(() {
                                _chore.wednesday = value == null || value == false ? 0 : 1;
                              });
                            }),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Thursday'),

                        Checkbox(
                            value: _chore.thursday == null || _chore.thursday == 0 ? false : true,
                            onChanged: (value){
                              setState(() {
                                _chore.thursday = value == null || value == false ? 0 : 1;
                              });
                            }),

                        Text('Friday'),

                        Checkbox(
                            value: _chore.friday == null || _chore.friday == 0 ? false : true,
                            onChanged: (value){
                              setState(() {
                                _chore.friday = value == null || value == false ? 0 : 1;
                              });
                            }),

                        Text('Saturday'),

                        Checkbox(
                            value: _chore.saturday == null || _chore.saturday == 0 ? false : true,
                            onChanged: (value){
                              setState(() {
                                _chore.saturday = value == null || value == false ? 0 : 1;
                              });
                            }),
                      ],
                    ),
                  ],
                ),
              ),

              Padding(padding: const EdgeInsets.only(top: 16.0),
                child: Center(
                  child: ElevatedButton(
                    child: Text("Add Chore"),
                    onPressed: (){
                      final form = _formKey.currentState!;
                      if (form.validate()){
                        form.save();

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Chore '${_chore.name}' added")
                        )
                        );

                        Navigator.pop(context, _chore);
                      }
                    },
                  )
                ),
              )
            ],
          ),
        )
        ,
    );
  }

  void _updateRepeat(value){
    setState(() {
      _chore.repeat = value;
      if (value == "Weekly"){
        _showDaysOfWeek = true;

      }else{
        _showDaysOfWeek = false;
      }
      if (value == null || value == "None"){
        _showDate = true;
      } else{
        _showDate = false;
      }
    });
  }
}
