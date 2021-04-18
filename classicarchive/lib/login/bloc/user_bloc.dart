import 'package:classicarchive/login/models/user.dart';
import 'package:classicarchive/search/models/item_models.dart';
import 'package:classicarchive/search/provider/item_api_search_repository.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc {
  ItemSearchRepository repository = ItemSearchRepository();

  // Fetches a user given their credentials.
  final _userFetcher = PublishSubject<User>();

  // Fetches a list of items favorited by a given user.
  final _userFavoritesFetcher = PublishSubject<List<Item>>();

  // Fetches a list of users who have favorited a given item.
  final _itemFavoritedFetcher = PublishSubject<List<User>>();

  Stream<User> get userResult => _userFetcher.stream;

  Stream<List<Item>> get userFavorites => _userFavoritesFetcher.stream;

  Stream<List<User>> get favoritedByUsers => _itemFavoritedFetcher.stream;

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

final userBloc = UserBloc();
