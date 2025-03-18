class Order {
  Order({
    this.orderID  = 0,
    this.totalPrice = 0,
    this.address = "",
    this.orderTime = "",


  });

  int orderID ;
  int totalPrice;
  String address;
  String orderTime;


  factory Order.fromJson(Map<String, dynamic> json)=>
      Order(
        orderID: json["orderID"],
        totalPrice: json["totalPrice"],
        address: json["address"],
        orderTime: json["orderTime"],

      );

  Map<String, dynamic> toJson() =>
      {
        "orderID":orderID  ,
        "totalPrice":totalPrice ,
        "address": address,
        "orderTime": orderTime,


      };
}