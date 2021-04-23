import 'dart:async';

import 'package:classicarchive/login/login_dialog.dart';
import 'package:classicarchive/search/bloc/search_bloc.dart';
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
  bool favorited;
  bool userLoggedIn;
  String loggedInUsername;

  @override
  void initState() {
    super.initState();
    getUserInfo();
    subscription = searchBloc.itemDetail.listen((itemDetail) {
      setState(() {
        detail = itemDetail;
      });
    });

    Future.delayed(const Duration(milliseconds: 250), () {
      searchBloc.getItemDetail(widget.itemResult.itemId);
    });

    favorited = false;
  }

  void getUserInfo() async {
    dynamic loggedInResult = await FlutterSession().get("loggedIn");
    dynamic userResult = await FlutterSession().get("loggedInUserUsername");
    if (cast<bool>(loggedInResult) != null) {
      userLoggedIn = cast<bool>(loggedInResult);
    }
    loggedInUsername = cast<String>(userResult);
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
                            favorited = !favorited;
                            //TODO: Set favorite in database
                            //IF not logged in:
                            userLoggedIn == false
                                ? showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) {
                                      return LoginDialog();
                                    }).then((value) async {
                                    dynamic userResult = await FlutterSession()
                                        .get("loggedInUserUsername");
                                    setState(() {
                                      userLoggedIn = value;
                                      if (value == true) {
                                        loggedInUsername =
                                            cast<String>(userResult);
                                      }
                                      Navigator.pop(context, true);
                                    });
                                  })
                                : () => {}; //TODO: Add to user favorites
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
                        Navigator.pop(context, false);
                      },
                      child: Icon(Icons.close_rounded,
                          color: Colors.black, size: 40.0),
                    ),
                  )),
              Center(
                  child: Container(
                      width: 600,
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
                                            style:
                                                TextStyle(color: Colors.grey)),
                                        TextSpan(
                                            text: (detail.sellPrice
                                                    .toString()
                                                    .padLeft(6, '0')[4] +
                                                detail.sellPrice
                                                    .toString()
                                                    .padLeft(6, '0')[5]),
                                            style:
                                                TextStyle(color: Colors.brown))
                                      ])),
                                  ..._getLabelText()
                                ]),
                              )
                      ]))))
            ])));
  }
}
