import 'package:flutter/material.dart';

class Friend{
  String? firstName;
  String? lastName;
  String? email;

  Friend({this.email,this.firstName,this.lastName});

  String toString() {
    return "$firstName $lastName at ($email)";
  }
}

class FriendListBLoC with ChangeNotifier{
  List<Friend> _friends = [
    Friend(email: "michael.miljaonvic@uoit.ca",
        firstName: "Michael",
      lastName: "Miljanovic"
    ),
    Friend(email: "Randy.Fortier@uoit.ca",
        firstName: "Randy",
        lastName: "Fortier"
    ),
    Friend(email: "Jeremy.Bradbury@uoit.ca",
        firstName: "Jeremy",
        lastName: "Bradbury"
    ),
  ];

  List<Friend> get friends => _friends;

  set friends(newFriendList){
    _friends = newFriendList;
    notifyListeners();
  }
  addFriend(newFriend){
    _friends.add(newFriend);
    notifyListeners();
  }

}