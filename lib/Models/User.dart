class User {
  User({
    this.UserID = "",
    this.FirstName = "",
    this.LastName = "",
    this.Password = "" ,


  });

  String UserID;
  String FirstName;
  String LastName;
  String Password;


  factory User.fromJson(Map<String, dynamic> json)=>
      User(
        UserID: json ["UserID"],
        FirstName: json["FirstName"],
        LastName: json["LastName"],
        Password: json["Password"],

      );

  Map<String, dynamic> toJson() =>
      {
        "UserID":UserID ,
        "FirstName":FirstName ,
        "LastName": LastName,
        "Password": Password,


      };
}