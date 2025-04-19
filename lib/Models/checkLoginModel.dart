class checkLoginModel {
  int? userID;
  String? FirstName;
  String? LastName;
  String? Email;


  checkLoginModel({
    this.userID,
    this.FirstName,
    this.LastName,
    this.Email,
  });


  factory checkLoginModel.fromJson(Map<String, dynamic> json) {
    return checkLoginModel(
        userID: json['userID'],
        FirstName: json['FirstName'],
        LastName: json['LastName'],
        Email: json['Email'],
    );
  }
}
