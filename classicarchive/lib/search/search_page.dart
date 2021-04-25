import 'dart:async';

import 'package:classicarchive/login/login_dialog.dart';
import 'package:classicarchive/login/models/user.dart';
import 'package:classicarchive/login/register_dialog.dart';
import 'package:classicarchive/profile/profile_dialog.dart';
import 'package:classicarchive/search/bloc/search_bloc.dart';
import 'package:classicarchive/search/search_detail_dialog.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:flutter_session/flutter_session.dart';

import 'models/item_models.dart';

class SearchPage extends StatefulWidget {
  final String searchValue;

  SearchPage({this.searchValue});

  @override
  State<SearchPage> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  SearchBar searchBar;
  List<ItemResult> resultSet = [];
  bool currentlySearching = false;
  String placeholderText;
  bool userLoggedIn = false;
  User loggedInUser;
  StreamSubscription<List<Item>> searchSubscription;

  AppBar _buildLoadingAppBar(BuildContext context) {
    return new AppBar(
      leading: InkWell(
          child: Icon(Icons.home_outlined),
          onTap: () {
            searchSubscription.cancel();
            Navigator.pop(context);
          }),
      title: new Text("Classic Archive Item Search",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
      actions: [searchBar.getSearchAction(context)],
    );
  }

  AppBar _buildLoggedOutAppBar(BuildContext context) {
    return new AppBar(
      leading: InkWell(
          child: Icon(Icons.home_outlined),
          onTap: () {
            searchSubscription.cancel();
            Navigator.pop(context);
          }),
      title: new Text("Classic Archive Item Search",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
      actions: [
        searchBar.getSearchAction(context),
        SizedBox(
          width: 25,
        ),
        TextButton(
            onPressed: () {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return LoginDialog();
                  }).then((value) async {
                if (value == true) {
                  getUserInfo();
                  setState(() {
                    searchBar = SearchBar(
                        inBar: true,
                        setState: setState,
                        onSubmitted: _searchItems,
                        buildDefaultAppBar: _buildLoggedInAppBar);
                  });
                }
              });
            },
            child: Text(
              "Login",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            )),
        SizedBox(
          width: 25,
        ),
        TextButton(
            onPressed: () {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return RegisterDialog();
                  }).then((user) async {
                await FlutterSession().set("loggedIn", true);
                await FlutterSession().set("loggedInUser", user);
                ThemeMode currentTheme = EasyDynamicTheme.of(context).themeMode;
                while ((currentTheme == ThemeMode.light &&
                        user.faction == "Horde") ||
                    (currentTheme == ThemeMode.dark &&
                        user.faction == "Alliance") ||
                    (currentTheme == ThemeMode.system &&
                        user.faction == "Alliance")) {
                  EasyDynamicTheme.of(context).changeTheme();
                  currentTheme = EasyDynamicTheme.of(context).themeMode;
                }
                setState(() {
                  userLoggedIn = true;
                  loggedInUser = user;
                  searchBar = SearchBar(
                      inBar: true,
                      setState: setState,
                      onSubmitted: _searchItems,
                      buildDefaultAppBar: _buildLoggedInAppBar);
                });
              });
            },
            child: Text("Register",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)))
      ],
    );
  }

  AppBar _buildLoggedInAppBar(BuildContext context) {
    return AppBar(
      leading: InkWell(
          child: Icon(Icons.home_outlined),
          onTap: () {
            searchSubscription.cancel();
            Navigator.pop(context);
          }),
      title: new Text("Classic Archive Item Search",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
      actions: [
        searchBar.getSearchAction(context),
        SizedBox(
          width: 25,
        ),
        TextButton(
            onPressed: () {
              _openProfileDialog();
            },
            child: Text(
              loggedInUser.username,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            )),
        SizedBox(
          width: 25,
        ),
        TextButton(
            onPressed: () async {
              await FlutterSession().set("loggedIn", false);
              await FlutterSession().set("loggedInUser", User());
              setState(() {
                userLoggedIn = false;
                searchBar = SearchBar(
                    inBar: true,
                    setState: setState,
                    onSubmitted: _searchItems,
                    buildDefaultAppBar: _buildLoggedOutAppBar);
              });
            },
            child: Text("Log Out",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)))
      ],
    );
  }

  void _searchItems(String searchQuery) {
    setState(() {
      currentlySearching = true;
    });
    searchBloc.searchItems(searchQuery);
  }

  @override
  void initState() {
    super.initState();
    searchSubscription = searchBloc.itemResult.listen((result) {
      setState(() {
        if (result.isEmpty) {
          placeholderText = "No results found. Try again.";
        } else {
          currentlySearching = false;
          resultSet.clear();
          result.forEach((item) {
            resultSet.add(ItemResult(
                item: item,
                loginCallback: loginCallback,
                parentSubscription: searchSubscription));
          });
        }
      });
    });

    searchBar = SearchBar(
        inBar: true,
        setState: setState,
        onSubmitted: _searchItems,
        buildDefaultAppBar: _buildLoadingAppBar);

    if (widget.searchValue != null) {
      _searchItems(widget.searchValue);
    }

    placeholderText = "Click the magnifying glass to search!";
    getUserInfo();
  }

  void getUserInfo() async {
    dynamic loggedInResult = await FlutterSession().get("loggedIn");
    dynamic userData = await FlutterSession().get("loggedInUser");
    setState(() {
      searchBar = SearchBar(
          inBar: true,
          setState: setState,
          onSubmitted: _searchItems,
          buildDefaultAppBar: _buildLoggedOutAppBar);
    });
    if (cast<bool>(loggedInResult) != null) {
      userLoggedIn = cast<bool>(loggedInResult);
      if (userLoggedIn == true) {
        searchBar = SearchBar(
            inBar: true,
            setState: setState,
            onSubmitted: _searchItems,
            buildDefaultAppBar: _buildLoggedInAppBar);
        loggedInUser = User.fromJson(userData);
        return;
      } else {
        searchBar = SearchBar(
            inBar: true,
            setState: setState,
            onSubmitted: _searchItems,
            buildDefaultAppBar: _buildLoggedOutAppBar);
      }
    }
  }

  T cast<T>(x) => x is T ? x : null;

  void loginCallback() {
    getUserInfo();
    setState(() {});
  }

  void _openProfileDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return ProfileDialog(user: loggedInUser);
        }).then((user) async {
      if (user.userId != null) {
        await FlutterSession().set("loggedInUser", user);
        ThemeMode currentTheme = EasyDynamicTheme.of(context).themeMode;
        while ((currentTheme == ThemeMode.light && user.faction == "Horde") ||
            (currentTheme == ThemeMode.dark && user.faction == "Alliance") ||
            (currentTheme == ThemeMode.system && user.faction == "Alliance")) {
          EasyDynamicTheme.of(context).changeTheme();
          currentTheme = EasyDynamicTheme.of(context).themeMode;
        }
        setState(() {
          loggedInUser = user;
        });
        _openProfileDialog();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: searchBar.build(context),
        body: Center(
          child: resultSet.length > 0
              ? SingleChildScrollView(
                  child: Column(
                  children: [...resultSet],
                ))
              : currentlySearching
                  ? CircularProgressIndicator()
                  : Text(placeholderText),
        ));
  }
}

class ItemResult extends StatelessWidget {
  final Item item;
  final Function loginCallback;
  final StreamSubscription<List<Item>> parentSubscription;

  ItemResult(
      {@required this.item, this.loginCallback, this.parentSubscription});

  void _showResultDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return ResultDetailDialog(itemResult: item);
        }).then((value) {
      if (value == true) {
        loginCallback();
        _showResultDialog(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Card(
          child: InkWell(
              onTap: () {
                _showResultDialog(context);
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Row(
                  children: [
                    Image.network(item.imgUrl),
                    Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Text(
                          item.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ))
                  ],
                ),
              ))),
    );
  }
}
