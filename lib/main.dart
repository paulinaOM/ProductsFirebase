import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:practica4/screens/list_products.dart';
import 'package:practica4/screens/product_form_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/newProduct': (BuildContext context) => ProductForm(),
        '/home': (BuildContext context) => Home(),
      },
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test Firebase, Database & Storage"),
        actions: [
          MaterialButton(
            child: Icon(Icons.add_circle),
            onPressed: (){
              Navigator.pushNamed(context, '/newProduct');
            },
          )
        ],
      ),
      body: ListProducts(),
    );
  }
}