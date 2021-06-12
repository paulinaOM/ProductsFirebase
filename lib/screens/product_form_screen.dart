import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:practica4/firebase/firebase_provider.dart';
import 'package:practica4/models/products_dao.dart';


class ProductForm extends StatefulWidget {
  ProductForm({Key key}) : super(key: key);

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtDescription = TextEditingController();

  FirebaseProvider providerFirebase;
  final _imagePicker = ImagePicker();
  File _imageFile;
  String _imageName = "Select image";
  
  @override
  void initState(){
    super.initState();
    providerFirebase = FirebaseProvider();
  }

  @override
  Widget build(BuildContext context) {
    Image coverImage;
    (_imageFile != null)? coverImage = Image.file(File(_imageFile.path), width: 400.0, fit: BoxFit.fill,) : coverImage = Image.network('https://i0.wp.com/elfutbolito.mx/wp-content/uploads/2019/04/image-not-found.png?ssl=1', height: 300,);

    return  Scaffold(
      appBar: AppBar(
        title: Text("New Product"),
      ),
      body: Form(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal:15, vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 230.0,
                child: coverImage,
              ),
              TextFormField(
                controller: txtName,
                decoration: InputDecoration(
                  labelText: "Name",
                  hintText: "Product name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
                ),
              ),
              TextFormField(
                controller: txtDescription,
                decoration: InputDecoration(
                  labelText: "Description",
                  hintText: "Product description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(_imageName, overflow: TextOverflow.clip,)),
                  SizedBox(width: 50,),
                  RaisedButton(
                    child: Icon(Icons.upload_sharp),
                    onPressed: chooseFile,
                  )
                ],
              ),
              RaisedButton(
                color: Color(0xFF006db3), //Colors.transparent
                hoverColor: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    //side: BorderSide(color: Color(0xFFCC2948))
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Save",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                onPressed: (){
                  saveProduct();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveProduct() async{
    if(txtName.text.isNotEmpty && txtDescription.text.isNotEmpty && _imageFile != null ){
      final _firebaseStorage = FirebaseStorage.instance;
      var snapshot = await _firebaseStorage.ref()
        .child("products")
        .child(txtName.text.trim())
        .putFile(_imageFile);
      String imageURL = await snapshot.ref.getDownloadURL();
      
      ProductDAO product = ProductDAO(
        name: txtName.text,
        description: txtDescription.text,
        image: imageURL.toString()
      );

      await providerFirebase.saveProduct(product);
    }
    else{
      print('No se han llenado todos los campos');
    }
  }

  Future chooseFile() async {
    await _imagePicker.getImage(source: ImageSource.gallery).then((image) {
      String imgName = image.path;
      List<String> arrayName = imgName.split("/");
      
      setState(() {
        _imageFile = File(image.path);
        _imageName = arrayName[arrayName.length -1];
      });
    });
  }
}