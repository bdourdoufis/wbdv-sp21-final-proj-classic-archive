import 'package:classicarchive/search/models/item_models.dart';
import 'package:classicarchive/search/provider/item_api_search_repository.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc {
  ItemSearchRepository repository = ItemSearchRepository();

  final _itemFetcher = PublishSubject<List<Item>>();

  final _itemDetailFetcher = PublishSubject<ItemDetail>();

  Stream<List<Item>> get itemResult => _itemFetcher.stream;

  Stream<ItemDetail> get itemDetail => _itemDetailFetcher.stream;

  searchItems(String searchQuery) async {
    List<Item> items = await repository.searchItems(searchQuery);
    _itemFetcher.sink.add(items);
  }

  getItemDetail(int itemId) async {
    ItemDetail item = await repository.getItemDetail(itemId);
    _itemDetailFetcher.sink.add(item);
  }

  dispose() {
    _itemFetcher.close();
    _itemDetailFetcher.close();
  }
}

final searchBloc = SearchBloc();
