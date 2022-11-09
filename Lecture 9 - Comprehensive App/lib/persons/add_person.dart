import 'package:flutter/material.dart';
import 'package:lec9/models/person.dart';

class AddPersonPage extends StatelessWidget {
  const AddPersonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Person"),
      ),
      body: AddPersonForm(),
    );
  }
}

class AddPersonForm extends StatefulWidget {
  const AddPersonForm({Key? key}) : super(key: key);

  @override
  State<AddPersonForm> createState() => _AddPersonFormState();
}

class _AddPersonFormState extends State<AddPersonForm> {
  //TYPING REQUIRED
  final _person = Person();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.assignment),
              title: Text('Person Name'),
              subtitle: TextFormField(
                autofocus: true,
                validator: (value){
                  if (value!.isEmpty){
                    return "Please Enter an actual name";
                  }
                  return null;
                },
                onSaved: (value) => setState(() {
                  _person.name = value;
                }),
              ),
            ),

            Padding(
                padding: EdgeInsets.only(top: 16.0),
              child: Center(
                child: ElevatedButton(
                  child: Text("Add Person"),
                  onPressed: (){
                    final form = _formKey.currentState!;
                    if (form.validate()){
                      form.save();

                      ScaffoldMessenger.of(context).
                      showSnackBar(SnackBar(
                          content: Text("Person ${_person.name} added")
                      )
                      );

                      Navigator.pop(context, _person);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

