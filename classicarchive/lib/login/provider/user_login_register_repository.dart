import 'package:classicarchive/login/models/user.dart';

import 'user_login_register_client.dart';

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
}
