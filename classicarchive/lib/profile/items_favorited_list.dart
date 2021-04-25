import 'dart:async';

import 'package:classicarchive/search/bloc/search_bloc.dart';
import 'package:classicarchive/search/models/item_models.dart';
import 'package:classicarchive/search/search_detail_dialog.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// This widget will render a list of cards containing items which have been
/// favorited by a user.
class ItemsFavoritedList extends StatefulWidget {
  final List<Item> items;
  final _ItemsFavoritedListState state = _ItemsFavoritedListState();

  ItemsFavoritedList({this.items});

  _ItemsFavoritedListState createState() => state;

  void closeSubscriptions() {
    state.closeSubscriptions();
  }
}

/// The state of an [ItemsFavoritedList].
class _ItemsFavoritedListState extends State<ItemsFavoritedList> {
  List<CompactItemResult> itemResults;

  @override
  void initState() {
    super.initState();
    itemResults = [];
    widget.items.forEach((item) {
      itemResults.add(CompactItemResult(item: item));
    });
  }

  void closeSubscriptions() {
    if (itemResults != null) {
      itemResults.forEach((element) {
        element.closeSubscriptions();
      });
    }
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
            children: [...itemResults],
          ),
        ));
  }
}

/// This widget represents a single card which will generally be displayed
/// in a list of favorited items. A single [CompactItemResult] is also
/// displayed on the [HomePage] if a user is logged in, to show their most
/// recent favorite.
class CompactItemResult extends StatefulWidget {
  final Item item;
  final bool homePageResult;
  final _CompactItemResultState state = _CompactItemResultState();

  CompactItemResult({@required this.item, this.homePageResult});

  _CompactItemResultState createState() => state;

  void closeSubscriptions() {
    state.closeSubscriptions();
  }
}

/// The state of a [CompactItemResult].
class _CompactItemResultState extends State<CompactItemResult> {
  int itemId;
  ItemDetail fullItem;
  Item realItem;
  bool loadingFull;
  Image itemImage;
  StreamSubscription<ItemDetail> detailSubscription;

  // This is only used on the home page,
  // to update the user's most recent favorite.
  setItem(Item item) {
    setState(() {
      loadingFull = true;
      itemId = item.itemId;
      searchBloc.getItemDetail(item.itemId);
    });
  }

  @override
  void initState() {
    super.initState();
    itemId = widget.item.itemId;
    loadingFull = true;
    searchBloc.getItemDetail(widget.item.itemId);
    detailSubscription = searchBloc.itemDetail.listen((item) {
      if (item.itemId == itemId) {
        setState(() {
          loadingFull = false;
          fullItem = item;
          itemImage = Image.network(fullItem.icon, scale: 0.33);
          // We need to make an actual Item object here which can be passed
          // into the [ResultDetailDialog].
          realItem = Item(
              itemId: fullItem.itemId,
              name: fullItem.name,
              uniqueName: fullItem.uniqueName,
              imgUrl: fullItem.icon);
        });
      }
    });
  }

  void _showItemDialog(BuildContext context) {
    if (widget.homePageResult == null) {
      Navigator.pop(context);
    }
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return ResultDetailDialog(itemResult: realItem);
        });
  }

  void closeSubscriptions() {
    detailSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Card(
          child: InkWell(
              onTap: () {
                if (realItem != null) {
                  _showItemDialog(context);
                }
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: realItem == null
                    ? CircularProgressIndicator()
                    : Row(
                        children: [
                          itemImage == null
                              ? CircularProgressIndicator()
                              : Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
                                  child: itemImage,
                                ),
                          Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: Text(
                                realItem.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                              ))
                        ],
                      ),
              ))),
    );
  }
}
