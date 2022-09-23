import 'package:flutter/material.dart';

class LayoutExample{
  String? name;
  Widget? icon;
  Function? builder;

  LayoutExample({this.builder, this.icon, this.name});
}

//PreferredSizeWidget was necessary for the TabBar to be
//inserted within the AppBar, otherwise error :(

//DefaultTabController handles the linking between the TabBar
//and the TabBarView without you needing to implement it

PreferredSizeWidget buildTabBar(List<LayoutExample> options){
  return TabBar(tabs: options.map((option) => Tab(text: option.name, icon: option.icon,)
  ).toList(),
  );
}

buildTabBarView(options){
  return TabBarView(children: options.map<Widget>((option){
    return Container(child: option.builder(),);
  }).toList()
  );
}