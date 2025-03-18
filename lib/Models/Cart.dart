class Cart {
  Cart({
    this.userID  = 0,
    this.productID = 0,
    this.quantity = 0,
    this.productname = "",

  });

  int userID ;
  int productID;
  int quantity;
  String productname;



  factory Cart.fromJson(Map<String, dynamic> json)=>
      Cart(
        userID: json["userID"],
        productID: json["productID"],
        quantity: json["quantity"],
        productname: json["productname"],


      );

  Map<String, dynamic> toJson() =>
      {
        "userID":userID  ,
        "productID":productID ,
        "quantity": quantity,

      };
}