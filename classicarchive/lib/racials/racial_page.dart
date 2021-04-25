import 'package:classicarchive/login/login_dialog.dart';
import 'package:classicarchive/login/models/user.dart';
import 'package:classicarchive/login/register_dialog.dart';
import 'package:classicarchive/profile/profile_dialog.dart';
import 'package:classicarchive/racials/racial_card.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';

class RacialsPage extends StatefulWidget {
  @override
  RacialsPageState createState() => RacialsPageState();
}

class RacialsPageState extends State<RacialsPage> {
  bool userLoggedIn = false;
  User loggedInUser;
  List<Race> races;
  AssetImage background;

  @override
  void initState() {
    super.initState();
    getUserInfo();
    initializeRaces();
    initializeBackground();
  }

  void getUserInfo() async {
    dynamic loggedInResult = await FlutterSession().get("loggedIn");
    dynamic userData = await FlutterSession().get("loggedInUser");
    setState(() {
      if (cast<bool>(loggedInResult) != null) {
        userLoggedIn = cast<bool>(loggedInResult);
        loggedInUser = User.fromJson(userData);
      } else {
        userLoggedIn = false;
      }
    });
  }

  T cast<T>(x) => x is T ? x : null;

  void initializeRaces() {}

  void initializeBackground() {}

  AppBar _buildLoggedOutAppBar(BuildContext context) {
    return AppBar(
      leading: InkWell(
        child: Icon(Icons.home_outlined),
        onTap: () {
          Navigator.pop(context);
        },
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
        onTap: () {
          Navigator.pop(context);
        },
      ),
      actions: [
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
              });
              Navigator.pop(context);
            },
            child: Text("Log Out",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)))
      ],
    );
  }

  void _openProfileDialog() {
    String currentFaction = loggedInUser.faction;
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
        if (currentFaction != user.faction) {
          Navigator.pop(context);
        } else {
          setState(() {
            loggedInUser = user;
          });
          _openProfileDialog();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: userLoggedIn
            ? _buildLoggedInAppBar(context)
            : _buildLoggedOutAppBar(context),
        body: Stack(children: [
          Container(
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: background, fit: BoxFit.cover))),
          Center(
              child: Container(
                  child: Padding(
            padding: EdgeInsets.fromLTRB(50, 50, 50, 125),
            child: RacialsPane(races: races),
          ))),
        ]));
  }
}

class RacialsPane extends StatefulWidget {
  final List<Race> races;

  RacialsPane({this.races});

  @override
  _RacialsPaneState createState() => _RacialsPaneState();
}

class _RacialsPaneState extends State<RacialsPane> {
  List<RacialCard> cards;

  @override
  void initState() {
    super.initState();
    cards = [];
    widget.races.forEach((element) {
      cards.add(RacialCard(race: element));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [...cards],
      ),
    );
  }
}
