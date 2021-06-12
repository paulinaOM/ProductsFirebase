import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practica4/firebase/firebase_provider.dart';

class CardProduct extends StatelessWidget {
  const CardProduct(
    {
      Key key,
      @required this.productDocument,
    }
  ) : super(key: key);

  final DocumentSnapshot productDocument;

  @override
  Widget build(BuildContext context) {
    final idProduct = productDocument.id;
    FirebaseProvider providerFirebase = FirebaseProvider();
    
    final card = Stack ( 
      alignment: Alignment .bottomCenter, 
      children: [ 
        Container( 
          width: MediaQuery.of(context).size.width, 
          child: FadeInImage(
            placeholder: AssetImage ('assets/activity_indicator.gif'),
            image: (productDocument['image'] != null) ? NetworkImage(productDocument['image']) : NetworkImage('https://i0.wp.com/elfutbolito.mx/wp-content/uploads/2019/04/image-not-found.png?ssl=1'),
            fit: BoxFit.cover, 
            fadeInDuration: Duration(milliseconds: 100), 
            height: 230.0, 
          ), 
        ),
        Opacity(
          opacity: .6, 
          child: Container(
            height: 55.0,
            color: Colors.black, 
            child: Row (
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text (productDocument[ 'name' ], 
                  style: TextStyle (color: Colors .white),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.white,), 
                  onPressed: (){
                    providerFirebase.removeProduct(idProduct);
                  }
                ),
              ], 
            ), 
          ), 
        ), 
      ], 
    );

    return Container(
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.2),
            offset: Offset(0.0,5.0),
            blurRadius: 1.0,
          )
        ]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: card,
      ),
    );
  }
}