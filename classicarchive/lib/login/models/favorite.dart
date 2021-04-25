/// A model representing a single user-item favorite.
class Favorite {
  String username;
  int itemId;
  String itemName;

  Favorite({this.username, this.itemId, this.itemName});

  static Favorite fromJson(dynamic json) {
    return Favorite(
        username: json["username"],
        itemId: json["itemId"],
        itemName: json["itemName"]);
  }
}
