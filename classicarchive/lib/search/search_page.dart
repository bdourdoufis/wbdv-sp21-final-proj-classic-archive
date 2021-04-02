import 'package:classicarchive/search/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

import 'models/item_model.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState () => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  SearchBar searchBar;
  List<ItemResult> resultSet = [];

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
      title: new Text("Classic Archive Item Search"),
      actions: [searchBar.getSearchAction(context)],
    );
  }

  @override
  void initState() {
    searchBloc.itemResult.listen((result) {
      setState(() {
        resultSet.clear();
        result.forEach((item) {
          resultSet.add(ItemResult(item: item));
        });
      });
    });

    searchBar = SearchBar(
      inBar: true,
      setState: setState,
      onSubmitted: searchBloc.searchItems,
      buildDefaultAppBar: buildAppBar
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: searchBar.build(context),
      body: Center(
        child: resultSet.length > 0 ? 
        SingleChildScrollView(
          child: Column(
            children: [
              ...resultSet
            ],
          )
        ) : Text("Click the magnifying glass to search!"),
      )
    );
  }
}

class ItemResult extends StatelessWidget {
  final Item item;

  ItemResult({@required this.item});

  //TODO: Add gesturedetector w/ onclick to open detail dialog
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Card(
        child: Row(
          children: [
            Image.network(item.imgUrl),
            Text(item.name)
          ],
        ),
      ),
    );
  }
}