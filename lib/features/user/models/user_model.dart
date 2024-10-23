class UserModel {
  final String name;
  final String email;
  final String uid;

  UserModel({
    required this.name,
    required this.email,
    required this.uid,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "uid": uid,
    };
  }

  UserModel.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        email = json["email"],
        uid = json["uid"];

  UserModel.empty()
      : name = "",
        email = "",
        uid = "";
}
