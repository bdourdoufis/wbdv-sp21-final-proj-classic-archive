import 'package:classicarchive/login/models/user.dart';
import 'package:classicarchive/login/provider/user_login_register_repository.dart';
import 'package:classicarchive/search/models/item_models.dart';
import 'package:classicarchive/search/provider/item_api_search_repository.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc {
  UserRepository repository = UserRepository();

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
    User loggedInUser = await repository.login(username, password);
    _userFetcher.add(loggedInUser);
  }

  registerUser(
      String username, String password, String faction, String favClass) async {
    User registeredUser =
        await repository.register(username, password, faction, favClass);
    _userFetcher.add(registeredUser);
  }

  updateUser(User user) async {
    await repository.update(user);
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
