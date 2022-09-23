import 'package:flutter/material.dart';

Widget buildGridView(){
  return GridView.count(
    crossAxisCount: 3, //items per row of the grid
  mainAxisSpacing: 15, //vertical spacing between the rows
  crossAxisSpacing: 20, //horizontal spacing between the items in a row
  padding: const EdgeInsets.all(20), //extra whitespace from the outside of the grid
  children: buildGridViewItems(16),);
}

List<Widget> buildGridViewItems(int count){
  List<Widget> itemList = [];

  for (int i = 0; i < count; i ++){
    itemList.add(buildGridViewItem(i));
  }
  return itemList;
}

Widget buildGridViewItem(int index){
  Color? color = Colors.blue[100+100*index];
  if (index > 8){
    color = Colors.red[100+100*(index - 9)];
  }

  return Container(
    height: 100,
    color: color,
    child: Center(child: Text("Entry $index")),
  );
}