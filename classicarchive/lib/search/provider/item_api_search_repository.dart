import 'package:classicarchive/search/models/item_models.dart';

import 'item_api_search_client.dart';

class ItemSearchRepository {
  final ItemApiSearchClient client = ItemApiSearchClient();

  ItemSearchRepository();

  Future<List<Item>> searchItems(String searchQuery) async {
    return await client.searchItems(searchQuery);
  }

  Future<ItemDetail> getItemDetail(int itemId) async {
    return await client.getItemDetail(itemId);
  }
}