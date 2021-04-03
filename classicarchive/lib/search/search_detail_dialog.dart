import 'dart:async';

import 'package:classicarchive/search/bloc/search_bloc.dart';
import 'package:flutter/material.dart';

import 'models/item_models.dart';

class ResultDetailDialog extends StatefulWidget {
  final Item itemResult;

  ResultDetailDialog({this.itemResult});

  ResultDetailDialogState createState() => ResultDetailDialogState();
}

class ResultDetailDialogState extends State<ResultDetailDialog> {
  ItemDetail detail;
  StreamSubscription<ItemDetail> subscription;

  @override
  void initState() {
    super.initState();
    subscription = searchBloc.itemDetail.listen((itemDetail) {
      setState(() {
        detail = itemDetail;
      });
    });

    Future.delayed(const Duration(milliseconds: 250), () {
      searchBloc.getItemDetail(widget.itemResult.itemId);
    });
  }

  // Builds a dialog containing detailed item information.
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 10,
      child: Container(
        height: 600,
        width: 800,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                child: InkWell(
                splashColor: Colors.white,
                customBorder: CircleBorder(),
                onTap: () {
                  subscription.cancel();
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close_rounded,
                  color: Colors.black,
                  size: 40.0
                ),
              ),
            )),
            detail == null ? 
            Align(
              alignment: Alignment.topLeft,
              child: CircularProgressIndicator()
            ) :
            Align(
              alignment: Alignment.topLeft,
              child: Image.network(widget.itemResult.imgUrl, height: 200, width: 200)
            ),
            Center(
              child: Column(
                children: [
                  detail == null ? 
                  CircularProgressIndicator() : 
                  Text(detail.name,
                    textAlign: TextAlign.center, 
                    style: TextStyle(color: detail.rarityColor, fontSize: 20.0)),
                  detail == null ? 
                  CircularProgressIndicator() :
                  RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(text: (detail.sellPrice.toString().padLeft(6,'0')[0] + detail.sellPrice.toString().padLeft(6,'0')[1]), 
                            style: TextStyle(color: Colors.yellow)),
                          TextSpan(text: (detail.sellPrice.toString().padLeft(6,'0')[2] + detail.sellPrice.toString().padLeft(6,'0')[3]),
                            style: TextStyle(color: Colors.grey)),
                          TextSpan(text: (detail.sellPrice.toString().padLeft(6,'0')[4] + detail.sellPrice.toString().padLeft(6,'0')[5]),
                            style: TextStyle(color: Colors.brown))
                        ]
                      )
                  )
                ]
              ),
        )]
      ))
    );
  }
}