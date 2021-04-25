import 'package:classicarchive/login/models/user.dart';
import 'package:classicarchive/login/provider/user_login_register_repository.dart';
import 'package:classicarchive/search/models/item_models.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc {
  UserRepository repository = UserRepository();

  // Fetches a user given their login credentials.
  final _userFetcher = PublishSubject<User>();

  // Fetches a list of items favorited by a given user.
  final _userFavoritesFetcher = PublishSubject<List<Item>>();

  // Will host user favorites on specifically the home page.
  // This is to prevent stream interference in the case that a user navigates
  // to a user profile from the home page.
  final _homepageUserFavorites = PublishSubject<List<Item>>();

  // Fetches a list of users who have favorited a given item.
  final _itemFavoritedFetcher = PublishSubject<List<User>>();

  // Fetches a user's profile data given their username.
  // We need a user stream separate from _userFetcher since other background
  // widgets may be listening to it for login information.
  final _userProfileFetcher = PublishSubject<User>();

  // Fetches a list of all registered users.
  final _allUsersFetcher = PublishSubject<List<User>>();

  Stream<User> get userResult => _userFetcher.stream;

  Stream<List<Item>> get userFavorites => _userFavoritesFetcher.stream;

  Stream<List<Item>> get homepageFavorites => _homepageUserFavorites.stream;

  Stream<List<User>> get favoritedByUsers => _itemFavoritedFetcher.stream;

  Stream<User> get userProfile => _userProfileFetcher.stream;

  Stream<List<User>> get allUsers => _allUsersFetcher.stream;

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

  void getProfileInformation(String username) async {
    await repository.profile(username).then((user) {
      _userProfileFetcher.add(user);
    });
  }

  void getAllUsers() async {
    await repository.getAllUsers().then((users) {
      _allUsersFetcher.add(users);
    });
  }

  void addFavorite(User user, int itemId, String itemName) async {
    await repository.addFavorite(user, itemId, itemName);
  }

  void removeFavorite(User user, int itemId) async {
    await repository.removeFavorite(user, itemId).then((result) {
      getHomepageFavorites(user);
    });
  }

  void getUserFavorites(User user) async {
    await repository.getUserFavorites(user).then((items) {
      _userFavoritesFetcher.add(items);
    });
  }

  void getHomepageFavorites(User user) async {
    await repository.getUserFavorites(user).then((items) {
      _homepageUserFavorites.add(items);
    });
  }

  void getItemFavorites(int itemId) async {
    await repository.getItemFavorites(itemId).then((users) {
      _itemFavoritedFetcher.add(users);
    });
  }

  void dispose() {
    _userFetcher.close();
    _userFavoritesFetcher.close();
    _itemFavoritedFetcher.close();
    _userProfileFetcher.close();
    _allUsersFetcher.close();
    _homepageUserFavorites.close();
  }
}

final userBloc = UserBloc();
