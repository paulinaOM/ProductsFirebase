import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practica4/models/products_dao.dart';

class FirebaseProvider{
  FirebaseFirestore _firestore;
  CollectionReference _productsCollection;

  FirebaseProvider(){
    _firestore = FirebaseFirestore.instance;
    _productsCollection = _firestore.collection('products');
  }

  Future<void> saveProduct(ProductDAO product){
    _productsCollection.add(product.tomap()); //Mandar un objeto producto convertido a mapa, ya que add solicita un mapa
  }

  Future<void> updateProduct(ProductDAO product, String documentID){
    return _productsCollection.doc(documentID).update(product.tomap());
  }

  Future<void> removeProduct(String documentID){
    return _productsCollection.doc(documentID).delete();
  }

  Stream<QuerySnapshot> getAllProducts(){
    return _productsCollection.snapshots();
  }
}