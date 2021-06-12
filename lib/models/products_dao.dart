class ProductDAO{

  String name;
  String description;
  String image;

  ProductDAO({this.name, this.description, this.image});

  Map<String,dynamic> tomap(){
    return {
      'name'        : name,
      'description' : description,
      'image'       : image
    };
  }
}