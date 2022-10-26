import 'package:cloud_firestore/cloud_firestore.dart';

class Product{
  String? name;
  String? type;
  double? cost;
  DocumentReference? reference;

  Product.fromMap(var map, {this.reference}){
    this.name = map['name'];
    this.type = map['type'];
    this.cost = map['cost'];
  }

  Map<String,Object?> toMap(){
    return {
      'name': this.name,
      'type': this.type,
      'cost': this.cost,
    };
  }

}