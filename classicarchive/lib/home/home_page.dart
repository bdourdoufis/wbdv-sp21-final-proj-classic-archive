import 'dart:async';

import 'package:classicarchive/login/bloc/user_bloc.dart';
import 'package:classicarchive/login/login_dialog.dart';
import 'package:classicarchive/login/models/user.dart';
import 'package:classicarchive/login/register_dialog.dart';
import 'package:classicarchive/profile/items_favorited_list.dart';
import 'package:classicarchive/profile/profile_dialog.dart';
import 'package:classicarchive/racials/alliance_racials.dart';
import 'package:classicarchive/racials/horde_racials.dart';
import 'package:classicarchive/search/models/item_models.dart';
import 'package:classicarchive/search/search_page.dart';
import 'package:classicarchive/search/users_favorited_list.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double titleOpacity = 0.0;
  double subtitleOpacity = 0.0;
  double searchButtonOpacity = 0.0;
  bool userLoggedIn = false;
  User loggedInUser;
  final controller = TextEditingController();

  StreamSubscription<List<Item>> favoritesSubscription;
  CompactItemResult recentFavorite;

  StreamSubscription<List<User>> usersSubscription;
  UserResult recentUser;

  @override
  void initState() {
    super.initState();
    getUserInfo();
    userBloc.getAllUsers();
    //Fade in home page widgets
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        titleOpacity = 1.0;
      });
    });

    Future.delayed(Duration(milliseconds: 600), () {
      setState(() {
        subtitleOpacity = 1.0;
      });
    });

    Future.delayed(Duration(milliseconds: 800), () {
      searchButtonOpacity = 1.0;
    });

    favoritesSubscription = userBloc.homepageFavorites.listen((favorites) {
      if (favorites.isEmpty) {
        setState(() {
          recentFavorite = null;
        });
      } else {
        setState(() {
          if (recentFavorite == null) {
            recentFavorite =
                CompactItemResult(item: favorites.last, homePageResult: true);
          } else {
            recentFavorite.state.setItem(favorites.last);
          }
        });
      }
    });

    usersSubscription = userBloc.allUsers.listen((users) {
      if (users.isEmpty) {
        recentUser = null;
      } else {
        setState(() {
          recentUser = UserResult(user: users.last, homePageUser: true);
        });
      }
    });
  }

  void getUserInfo() async {
    dynamic loggedInResult = await FlutterSession().get("loggedIn");
    dynamic userData = await FlutterSession().get("loggedInUser");
    setState(() {
      if (cast<bool>(loggedInResult) != null) {
        userLoggedIn = cast<bool>(loggedInResult);
        loggedInUser = User.fromJson(userData);
        userBloc.getHomepageFavorites(loggedInUser);
      } else {
        userLoggedIn = false;
      }
    });
  }

  T cast<T>(x) => x is T ? x : null;

  AppBar _buildLoggedOutAppBar(BuildContext context) {
    return AppBar(
      leading: InkWell(
        child: Icon(Icons.home_outlined),
        onTap: () {},
      ),
      actions: [
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
                  setState(() {});
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
                if (user.userId != null) {
                  await FlutterSession().set("loggedIn", true);
                  await FlutterSession().set("loggedInUser", user);
                  ThemeMode currentTheme =
                      EasyDynamicTheme.of(context).themeMode;
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
                    userBloc.getUserFavorites(loggedInUser);
                  });
                }
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
        onTap: () {},
      ),
      actions: [
        loggedInUser.faction == "Horde"
            ? TextButton(
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HordeRacialsPage()))
                      .then((value) {
                    getUserInfo();
                  });
                },
                child: Text(
                  "Horde Racials",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              )
            : TextButton(
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllianceRacialsPage()))
                      .then((value) {
                    getUserInfo();
                  });
                },
                child: Text(
                  "Alliance Racials",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
        SizedBox(width: 25),
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
                recentFavorite = null;
                recentUser = null;
                userBloc.getAllUsers();
              });
            },
            child: Text("Log Out",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)))
      ],
    );
  }

  void _routeToSearch(BuildContext context) {
    String searchVal = controller.text;
    controller.text = "";
    if (searchVal.length > 0) {
      Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SearchPage(searchValue: searchVal)))
          .then((value) {
        getUserInfo();
      });
    } else {
      Navigator.push(
              context, MaterialPageRoute(builder: (context) => SearchPage()))
          .then((value) {
        getUserInfo();
      });
    }
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
    return Scaffold(
        appBar: userLoggedIn
            ? _buildLoggedInAppBar(context)
            : _buildLoggedOutAppBar(context),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/dark_portal.jpg"),
                  fit: BoxFit.cover)),
          child: Center(
              child: Column(children: [
            SizedBox(height: 50),
            AnimatedOpacity(
              opacity: titleOpacity,
              duration: Duration(seconds: 2),
              child: Text("Classic Archive",
                  style: TextStyle(
                      fontSize: 72,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
            AnimatedOpacity(
              opacity: subtitleOpacity,
              duration: Duration(seconds: 2),
              child: Text("World of Warcraft: Classic Item Database",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
            SizedBox(height: 75),
            userLoggedIn
                ? recentFavorite != null
                    ? Text("Your most recent favorite:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24))
                    : Text("You have no recent favorites.")
                : recentUser != null
                    ? Text("Newest user:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24))
                    : Text("There are no registered users."),
            userLoggedIn
                ? recentFavorite != null
                    ? Container(width: 600, child: recentFavorite)
                    : Container()
                : recentUser != null
                    ? Container(width: 600, child: recentUser)
                    : Container(),
            SizedBox(height: 75),
            Container(
                width: 800,
                child: TextField(
                    controller: controller,
                    onSubmitted: (value) => _routeToSearch(context),
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                        labelText: "Search for an item..."))),
            SizedBox(height: 50),
            SizedBox(
                width: 150,
                height: 75,
                child: ElevatedButton(
                    child: Text("SEARCH",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 32)),
                    onPressed: () => _routeToSearch(context)))
          ])),
        ));
  }
}
