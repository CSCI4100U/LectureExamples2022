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