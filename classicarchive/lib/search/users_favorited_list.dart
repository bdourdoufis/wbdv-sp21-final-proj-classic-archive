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
            children: [...userResults],
          ),
        ));
  }
}

class UserResult extends StatelessWidget {
  final User user;

  UserResult({@required this.user});

  void _showProfileDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return ProfileDialog(user: user);
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
          child: InkWell(
              onTap: () {
                _showProfileDialog(context);
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Text(
                          user.username,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ))
                  ],
                ),
              ))),
    );
  }
}
