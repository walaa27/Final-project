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

  // $arr = array( 'orderID' => "$orderID",
  // 'total' => "$total",
  // 'notes' => $notes,
  // 'orderTime' => $orderTime



  factory Order.fromJson(Map<String,dynamic> json)=>Order(
    totalPrice: json ["total"],
    orderTime: json["orderTime"],
    address: json["notes"],
    orderID: json["orderID"],
  );
  Map<String,dynamic> toJson() => {
    "totalPrice": totalPrice,
    "orderTime": orderTime,
    "address": address,
    "orderID": orderID,

  };
}