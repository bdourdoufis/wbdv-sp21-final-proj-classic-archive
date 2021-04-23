import 'dart:convert';

import 'package:classicarchive/login/models/user.dart';
import 'package:http/http.dart' as http;

class UserApiClient {
  final _baseUserApiUrl = 'http://localhost:4000/api/users';
  final _baseFavoriteApiUrl = 'http://localhost:4000/api/favorites';
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
    //TODO: Set up session here? Or maybe after the call returns?
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
    //TODO: Set up session here? Or maybe after the call returns?
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
    //TODO: Set up session here? Or maybe after the call returns?
    return User.fromJson(json);
  }
}
