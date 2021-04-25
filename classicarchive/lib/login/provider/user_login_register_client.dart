import 'dart:convert';

import 'package:classicarchive/login/models/favorite.dart';
import 'package:classicarchive/login/models/user.dart';
import 'package:classicarchive/search/models/item_models.dart';
import 'package:http/http.dart' as http;

class UserApiClient {
  final _baseUserApiUrl =
      'https://classic-archive-user-service.herokuapp.com/api/users';
  final _baseFavoriteApiUrl =
      'https://classic-archive-user-service.herokuapp.com/api/favorites';
  final http.Client httpClient = http.Client();

  UserApiClient();

  Future<User> login(String username, String password) async {
    final url = Uri.parse('$_baseUserApiUrl/login');
    final response = await this
        .httpClient
        .post(url, body: {'username': username, 'password': password});

    if (response.statusCode != 200) {
      throw Exception("Error while logging in.");
    } else if (response.body == "0") {
      return User();
    }

    final json = jsonDecode(response.body);
    return User.fromJson(json);
  }

  Future<User> register(String username, String password, String faction,
      String favoriteClass) async {
    final url = Uri.parse('$_baseUserApiUrl/register');
    final response = await this.httpClient.post(url, body: {
      'username': username,
      'password': password,
      'faction': faction,
      'favoriteClass': favoriteClass
    });

    if (response.statusCode != 200) {
      throw Exception("Error while registering user.");
    } else if (response.body == "0") {
      return User();
    }

    final json = jsonDecode(response.body);
    return User.fromJson(json);
  }

  Future<User> update(User user) async {
    final url = Uri.parse('$_baseUserApiUrl/update');
    final response = await this.httpClient.put(url, body: {
      '_id': user.userId,
      'username': user.username,
      'password': user.password,
      'faction': user.faction,
      'favoriteClass': user.favoriteClass
    });

    if (response.statusCode != 200) {
      throw Exception("Error while updating user.");
    }

    final json = jsonDecode(response.body);
    return User.fromJson(json);
  }

  Future<User> profile(String username) async {
    final url = Uri.parse('$_baseUserApiUrl/' + username);
    final response = await this.httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception("Error while retrieving user profile.");
    }

    final json = jsonDecode(response.body);
    return User.fromJson(json[0]);
  }

  Future<List<User>> getAllUsers() async {
    final url = Uri.parse('$_baseUserApiUrl');
    final response = await this.httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception("Error while retrieving all users.");
    }

    final json = jsonDecode(response.body).cast<Map<String, dynamic>>();
    return json.map<User>((entry) => User.fromJson(entry)).toList();
  }

  Future<Favorite> addFavorite(User user, int itemId, String itemName) async {
    final url = Uri.parse('$_baseFavoriteApiUrl/create');
    final response = await this.httpClient.post(url, body: {
      'username': user.username,
      'itemId': itemId.toString(),
      'itemName': itemName
    });

    if (response.statusCode != 200) {
      throw Exception("Error while adding new favorite.");
    }

    final json = jsonDecode(response.body);
    return Favorite.fromJson(json);
  }

  Future<Favorite> removeFavorite(User user, int itemId) async {
    final url = Uri.parse('$_baseFavoriteApiUrl/delete');
    final response = await this.httpClient.delete(url, body: {
      'username': user.username,
      'itemId': itemId.toString(),
    });

    if (response.statusCode != 200) {
      throw Exception("Error while removing favorite.");
    }

    final json = jsonDecode(response.body);
    return Favorite.fromJson(json);
  }

  Future<List<Item>> getUserFavorites(User user) async {
    final url = Uri.parse('$_baseFavoriteApiUrl/user/' + user.username);
    final response = await this.httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception("Error while retrieving user favorites.");
    }

    final json = jsonDecode(response.body).cast<Map<String, dynamic>>();
    List<Favorite> favorites =
        json.map<Favorite>((entry) => Favorite.fromJson(entry)).toList();
    List<Item> toReturn = [];
    for (int i = 0; i < favorites.length; i++) {
      toReturn
          .add(Item(itemId: favorites[i].itemId, name: favorites[i].itemName));
    }
    return toReturn;
  }

  Future<List<User>> getItemFavorites(int itemId) async {
    final url = Uri.parse('$_baseFavoriteApiUrl/item/' + itemId.toString());
    final response = await this.httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception("Error while retrieving user favorites.");
    }

    final json = jsonDecode(response.body).cast<Map<String, dynamic>>();
    List<Favorite> favorites =
        json.map<Favorite>((entry) => Favorite.fromJson(entry)).toList();
    List<User> toReturn = [];
    for (int i = 0; i < favorites.length; i++) {
      toReturn.add(User(username: favorites[i].username));
    }
    return toReturn;
  }
}
