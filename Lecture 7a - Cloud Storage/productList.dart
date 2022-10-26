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
      body: _buildProductList(context),
      floatingActionButton: FloatingActionButton(
        onPressed: _addToDb,
        tooltip: "Add",
        child: const Icon(Icons.add),
      ),
    );
  }

  Future getProducts() async{
    print("Getting the products...");
    return await FirebaseFirestore.instance.collection('products').get();
  }

  Widget _buildProduct(BuildContext context, DocumentSnapshot productData){
    final product = Product.fromMap(
        productData.data(),
        reference: productData.reference);
    return GestureDetector(
      child: ListTile(
        title: Text(product.name!),
        subtitle: Text(product.type!),
        trailing: Text(product.cost!.toString()),
      ),
      onLongPress: (){
        //todo: delete
      },
    );
  }

  Widget _buildProductList(BuildContext context){
    return FutureBuilder(
        future: getProducts(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          print("Snapshot: $snapshot");
          if (!snapshot.hasData){
            print("Data is missing from BuildProductList");
            return CircularProgressIndicator();
          }
          print("Found data for BuildProductList");
          return ListView(
            padding: EdgeInsets.all(16),
            children: snapshot.data.docs.map<Widget>( (document)
              => _buildProduct(context, document)
            ).toList(),
          );
        }
    );
  }

  Future _addToDb() async{
    print("Adding a new entry...");
    final data = <String,Object?>{
      "name": "hoodie",
      "type": "clothing",
      "cost": 40.00
    };
    await
    FirebaseFirestore.instance.collection('products').doc().set(data);
    setState(() {
      print("Added data: $data");
    });

  }
}
