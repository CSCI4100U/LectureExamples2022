import 'package:flutter/material.dart';
import 'add_person.dart';
import 'package:lec9/models/db_utils.dart';
import 'package:lec9/models/person.dart';
import 'package:lec9/models/person_model.dart';

class PersonList extends StatefulWidget {
  final String? title;
  const PersonList({Key? key, this.title}) : super(key: key);

  @override
  State<PersonList> createState() => _PersonListState();
}

class _PersonListState extends State<PersonList> {
  List<Person> _persons = [];
  PersonModel _personModel = new PersonModel();

  @override
  void initState(){
    super.initState();
    reload(true);
  }

  void reload(bool updateState){
    _personModel.getAllPersons(null).
    then( (persons) {
        if (updateState){
          setState(() {
            _persons = persons;
          });
        }
        else{
          _persons = persons;
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Builder(
        builder: (context){
          return Padding(
              padding: EdgeInsets.only(top: 16.0),
            child: ListView.builder(
                itemCount: _persons == null ? 0 : _persons.length,
                itemBuilder: (context,index){
                  var person = _persons[index];
                  return Dismissible(
                      key: Key(person.id.toString()),
                      onDismissed: ((direction) {
                        setState(() {
                          _persons.removeAt(index);
                        });
                        _personModel.deletePerson(null, person.id!);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                            SnackBar(
                            content: Text("Person ${person.name} deleted"))
                        );

                      }),
                      child: ListTile(
                        title: Text(person.name!),
                        dense: false,
                      ),
                  );
                }
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: "Add Person",
        onPressed: (){
          _addPerson().then( (person) {
            if (person != null){
              ScaffoldMessenger
                  .of(context)
                  .showSnackBar(
                  SnackBar(content: Text("Person ${person.name} added"))
              );
            }
          }  );
        },
      ),
    );
  }

  Future _addPerson() async{
    Person person = await Navigator
        .push(context,
        MaterialPageRoute(
            builder: (context) => AddPersonPage()
        )
    );
    if (person != null && person.name != null && person.name!.length>0){
      setState(() {
        _persons.add(person);
      });
      _personModel.insertPerson(null, person);
      return person;
    }
    return null;
  }
}
