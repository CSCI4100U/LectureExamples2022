import 'package:flutter/material.dart';

Widget createDrawer(){
  return Drawer(
    child: Container(
      padding: const EdgeInsets.all(50),
      child: ListView.separated(
          itemBuilder: (context, index){
            return Container(
              height: 50,
              color: Colors.red[100+(index*100)],
              child: TextButton(
                onPressed: (){
                  print("You clicked on Index $index");
                },
                child: Text("Index $index",
                  style: const TextStyle(fontSize: 30,
                    color: Colors.black,
                    backgroundColor: Colors.green
                  ),
                ),
              ),
            );

          },
          separatorBuilder: (context,index){
            return const Divider();
          },
          itemCount: 8
      ),
    ),
  );
}