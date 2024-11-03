class UserModel {
  final String name;
  final String email;
  final String uid;
  final bool hasProfileImage;

  UserModel({
    required this.name,
    required this.email,
    required this.uid,
    required this.hasProfileImage,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "uid": uid,
      "hasProfileImage": hasProfileImage,
    };
  }

  UserModel.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        email = json["email"],
        uid = json["uid"],
        hasProfileImage = json["hasProfileImage"];

  UserModel.empty()
      : name = "",
        email = "",
        uid = "",
        hasProfileImage = false;

  UserModel copyWith({
    String? name,
    String? email,
    String? uid,
    bool? hasProfileImage,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      uid: uid ?? this.uid,
      hasProfileImage: hasProfileImage ?? this.hasProfileImage,
    );
  }
}
