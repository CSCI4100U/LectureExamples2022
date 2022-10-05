import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0)
      ),
      elevation: 1,
      backgroundColor: Colors.transparent,
      child: buildGridView(),
    );
  }

  buildGridView(){
    return GridView.count(crossAxisCount: 3,
    children: buildGridViewItems(),
      crossAxisSpacing: 30,
      mainAxisSpacing: 10,
    );
  }

  buildGridViewItems(){
    List<Widget> items = [];
    for (int i =0;i<27;i++){
      Color color = Colors.white;
      if (i < 9){
        color = Colors.blue[100+i*100]!;
      } else if (i < 18){
        color = Colors.red[100+(i-9)*100]!;
      } else {
        color = Colors.green[100+(i-18)*100]!;
      }
      items.add(Container(
        height: 50,
        color: color,
        child: Center(
          child: Text("Entry $i",
            style: TextStyle(fontSize: 30
            ),
          ),
        ),
      )
      );
  }
    return items;
  }
}
