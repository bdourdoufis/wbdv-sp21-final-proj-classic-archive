import 'package:classicarchive/search/models/item_model.dart';
import 'package:flutter/foundation.dart';

import 'item_api_search_client.dart';

class ItemSearchRepository {
  final ItemApiSearchClient client = ItemApiSearchClient();

  ItemSearchRepository();

  Future<List<Item>> searchItems(String searchQuery) async {
    return await client.searchItems(searchQuery);
  }
}