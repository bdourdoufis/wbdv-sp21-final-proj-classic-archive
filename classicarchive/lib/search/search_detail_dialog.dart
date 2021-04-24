import 'dart:async';

import 'package:classicarchive/login/bloc/user_bloc.dart';
import 'package:classicarchive/login/login_dialog.dart';
import 'package:classicarchive/login/models/user.dart';
import 'package:classicarchive/search/bloc/search_bloc.dart';
import 'package:classicarchive/search/users_favorited_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';

import 'models/item_models.dart';

class ResultDetailDialog extends StatefulWidget {
  final Item itemResult;

  ResultDetailDialog({this.itemResult});

  ResultDetailDialogState createState() => ResultDetailDialogState();
}

class ResultDetailDialogState extends State<ResultDetailDialog> {
  ItemDetail detail;
  StreamSubscription<ItemDetail> subscription;
  StreamSubscription<List<Item>> favoriteSubscription;
  StreamSubscription<List<User>> usersSubscription;
  bool favorited;
  bool userLoggedIn;
  String loggedInUsername;
  User loggedInUser;
  List<User> usersFavorited;

  @override
  void initState() {
    super.initState();
    userBloc.getItemFavorites(widget.itemResult.itemId);
    getUserInfo();
    subscription = searchBloc.itemDetail.listen((itemDetail) {
      setState(() {
        detail = itemDetail;
      });
    });

    favoriteSubscription = userBloc.userFavorites.listen((items) {
      if (items.any((element) => element.itemId == widget.itemResult.itemId)) {
        setState(() {
          favorited = true;
        });
      }
    });

    usersSubscription = userBloc.favoritedByUsers.listen((users) {
      setState(() {
        usersFavorited = users;
      });
    });

    Future.delayed(const Duration(milliseconds: 250), () {
      searchBloc.getItemDetail(widget.itemResult.itemId);
    });

    favorited = false;
    usersFavorited = [];
  }

  void getUserInfo() async {
    dynamic loggedInResult = await FlutterSession().get("loggedIn");
    dynamic userData = await FlutterSession().get("loggedInUser");
    if (cast<bool>(loggedInResult) != null) {
      userLoggedIn = cast<bool>(loggedInResult);
    }
    if (userData != null) {
      loggedInUser = User.fromJson(userData);
      userBloc.getUserFavorites(loggedInUser);
    }
  }

  T cast<T>(x) => x is T ? x : null;

  List<Text> _getLabelText() {
    List<Text> labels = [];
    detail.tooltipLabels.forEach((label) {
      labels.add(Text(label, textAlign: TextAlign.left));
    });
    return labels;
  }

  // Builds a dialog containing detailed item information.
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 20,
        child: Container(
            height: 600,
            width: 800,
            child: Stack(children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            if (userLoggedIn == false) {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    return LoginDialog();
                                  }).then((value) async {
                                if (value == true) {
                                  dynamic userResult = await FlutterSession()
                                      .get("loggedInUserUsername");
                                  setState(() {
                                    userLoggedIn = value;
                                    loggedInUsername = cast<String>(userResult);
                                    Navigator.pop(context, true);
                                  });
                                }
                              });
                            } else {
                              setState(() {
                                if (userLoggedIn) {
                                  favorited = !favorited;
                                  if (favorited) {
                                    userBloc.addFavorite(loggedInUser,
                                        detail.itemId, detail.name);
                                  } else {
                                    userBloc.removeFavorite(
                                        loggedInUser, detail.itemId);
                                  }
                                }
                              });
                            }
                          });
                        },
                        icon: favorited
                            ? Icon(Icons.favorite)
                            : Icon(Icons.favorite_border)),
                  )),
              Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                    child: InkWell(
                      splashColor: Colors.white,
                      customBorder: CircleBorder(),
                      onTap: () {
                        subscription.cancel();
                        favoriteSubscription.cancel();
                        usersSubscription.cancel();
                        Navigator.pop(context, false);
                      },
                      child: Icon(Icons.close_rounded,
                          color: Colors.black, size: 40.0),
                    ),
                  )),
              Center(
                  child: Container(
                      width: 600,
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                          child: SingleChildScrollView(
                              child: Column(children: [
                            detail == null
                                ? CircularProgressIndicator()
                                : Center(
                                    child: Column(children: [
                                      Image.network(widget.itemResult.imgUrl,
                                          scale: 0.33),
                                      Text(detail.name,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: detail.rarityColor,
                                              fontSize: 20.0)),
                                      RichText(
                                          text: TextSpan(
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              children: [
                                            TextSpan(
                                                text: (detail.sellPrice
                                                        .toString()
                                                        .padLeft(6, '0')[0] +
                                                    detail.sellPrice
                                                        .toString()
                                                        .padLeft(6, '0')[1]),
                                                style: TextStyle(
                                                    color: Colors.yellow)),
                                            TextSpan(
                                                text: (detail.sellPrice
                                                        .toString()
                                                        .padLeft(6, '0')[2] +
                                                    detail.sellPrice
                                                        .toString()
                                                        .padLeft(6, '0')[3]),
                                                style: TextStyle(
                                                    color: Colors.grey)),
                                            TextSpan(
                                                text: (detail.sellPrice
                                                        .toString()
                                                        .padLeft(6, '0')[4] +
                                                    detail.sellPrice
                                                        .toString()
                                                        .padLeft(6, '0')[5]),
                                                style: TextStyle(
                                                    color: Colors.brown))
                                          ])),
                                      ..._getLabelText()
                                    ]),
                                  ),
                            SizedBox(height: 25),
                            Center(
                              child: Text("Users Have Favorited This Item:"),
                            ),
                            usersFavorited.length == 0
                                ? Container()
                                : Padding(
                                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                                    child: UsersFavoritedList(
                                        users: usersFavorited))
                          ])))))
            ])));
  }
}
