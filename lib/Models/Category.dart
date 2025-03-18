class category {
  category({
    this.categoryID    = 0,
    this.categoryName = "",


  });

  int categoryID   ;
  String categoryName;


  factory category.fromJson(Map<String, dynamic> json)=>
      category(
        categoryID: json ["categoryID"],
        categoryName: json["categoryName"],


      );

  Map<String, dynamic> toJson() =>
      {
        "categoryID ":categoryID    ,
        "categoryName":categoryName ,


      };
}