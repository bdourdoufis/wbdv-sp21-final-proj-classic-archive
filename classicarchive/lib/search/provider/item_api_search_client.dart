import 'dart:convert';

import 'package:classicarchive/search/models/item_models.dart';
import 'package:http/http.dart' as http;

class ItemApiSearchClient {
  final _baseSearchUrl = 'https://api.nexushub.co/wow-classic/v1/search?query=';
  final _baseDetailUrl = 'https://api.nexushub.co/wow-classic/v1/item/';
  final http.Client httpClient = http.Client();

  ItemApiSearchClient();

  Future<List<Item>> searchItems(String searchQuery) async {
    final url = Uri.parse('$_baseSearchUrl"$searchQuery"');
    final response = await this.httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception("Error while searching for items.");
    }

    final json = jsonDecode(response.body).cast<Map<String, dynamic>>();

    return json.map<Item>((entry) => Item.fromJson(entry)).toList();
  }

  Future<ItemDetail> getItemDetail(int itemId) async {
    final url = Uri.parse('$_baseDetailUrl$itemId');
    final response = await this.httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception("Error while retrieving item details");
    }

    final json = jsonDecode(response.body);
    return ItemDetail.fromJson(json);
  }
}
