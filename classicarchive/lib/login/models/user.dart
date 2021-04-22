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
}
