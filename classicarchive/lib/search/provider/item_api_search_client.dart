import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:classicarchive/search/models/item_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class ItemApiSearchClient {
  final _baseUrl = 'https://api.nexushub.co/wow-classic/v1/search?query=';
  final http.Client httpClient = http.Client();

  ItemApiSearchClient();

  Future<List<Item>> searchItems(String searchQuery) async {
    final url = Uri.parse('$_baseUrl"$searchQuery"');
    final response = await this.httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception("Error while searching for items.");
    }

    final json = jsonDecode(response.body).cast<Map<String, dynamic>>();

    return json.map<Item>((entry) => Item.fromJson(entry)).toList();
  }
}