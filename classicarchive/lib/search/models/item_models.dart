import 'dart:ui';

import 'package:flutter/material.dart';

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
  final List<String> tooltipLabels;

  // The color corresponding to this items rarity, which is used when displaying its name.
  final Color rarityColor;

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
    this.tooltipLabels,
    this.rarityColor
  });

  static ItemDetail fromJson(dynamic json) {
    Color tempColorStorage;
    switch (json['tooltip'][0]['format']) {
      case "Poor":
        tempColorStorage = Color(0xFF9d9d9d);
        break;
      case "Common":
        tempColorStorage = Colors.white;
        break;
      case "Uncommon":
        tempColorStorage = Color(0xFF1EFF00);
        break;
      case "Rare":
        tempColorStorage = Color(0xFF0070DD);
        break;
      case "Epic":
        tempColorStorage = Color(0xFFA335EE);
        break;
      case "Legendary":
        tempColorStorage = Color(0xFFFF8000);
        break;
      default:
        // We should never reach this case, so display an error color if we do.
        tempColorStorage = Colors.red;
        break;
    }

    List<String> labels = [];
    for (int i = 1; i < json['tooltip'].length - 1; i++) {
      labels.add(json['tooltip'][i]['label']);
    }


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
      tooltipLabels: labels,
      rarityColor: tempColorStorage
    );
  }
}