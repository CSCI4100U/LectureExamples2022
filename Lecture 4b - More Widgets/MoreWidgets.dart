import 'package:flutter/material.dart';

import 'NavPage.dart';
import 'createDrawer.dart';

class MoreWidgetsPage extends StatefulWidget {
  const MoreWidgetsPage({Key? key, this.title})
      : super(key: key);

  final String? title;

  @override
  State<MoreWidgetsPage> createState() => _MoreWidgetsPageState();
}

class _MoreWidgetsPageState extends State<MoreWidgetsPage> {

  int myNumber = 0;
  int selectedIndex = 0;

  List<NavPage> pages = [
    NavPage(name: "Add to Cart", icon: Icons.add_shopping_cart),
    NavPage(name: "Be Sad", icon: Icons.javascript),
    NavPage(name: "Join the Navy", icon: Icons.radar),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
        actions: [
          IconButton(
              onPressed: (){
                print("Add to cart");
              },
              icon: const Icon(Icons.add_shopping_cart)
          ),
          IconButton(
              onPressed: (){
                print("Remove from cart");
              },
              icon: const Icon(Icons.remove_shopping_cart)
          ),
          PopupMenuButton(
              itemBuilder: (context){
                List<String> menuItems = ["New", "Open", "Save"];
                return menuItems.map(
                        (menuItem) => PopupMenuItem(
                            value: menuItem,
                            child: Text(menuItem),
                        ),
                ).toList();
              },
            onSelected: (value){
                print("Selected Popup menu option $value");

                if (value == "Save"){
                  //save code here
                  print("Save successful!");
                  //use Navigator.of(context).push() <like this>
                  //which goes to a new page
                }
            },
          ),
        ],
      ),
      body: Center(
          child: Text("Here is the number: $myNumber",
            style: const TextStyle(fontSize: 30),
          ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            myNumber++;
          });
        },
        child: const Icon(Icons.more_vert),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        unselectedFontSize: 30,
        selectedFontSize: 30,
        items: pages.map(
                (page) => BottomNavigationBarItem(
                    icon: Icon(page.icon),
                    label: page.name
                )
        ).toList(),
        onTap: (index){
          setState(() {
            selectedIndex = index;
            print("Switching to page $index");
          });
        },
      ),
      drawer: createDrawer(),
    );
  }
}
