import 'package:flutter/material.dart';
import 'add_chore.dart';
import 'model/chore_model.dart';
import 'model/db_utils.dart';
import 'model/chore.dart';
import 'model/chore_model.dart';

class ChoreList extends StatefulWidget {
  final String? title;
  const ChoreList({Key? key, this.title}) : super(key: key);

  @override
  State<ChoreList> createState() => _ChoreListState();
}

class _ChoreListState extends State<ChoreList> {
  List<Chore> _chores = [];
  ChoreModel _choreModel = new ChoreModel();
  @override
  void initState() {

    super.initState();
    reload(true);
  }

  void reload(bool updateState){
    _choreModel.getAllChores(null).then((chores){

        setState(() {
          _chores = chores;
        });

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
                  var chore = _chores[index];
                  return Dismissible(
                      key: Key(chore.id.toString()),
                      onDismissed: (direction){
                        _deleteChore(index);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Chore ${chore.name} deleted')));
                      },
                      child: ListTile(
                        title: Text(_chores[index].name!),
                        dense: false,
                      ),
                  );
                },
              itemCount: _chores == null ? 0 : _chores.length,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: "Add Chore",
        onPressed: (){
          _addChore().then((chore){
            if (chore != null){
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Chore ${chore.name} added')
              ));
            }
          });
        },
      ),
    );
  }

  Future _addChore() async {
    Chore chore = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => AddChore()));
    if (chore != null){
      setState(() {
        _chores.add(chore);
      });
      _choreModel.insertChore(null, chore);
      return chore;
    }
    return null;
  }

  void _deleteChore(int index){
    if (index < _chores.length){
    setState(() {
      _chores.removeAt(index);
    });
    _choreModel.deleteChore(null, _chores[index].id!);
  }
  }
}
