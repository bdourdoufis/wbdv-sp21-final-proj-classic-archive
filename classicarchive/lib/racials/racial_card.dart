import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Race {
  final AssetImage raceIcon;
  final String name;
  final String homeCity;
  final List<RacialAbility> racials;

  Race({this.raceIcon, this.name, this.homeCity, this.racials});
}

class RacialAbility extends StatelessWidget {
  final AssetImage icon;
  final String name;
  final String description;

  RacialAbility({this.icon, this.name, this.description});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          textAlign: TextAlign.left),
      Row(
        children: [
          Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                    image: DecorationImage(image: icon, fit: BoxFit.cover)),
              )),
          Expanded(
              child: Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Text(description),
          ))
        ],
      ),
      SizedBox(height: 25)
    ]);
  }
}

class RacialCard extends StatefulWidget {
  final Race race;

  RacialCard({this.race});

  @override
  _RacialCardState createState() => _RacialCardState();
}

class _RacialCardState extends State<RacialCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 400,
        height: 800,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Center(
                        child: Container(
                      width: 128,
                      height: 128,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: widget.race.raceIcon, fit: BoxFit.cover)),
                    ))),
                Center(
                    child: Text(widget.race.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24))),
                Center(
                    child: Text(widget.race.homeCity,
                        style: TextStyle(fontSize: 16))),
                SizedBox(height: 40),
                ...widget.race.racials
              ],
            ),
          ),
        ));
  }
}
