class Product {
  Product({
    this.productID = 0,
    this.productName = "",
    this.productPrice = 0,
    this.categoryID = 0,
    this.imageURL = "",
  });

  int productID;
  String productName;
  int productPrice;
  int categoryID;
  String imageURL;

  factory Product.fromJson(Map<String, dynamic> json)=>
      Product(
        productID: json["productID"],
        productName: json["productName"],
        productPrice: json["productPrice"],
        categoryID: json["categoryID"],
        imageURL: json["imageURL"],
      );





  Map<String, dynamic> toJson() =>
      {
        "productID": productID,
        "productName": productName,
        "productPrice": productPrice,
        "categoryID": categoryID,
        "imageURL": imageURL,

      };
}