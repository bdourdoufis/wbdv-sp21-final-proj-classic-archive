class User {
  String userId;
  String username;
  String password;
  String faction;
  String favoriteClass;

  User(
      {this.userId,
      this.username,
      this.password,
      this.faction,
      this.favoriteClass});

  static User fromJson(dynamic json) {
    return User(
        userId: json["_id"],
        username: json["username"],
        password: json["password"],
        faction: json["faction"],
        favoriteClass: json["favoriteClass"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["_id"] = userId;
    data["username"] = username;
    data["password"] = password;
    data["faction"] = faction;
    data["favoriteClass"] = favoriteClass;
    return data;
  }
}
