import 'package:classicarchive/login/models/favorite.dart';
import 'package:classicarchive/login/models/user.dart';
import 'package:classicarchive/search/models/item_models.dart';

import 'user_login_register_client.dart';

/// The repository which acts as an intermediary between the [UserBloc]
/// and [UserApiClient].
class UserRepository {
  final UserApiClient client = UserApiClient();

  UserRepository();

  Future<User> login(String username, String password) async {
    return await client.login(username, password);
  }

  Future<User> register(String username, String password, String faction,
      String favoriteClass) async {
    return await client.register(username, password, faction, favoriteClass);
  }

  Future<User> update(User user) async {
    return await client.update(user);
  }

  Future<User> profile(String username) async {
    return await client.profile(username);
  }

  Future<List<User>> getAllUsers() async {
    return await client.getAllUsers();
  }

  Future<Favorite> addFavorite(User user, int itemId, String itemName) async {
    return await client.addFavorite(user, itemId, itemName);
  }

  Future<Favorite> removeFavorite(User user, int itemId) async {
    return await client.removeFavorite(user, itemId);
  }

  Future<List<Item>> getUserFavorites(User user) async {
    return await client.getUserFavorites(user);
  }

  Future<List<User>> getItemFavorites(int itemId) async {
    return await client.getItemFavorites(itemId);
  }
}
