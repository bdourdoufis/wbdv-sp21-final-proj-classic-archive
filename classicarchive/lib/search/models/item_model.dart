class Item {
  final int itemId;
  final String name;
  final String uniqueName;
  final String imgUrl;

  Item({this.itemId, this.name, this.uniqueName, this.imgUrl});

  static Item fromJson(dynamic json) {
    return Item(
      itemId: json['itemId'],
      name: json['name'],
      uniqueName: json['uniqueName'],
      imgUrl: json['imgUrl']
    );
  }
}