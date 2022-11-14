import 'package:flutter/material.dart';

import 'model/person.dart';

//NOTE FROM SELF: This seems to work okay? Randy has
//the class making changes because the context didn't
//load properly due to being in a different scaffold,
//but with the newer version of flutter it seems to work idk

//maybe come back and play with this later? The other version
//works fine tho


class AddPerson extends StatefulWidget {
  final String? title;
  const AddPerson({Key? key, this.title}) : super(key: key);

  @override
  State<AddPerson> createState() => _AddPersonState();
}

class _AddPersonState extends State<AddPerson> {
  //TYPING BELOW REQUIRED
  final _formKey = GlobalKey<FormState>();
  final _person = Person();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Form(
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
                      }
                    },
                  )
                ),
              )
            ],
          ),
        )
        ,
      ),
    );
  }
}
