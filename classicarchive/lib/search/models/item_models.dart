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

class ItemDetail {
  final int itemId;
  final String name;
  final String uniqueName;
  final String icon;
  final List<dynamic> tags;
  final int requiredLevel;
  final int itemLevel;
  final int sellPrice;
  final int vendorPrice;
  final String itemLink;
  final String tooltipLabel;

  ItemDetail({
    this.itemId,
    this.name,
    this.uniqueName,
    this.icon,
    this.tags,
    this.requiredLevel,
    this.itemLevel,
    this.sellPrice,
    this.vendorPrice,
    this.itemLink,
    this.tooltipLabel
  });

  static ItemDetail fromJson(dynamic json) {
    //TODO: Store item rarity so it can be used for styling
    //json['tooltip'][0]['format']
    return ItemDetail(
      itemId: json['itemId'],
      name: json['name'],
      uniqueName: json['uniqueName'],
      icon: json['icon'],
      tags: json['tags'],
      requiredLevel: json['requiredsLevel'],
      itemLevel: json['itemLevel'],
      sellPrice: json['sellPrice'],
      vendorPrice: json['vendorPrice'],
      itemLink: json['itemLink'],
      tooltipLabel: json['tooltip'][0]['label']
    );
  }
}