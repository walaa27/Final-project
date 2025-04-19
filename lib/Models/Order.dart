class Order{
  Order({
    this.totalPrice="0",
    this.orderTime="",
    this.address="",
    this.orderID="0",
  });

  String totalPrice;
  String orderID;
  String orderTime;
  String address;

  // [{"orderID":"1","total":"2000","address":"zeemer","orderTime":"2024-11-30","fullNameOrder":""}]

  factory Order.fromJson(Map<String,dynamic> json)=>Order(
    totalPrice: json ["totalPrice"],
    orderTime: json["orderTime"],
    address: json["address"],
    orderID: json["orderID"],
  );
  Map<String,dynamic> toJson() => {
    "totalPrice": totalPrice,
    "orderTime": orderTime,
    "address": address,
    "orderID": orderID,

  };
}