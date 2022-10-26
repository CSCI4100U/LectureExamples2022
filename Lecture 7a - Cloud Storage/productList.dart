import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'product.dart';

class ProductList extends StatefulWidget {
  ProductList({Key? key, this.title}) : super(key: key);

  String? title;

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addToDb,
        tooltip: "Add",
        child: const Icon(Icons.add),
      ),
    );
  }

  Future _addToDb() async{
    print("Adding a new entry...");
    final data = <String,Object?>{
      "name": "beanie",
      "type": "clothing",
      "cost": 5.00
    };
    await
    FirebaseFirestore.instance.collection('products').doc().set(data);
    setState(() {
      print("Added data: $data");
    });

  }
}
