import 'dart:async';

import 'package:classicarchive/login/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';

import 'models/user.dart';

class RegisterDialog extends StatefulWidget {
  @override
  _RegisterDialogState createState() => _RegisterDialogState();
}

class _RegisterDialogState extends State<RegisterDialog> {
  double formOpacity = 0.0;
  String faction;
  String favClass;
  final usernameFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();
  StreamSubscription<User> registerSubscription;

  @override
  void initState() {
    super.initState();
    registerSubscription = userBloc.userResult.listen((user) async {
      if (user.userId == null) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error"),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text('Unable to register with the given information.'),
                      Text('The provided username is already in use.'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      } else {
        await FlutterSession().set("loggedIn", true);
        await FlutterSession().set("loggedInUser", true);
        registerSubscription.cancel();
        Navigator.pop(context, user);
      }
    });

    Future.delayed(Duration(milliseconds: 600), () {
      setState(() {
        formOpacity = 1.0;
      });
    });
  }

  bool _validateInput() {
    if (usernameFieldController.text == "" ||
        passwordFieldController.text == "" ||
        faction == null ||
        favClass == null) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 20,
      child: Container(
          height: 500,
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
                        registerSubscription.cancel();
                        Navigator.pop(context, User());
                      },
                      child: Icon(Icons.close_rounded,
                          color: Colors.black, size: 40.0),
                    ),
                  )),
              Center(
                child: Text("Register",
                    style:
                        TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 25,
              ),
              AnimatedOpacity(
                  opacity: formOpacity,
                  duration: Duration(seconds: 1),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                    child: TextField(
                      controller: usernameFieldController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Username',
                          hintText: 'Enter your username...'),
                    ),
                  )),
              AnimatedOpacity(
                  opacity: formOpacity,
                  duration: Duration(seconds: 1),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                    child: TextField(
                      controller: passwordFieldController,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          hintText: 'Enter your password...'),
                    ),
                  )),
              AnimatedOpacity(
                  opacity: formOpacity,
                  duration: Duration(seconds: 1),
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                      child: Row(children: [
                        DropdownButton(
                            value: faction,
                            hint: Text("Select your faction..."),
                            onChanged: (value) {
                              setState(() {
                                faction = value;
                              });
                            },
                            items: [
                              DropdownMenuItem(
                                  child: Text("Alliance",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold)),
                                  value: "Alliance"),
                              DropdownMenuItem(
                                  child: Text("Horde",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold)),
                                  value: "Horde"),
                            ]),
                        Spacer(),
                        DropdownButton(
                            value: favClass,
                            hint: Text("Select your favorite class..."),
                            onChanged: (value) {
                              setState(() {
                                favClass = value;
                              });
                            },
                            items: [
                              DropdownMenuItem(
                                  child: Text("Warrior",
                                      style: TextStyle(
                                          color: Color(0xFFC79C6E),
                                          fontWeight: FontWeight.bold)),
                                  value: "Warrior"),
                              DropdownMenuItem(
                                  child: Text("Paladin",
                                      style: TextStyle(
                                          color: Color(0xFFF58CBA),
                                          fontWeight: FontWeight.bold)),
                                  value: "Paladin"),
                              DropdownMenuItem(
                                  child: Text("Hunter",
                                      style: TextStyle(
                                          color: Color(0xFFABD473),
                                          fontWeight: FontWeight.bold)),
                                  value: "Hunter"),
                              DropdownMenuItem(
                                  child: Text("Rogue",
                                      style: TextStyle(
                                          color: Color(0xFFD4AF37),
                                          fontWeight: FontWeight.bold)),
                                  value: "Rogue"),
                              DropdownMenuItem(
                                  child: Text("Priest",
                                      style: TextStyle(
                                          color: Color(0xFF696969),
                                          fontWeight: FontWeight.bold)),
                                  value: "Priest"),
                              DropdownMenuItem(
                                  child: Text("Shaman",
                                      style: TextStyle(
                                          color: Color(0xFF0070DE),
                                          fontWeight: FontWeight.bold)),
                                  value: "Shaman"),
                              DropdownMenuItem(
                                  child: Text("Mage",
                                      style: TextStyle(
                                          color: Color(0xFF69CCF0),
                                          fontWeight: FontWeight.bold)),
                                  value: "Mage"),
                              DropdownMenuItem(
                                  child: Text("Warlock",
                                      style: TextStyle(
                                          color: Color(0xFF9482C9),
                                          fontWeight: FontWeight.bold)),
                                  value: "Warlock"),
                              DropdownMenuItem(
                                  child: Text("Druid",
                                      style: TextStyle(
                                          color: Color(0xFFFF7D0A),
                                          fontWeight: FontWeight.bold)),
                                  value: "Druid"),
                            ])
                      ]))),
              SizedBox(height: 25),
              AnimatedOpacity(
                  opacity: formOpacity,
                  duration: Duration(seconds: 1),
                  child: Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextButton(
                      onPressed: () {
                        if (_validateInput()) {
                          userBloc.registerUser(usernameFieldController.text,
                              passwordFieldController.text, faction, favClass);
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Error"),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        Text(
                                            'Unable to register with the given information.'),
                                        Text(
                                            'Please make sure all fields are filled out.'),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Ok'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              });
                        }
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ))
            ],
          )),
    );
  }
}
