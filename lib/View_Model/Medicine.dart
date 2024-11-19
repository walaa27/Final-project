class Medicine {
  Medicine({
    this.MedicineID   = "",
    this.MedicinName = "",
    this.Price = 0,
    this.ExpiryDate = "",


  });

  String MedicineID  ;
  String MedicinName;
  double Price;
  String ExpiryDate;


  factory Medicine.fromJson(Map<String, dynamic> json)=>
      Medicine(
        MedicineID  : json ["MedicineID"],
        MedicinName: json["MedicinName"],
        Price: json["Price"],
        ExpiryDate: json["ExpiryDate"],


      );

  Map<String, dynamic> toJson() =>
      {
        "MedicineID":MedicineID   ,
        "MedicinName":MedicinName ,
        "Price": Price,
        "ExpiryDate": ExpiryDate,


      };
}