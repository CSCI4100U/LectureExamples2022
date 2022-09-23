import 'package:flutter/material.dart';

//itembuilder is the parameter that given the context of
//the widgets you working with and an index per item,
//construct each item using a function/constructor

Widget buildListView(){
  return ListView.separated(
      itemBuilder: (context, index) => Container(
        height: 70,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: goodColor(index),
        ),
        child: Text("Box Number $index"),
      ),
      separatorBuilder: (context, index) => Divider(),
      itemCount: 30
  );
}

Color? goodColor(int index){
  if (index <= 8){
    return Colors.blue[index*100+100];
  }
  if (index <= 16){
    return Colors.red[(index-8)*100+100];
  }
  if (index <= 24){
    return Colors.green[(index-16)*100+100];
  }
  else{
    return Colors.amber[(index-24)*100+100];
  }
}