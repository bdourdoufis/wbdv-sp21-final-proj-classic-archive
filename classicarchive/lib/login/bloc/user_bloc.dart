import 'package:classicarchive/login/models/user.dart';
import 'package:classicarchive/login/provider/user_login_register_repository.dart';
import 'package:classicarchive/search/models/item_models.dart';
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

  void login(String username, String password) async {
    User loggedInUser = await repository.login(username, password);
    _userFetcher.add(loggedInUser);
  }

  void registerUser(
      String username, String password, String faction, String favClass) async {
    User registeredUser =
        await repository.register(username, password, faction, favClass);
    _userFetcher.add(registeredUser);
  }

  void updateUser(User user) async {
    await repository.update(user);
  }

  void addFavorite(User user, int itemId, String itemName) async {
    await repository.addFavorite(user, itemId, itemName);
  }

  void removeFavorite(User user, int itemId) async {
    await repository.removeFavorite(user, itemId);
  }

  void getUserFavorites(User user) async {
    await repository.getUserFavorites(user).then((items) {
      _userFavoritesFetcher.add(items);
    });
  }

  void getItemFavorites(int itemId) async {
    await repository.getItemFavorites(itemId).then((users) {
      _itemFavoritedFetcher.add(users);
    });
  }

  void dispose() {
    _userFavoritesFetcher.close();
    _itemFavoritedFetcher.close();
  }
}

final userBloc = UserBloc();
