import 'package:flutter/material.dart';
import 'package:lec3/tab_page.dart';

import 'grid_view.dart';
import 'list_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const BasicLayout(title: 'More Basic Layouts'),
    );
  }
}

class BasicLayout extends StatefulWidget {
  const BasicLayout({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<BasicLayout> createState() => _BasicLayoutState();
}

class _BasicLayoutState extends State<BasicLayout> {

  @override
  Widget build(BuildContext context) {


    //these are the five different types of layouts
    //we constructed during tuesday-friday of week 3

    List<LayoutExample> options = [
      LayoutExample(name: "Column", icon: Icon(Icons.view_column),
          builder: buildColumnWidget),
      LayoutExample(name: "Row", icon: Icon(Icons.reorder),
          builder: buildRowWidget),
      LayoutExample(name: "Stack", icon: Icon(Icons.filter_none),
          builder: buildStackWidget),
      LayoutExample(name: "List", icon: Icon(Icons.view_list),
          builder: buildListView),
      LayoutExample(name: "Grid", icon: Icon(Icons.grid_on),
          builder: buildGridView),
    ];

    //we wrapped our scaffold inside a defaulttabcontroller
    //because we want it to automatically switch between
    //different views (using the Model-View-Controller pattern)

    //we added the TabBar to the bottom of the AppBar to keep
    //the buttons separate from the main page.

    //DefaultTabController uses both the TabBar constructed
    //in the buildTabBar function and the TabBarView returned
    //by the buildTabBarView function in tandem to decide
    //what you see on the screen

    return DefaultTabController(length: options.length, 
        child: Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        bottom: buildTabBar(options),
      ),
      body: buildTabBarView(options),

      )
    );
  }
}

//builds a stack of objects where the first item in the list of children
//is on the 'bottom' and everything else is stacked on top. Alignment of each
//item is dictated by the alignment parameter of the stack and not the objects
//themselves

Widget buildStackWidget(){
  return Stack(
    alignment: Alignment.center,
    children: [
      const CircleAvatar(
        radius: 100,
        child: Text("MM", textScaleFactor: 7.0,),
      ),
      const FlutterLogo(size: 250,),
      Container(
        decoration: const BoxDecoration(
          color: Colors.grey
        ),
        child: Container(

          //padding inserts whitespace from the outside edges of wherever the
          //object is placed. You can use EdgeInsets.all, .only, .symmetric, and
          //more depending on how you want to position things, e.g. centered

          padding: EdgeInsets.all(50),
          child: const Text("Michael",

            //You must add a style if you want to modify more than the basic
            //properties of text, e.g. fontsize, font type, etc.
            //the style is given to the text rather than being used at the top
            //level

            style: TextStyle(
              fontSize: 30
            ),
          ),
        ),
      ),
    ],
  );
}

//Column stretches to fill only what is necessary vertically, and defaults to
//maximum size horizontally
//Containers within a row MUST have a height or won't appear

Widget buildColumnWidget(){
  return Column(

    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [FlutterLogo(size: 200, style: FlutterLogoStyle.stacked,),
      FlutterLogo(size: 100, style: FlutterLogoStyle.horizontal,),
      buildStackWidget(),
    ],
  );
}

//Row stretches to fill only what is necessary horizontally, and defaults to
//maximum size vertically
//Containers within a row MUST have a width or won't appear

Widget buildRowWidget(){
  return Container(
    decoration: BoxDecoration(
      color: Colors.black,
    ),
    //padding: EdgeInsets.symmetric(horizontal: 30),
    // height: 400,
    //width: 400,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
           width: 80,
          // height: 300,
          color: Colors.red,
        ),
        Container(
          width: 80,
          height: 50,
          color: Colors.blue,
        ),
        Container(
          width: 80,
          height: 50,
          color: Colors.green,
        ),
        Container(
          width: 80,
          height: 50,
          color: Colors.amber,
        ),
      ],
    ),
  );
}