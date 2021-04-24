import 'package:classicarchive/login/bloc/user_bloc.dart';
import 'package:classicarchive/login/models/user.dart';
import 'package:classicarchive/profile/profile_dialog.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UsersFavoritedList extends StatefulWidget {
  final List<User> users;

  UsersFavoritedList({this.users});

  _UsersFavoritedListState createState() => _UsersFavoritedListState();
}

class _UsersFavoritedListState extends State<UsersFavoritedList> {
  List<UserResult> userResults;

  @override
  void initState() {
    super.initState();
    userResults = [];
    widget.users.forEach((user) {
      userResults.add(UserResult(user: user));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        decoration: BoxDecoration(
            border: Border.all(
                color: EasyDynamicTheme.of(context).themeMode == ThemeMode.light
                    ? Color(0xFFD4AF37)
                    : Colors.black,
                width: 8),
            borderRadius: BorderRadius.circular(12)),
        child: SingleChildScrollView(
          child: Column(
            children: [Container(), ...userResults],
          ),
        ));
  }
}

class UserResult extends StatefulWidget {
  final User user;

  UserResult({@required this.user});

  _UserResultState createState() => _UserResultState();
}

class _UserResultState extends State<UserResult> {
  User fullUser;
  bool loadingFull;
  AssetImage profileImage;

  @override
  void initState() {
    super.initState();
    loadingFull = true;
    userBloc.getProfileInformation(widget.user.username);
    userBloc.userProfile.listen((user) {
      if (user.username == widget.user.username) {
        setState(() {
          loadingFull = false;
          fullUser = user;
          setClassImage();
        });
      }
    });
  }

  void setClassImage() {
    switch (fullUser.favoriteClass) {
      case "Warrior":
        {
          profileImage = AssetImage("assets/images/warrior.png");
        }
        break;

      case "Paladin":
        {
          profileImage = AssetImage("assets/images/paladin.png");
        }
        break;

      case "Druid":
        {
          profileImage = AssetImage("assets/images/druid.png");
        }
        break;

      case "Hunter":
        {
          profileImage = AssetImage("assets/images/hunter.png");
        }
        break;

      case "Mage":
        {
          profileImage = AssetImage("assets/images/mage.png");
        }
        break;

      case "Priest":
        {
          profileImage = AssetImage("assets/images/priest.png");
        }
        break;

      case "Rogue":
        {
          profileImage = AssetImage("assets/images/rogue.png");
        }
        break;

      case "Shaman":
        {
          profileImage = AssetImage("assets/images/shaman.png");
        }
        break;

      case "Warlock":
        {
          profileImage = AssetImage("assets/images/warlock.png");
        }
        break;

      default:
        {
          profileImage = AssetImage("assets/images/warrior.png");
        }
        break;
    }
  }

  void _showProfileDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return ProfileDialog(user: fullUser);
        }).then((value) {
      if (value == true) {
        _showProfileDialog(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Card(
          color: fullUser == null
              ? null
              : fullUser.faction == "Horde"
                  ? Color(0xFF880808)
                  : Color(0xFF0022EE),
          child: InkWell(
              onTap: () {
                if (fullUser != null) {
                  _showProfileDialog(context);
                }
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Row(
                  children: [
                    profileImage == null
                        ? CircularProgressIndicator()
                        : Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: profileImage, fit: BoxFit.cover)),
                            ),
                          ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Text(
                          widget.user.username,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ))
                  ],
                ),
              ))),
    );
  }
}
