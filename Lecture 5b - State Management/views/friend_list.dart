import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lec5b/model/friends.dart';

class FriendListWidget extends StatelessWidget {
  const FriendListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    FriendListBLoC friendListBLoC = context.watch<FriendListBLoC>();

    return ListView.builder(
      padding: EdgeInsets.all(8.0),
        itemCount: friendListBLoC.friends.length,
        itemBuilder: (context, index){
          return Container(
            padding: EdgeInsets.all(10.0),
            child: Text("${friendListBLoC.friends[index]}",
            style: TextStyle(fontSize: 30),
            ),
          );
        }
    );
  }
}
