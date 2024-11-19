class Order {
  Order({
    this.Order_ID  = "",
    this.TotalPrice = 0,
    this.Adress = "",
    this.OrderTime = "",


  });

  String Order_ID ;
  double TotalPrice;
  String Adress;
  String OrderTime;


  factory Order.fromJson(Map<String, dynamic> json)=>
      Order(
        Order_ID : json ["Order_ID"],
        TotalPrice: json["TotalPrice"],
        Adress: json["Adress"],
        OrderTime: json["OrderTime"],


      );

  Map<String, dynamic> toJson() =>
      {
        "Order_ID":Order_ID  ,
        "TotalPrice":TotalPrice ,
        "Adress": Adress,
        "OrderTime": OrderTime,


      };
}