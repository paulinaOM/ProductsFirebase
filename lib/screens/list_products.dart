import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practica4/firebase/firebase_provider.dart';
import 'package:practica4/views/card_product.dart';

class ListProducts extends StatefulWidget {
  ListProducts({Key key}) : super(key: key);

  @override
  _ListProductsState createState() => _ListProductsState();

}

class _ListProductsState extends State<ListProducts>{
  FirebaseProvider providerFirebase;
  @override
  void initState(){
    super.initState();
    providerFirebase = FirebaseProvider();
  }

  @override
  Widget build(BuildContext context){
    return StreamBuilder(
      stream: providerFirebase.getAllProducts(),//aquí va la subscripcion a Firebase
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData) return Center(child: CircularProgressIndicator(),);
          return ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document){
              return CardProduct(productDocument: document);
            }).toList()
          );
      }
    );
  }
}