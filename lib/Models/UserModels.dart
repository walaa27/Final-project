class User{
  User({
    this.id="",
    this.name="",
    this.phone="",
    this.note="",
});
  String id;
  String name;
  String phone;
  String note;
  factory User.fromJson(Map<String, dynamic>json)=> User(
    id: json["id"],
    name: json["id"],
    phone: json["id"],
    note: json["id"],
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "note": note,
  };
}