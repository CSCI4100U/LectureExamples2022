import 'package:flutter/material.dart';
import 'add_person.dart';
import 'model/db_utils.dart';
import 'model/person.dart';
import 'model/person_model.dart';

class PeopleList extends StatefulWidget {
  final String? title;
  const PeopleList({Key? key, this.title}) : super(key: key);

  @override
  State<PeopleList> createState() => _PeopleListState();
}

class _PeopleListState extends State<PeopleList> {
  List<Person> _people = [];
  PersonModel _personModel = new PersonModel();
  @override
  void initState() {

    super.initState();
    reload(true);
  }

  void reload(bool updateState){
    _personModel.getAllPeople(null).then((people){
      if (updateState) {
        setState(() {
          _people = people;
        });
      } else{
        _people = people;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Builder(
        builder: (context){
          return Padding(padding: const EdgeInsets.only(top: 16.0),
            child: ListView.builder(
                itemBuilder: (context, index){
                  var person = _people[index];
                  return Dismissible(
                      key: Key(person.id.toString()),
                      onDismissed: (direction){
                        setState(() {
                          _people.removeAt(index);
                        });
                        _personModel.deletePerson(null, person.id!);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Person ${person.name} deleted')));
                      },
                      child: ListTile(
                        title: Text(_people[index].name!),
                        dense: false,
                      ),
                  );
                },
              itemCount: _people == null ? 0 : _people.length,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: "Add Person",
        onPressed: (){
          _addPerson().then((person){
            if (person != null){
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Person ${person.name} added')
              ));
            }
          });
        },
      ),
    );
  }

  Future _addPerson() async {
    Person person = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddPerson()));
    if (person != null && person.name != null && person.name!.length > 0){
      setState(() {
        _people.add(person);
      });
      _personModel.insertPerson(null, person);
      return person;
    }
    return null;
  }
}
