import 'package:flutter/material.dart';

import 'model/person.dart';

class AddPerson extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Person")),
        body: AddPersonForm(),
      );
  }
}


class AddPersonForm extends StatefulWidget {

  @override
  State<AddPersonForm> createState() => _AddPersonFormState();
}

class _AddPersonFormState extends State<AddPersonForm> {
  //TYPING BELOW REQUIRED
  final _formKey = GlobalKey<FormState>();
  final _person = Person();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: const Icon(Icons.assignment),
                title: Text('Person name:'),
                subtitle: TextFormField(
                  autofocus: true,
                  validator: (value){
                    if (value!.isEmpty){
                      return "please Enter some text";
                    }
                    return null;
                  },
                  onSaved: (value) => setState(() {
                    _person.name = value;
                  }),
                ),
              ),
              Padding(padding: const EdgeInsets.only(top: 16.0),
                child: Center(
                  child: ElevatedButton(
                    child: Text("Add Person"),
                    onPressed: (){
                      final form = _formKey.currentState!;
                      if (form.validate()){
                        form.save();

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Person '${_person.name}' added")
                        )
                        );

                        Navigator.pop(context, _person);
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
}
