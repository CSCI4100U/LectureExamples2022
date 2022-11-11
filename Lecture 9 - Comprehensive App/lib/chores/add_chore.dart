import 'select_icon.dart';
import 'package:lec9/utils.dart';
import 'package:flutter/material.dart';
import '../models/chore.dart';
import '../models/person.dart';
import '../models/person_model.dart';

class AddChore extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text("Add Chore"),),
      body: AddChoreForm(),
    );
  }
}

class AddChoreForm extends StatefulWidget {
  //const AddChoreForm({Key? key}) : super(key: key);

  @override
  State<AddChoreForm> createState() => _AddChoreFormState();
}

class _AddChoreFormState extends State<AddChoreForm> {

  //TYPING MANDATORY!!!
  final _formKey = GlobalKey<FormState>();
  Chore _chore = Chore();
  final _personModel = PersonModel();
  List<String> _personNames = [];
  String _iconImage = 'assets/icons8-brain-100.png';
  bool _showDaysOfWeek = false;
  bool _showDate = true;

  void _initPeopleNames(){
    _personModel.getAllPersonNames(null).then(
            (personNames) {
              setState(() {
                _personNames = personNames;
              });
            }
    );
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
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Chore Name:",
                  labelText: "Name:"
                ),
                autofocus: true,
                validator: (value){
                  if (value!.isEmpty){
                    return 'this field is required';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    _chore.name = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

