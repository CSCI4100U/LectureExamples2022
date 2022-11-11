import 'package:flutter/material.dart';

var selectIcon;

class IconSelecter{
  static _buildIconTextList(BuildContext context){
    final _icon = [
      'assets/icons8-alarms-100.png',
      'assets/icons8-aquarium-100.png',
      'assets/icons8-brain-100.png',
    ];
    List<Widget> WidgetList = [];
    for (int i = 0; i < _icon.length; i++){
      WidgetList.add(
        TextButton(
            onPressed: (){
              selectIcon = _icon[i];
              Navigator.of(context).pop(_icon[i]);
            },
            child: Image.asset(_icon[i])
        )
      );
    }
    return WidgetList;
  }

  static AlertDialog getIconSelectorDialog(BuildContext context){
    return AlertDialog(
      title: Text("Select an Icon"),
      content: Container(
        width: double.maxFinite,
        child: GridView.count(crossAxisCount: 4,
          children: [
            _buildIconTextList(context)
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            child: Text("Cancel"))
      ],
    );
  }
}