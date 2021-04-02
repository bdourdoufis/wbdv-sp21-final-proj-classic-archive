import 'package:classicarchive/search/models/item_model.dart';
import 'package:classicarchive/search/provider/item_api_search_repository.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc {
  ItemSearchRepository repository = ItemSearchRepository();

  final _itemFetcher = PublishSubject<List<Item>>();

  Stream<List<Item>> get itemResult => _itemFetcher.stream;

  searchItems(String searchQuery) async {
    List<Item> items = await repository.searchItems(searchQuery);
    _itemFetcher.sink.add(items);
  }

  dispose() {
    _itemFetcher.close();
  }
}

final searchBloc = SearchBloc();