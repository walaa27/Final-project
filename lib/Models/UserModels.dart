class User{
  User({
    this.id="",
    this.name="",
    this.phone="",
    this.note="",
    this.adress=""
});
  String id;
  String name;
  String phone;
  String note;
  String adress;
  factory User.fromJson(Map<String, dynamic>json)=> User(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    note: json["note"],
    adress: json["adress"],
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "note": note,
    "adress": adress,
  };
}