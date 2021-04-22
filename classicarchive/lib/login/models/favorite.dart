class Favorite {
  String username;
  String itemId;

  Favorite({this.username, this.itemId});

  static Favorite fromJson(dynamic json) {
    return Favorite(username: json["username"], itemId: json["itemId"]);
  }
}
