import 'package:classicarchive/search/models/item_models.dart';
import 'package:classicarchive/search/provider/item_api_search_repository.dart';
import 'package:rxdart/rxdart.dart';

/// A BLoC which will be used to interact with the NexusHub remote API to fetch
/// item information. Flutter uses the BLoC pattern as an alternative
/// to classic MVC. You can read more about it here:
/// https://www.raywenderlich.com/4074597-getting-started-with-the-bloc-pattern
class SearchBloc {
  ItemSearchRepository repository = ItemSearchRepository();

  /// Fetches a list of items, for when  the user searches.
  final _itemFetcher = PublishSubject<List<Item>>();

  /// Fetches an item's details.
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
