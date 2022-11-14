import 'package:flutter/material.dart';

import 'chore_list.dart';
import 'person_list.dart';

class Menu{

  //MUST BE STATIC
  static createMenu(BuildContext context){
    return [
      IconButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChoreList(title: "Chore List",)));
      },
          icon: Icon(Icons.event),
      ),
      IconButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => PeopleList(title: "People List",)));
      },
        icon: Icon(Icons.people),
      ),
    ];
  }
}