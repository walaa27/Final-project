class User {
  User({
    this.UserID = "",
    this.PhoneOrEmail = "",
    this.FirstName = "",
    this.LastName = "",
    this.Password = "" ,


  });

  String UserID;
  String FirstName;
  String LastName;
  String Password;
  String PhoneOrEmail;


  factory User.fromJson(Map<String, dynamic> json)=>
      User(
        UserID: json ["UserID"],
        FirstName: json["FirstName"],
        LastName: json["LastName"],
        Password: json["Password"],
        PhoneOrEmail: json["PhoneOrEmail"],

      );

  Map<String, dynamic> toJson() =>
      {
        "UserID":UserID ,
        "FirstName":FirstName ,
        "LastName": LastName,
        "Password": Password,
        "PhoneOrEmail":PhoneOrEmail,


      };
}