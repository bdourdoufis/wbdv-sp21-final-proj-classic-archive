import 'package:classicarchive/login/models/user.dart';
import 'package:classicarchive/search/models/item_models.dart';
import 'package:classicarchive/search/provider/item_api_search_repository.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc {
  ItemSearchRepository repository = ItemSearchRepository();

  /*final _itemFetcher = PublishSubject<List<Item>>();

  final _itemDetailFetcher = PublishSubject<ItemDetail>();

  Stream<List<Item>> get itemResult => _itemFetcher.stream;

  Stream<ItemDetail> get itemDetail => _itemDetailFetcher.stream;*/

  login(String username, String password) async {
    //Call java service for login here
  }

  registerUser(String username, String password, String faction) async {
    //Call java service for registration here
  }

  getUserFavorites(User user) async {
    //Get a list of items favorited by the given user
  }

  getItemFavorites(int itemId) async {
    //Get a list of users who favorited this item, need to make profile links
  }

  dispose() {}
}

final searchBloc = SearchBloc();
