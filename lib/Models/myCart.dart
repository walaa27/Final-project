class MyCart {
  MyCart({
    this.UserID  = 0,
    this.productID = 0,
    this.quantity = 0,
    this.productName = "",

  });

  int UserID ;
  int productID;
  int quantity;
  String productName;



  factory MyCart.fromJson(Map<String, dynamic> json)=>
      MyCart(
        UserID: json["UserID"],
        productID: json["productID"],
        quantity: json["quantity"],
        productName: json["productName"],


      );

  Map<String, dynamic> toJson() =>
      {
        "UserID":UserID  ,
        "productID":productID ,
        "quantity": quantity,
        "productName": productName,

      };
}