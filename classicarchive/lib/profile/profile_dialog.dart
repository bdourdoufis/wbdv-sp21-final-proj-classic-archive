import 'package:classicarchive/login/bloc/user_bloc.dart';
import 'package:classicarchive/login/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';

class ProfileDialog extends StatefulWidget {
  final User user;

  ProfileDialog({this.user});

  @override
  _ProfileDialogState createState() => _ProfileDialogState();
}

class _ProfileDialogState extends State<ProfileDialog> {
  bool editable;
  double formOpacity = 0.0;
  AssetImage profileImage;
  final usernameFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();
  User originalUser;
  User loggedInUser;

  @override
  void initState() {
    super.initState();
    editable = false;
    verifyUser();

    Future.delayed(Duration(milliseconds: 600), () {
      setState(() {
        formOpacity = 1.0;
      });
    });

    usernameFieldController.text = widget.user.username;
    passwordFieldController.text = widget.user.password;

    setClassImage();

    originalUser = User(
        userId: widget.user.userId,
        username: widget.user.username,
        password: widget.user.password,
        faction: widget.user.faction,
        favoriteClass: widget.user.favoriteClass);
  }

  void setClassImage() {
    switch (widget.user.favoriteClass) {
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

  void verifyUser() async {
    dynamic userData = await FlutterSession().get("loggedInUser");
    if (userData != null) {
      loggedInUser = User.fromJson(userData);
      setState(() {
        if (loggedInUser.userId == widget.user.userId) {
          editable = true;
        } else {
          editable = false;
        }
      });
    } else {
      editable = false;
    }
  }

  T cast<T>(x) => x is T ? x : null;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 20,
      child: Container(
          height: 800,
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
                        Navigator.pop(context, User());
                      },
                      child: Icon(Icons.close_rounded,
                          color: Colors.black, size: 40.0),
                    ),
                  )),
              Text("User Profile: " + widget.user.username,
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 25,
              ),
              AnimatedOpacity(
                  opacity: formOpacity,
                  duration: Duration(seconds: 1),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: profileImage, fit: BoxFit.cover)),
                    ),
                  )),
              AnimatedOpacity(
                  opacity: formOpacity,
                  duration: Duration(seconds: 1),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                    child: TextField(
                      readOnly: true,
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
                      readOnly: !editable,
                      controller: passwordFieldController,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          hintText: 'Enter your password...'),
                    ),
                  )),
              SizedBox(height: 25),
              AnimatedOpacity(
                  opacity: formOpacity,
                  duration: Duration(seconds: 1),
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                      child: Row(children: [
                        DropdownButton(
                            value: widget.user.faction,
                            hint: Text("Select your faction..."),
                            onChanged: editable
                                ? (value) {
                                    setState(() {
                                      widget.user.faction = value;
                                    });
                                  }
                                : null,
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
                            value: widget.user.favoriteClass,
                            hint: Text("Select your favorite class..."),
                            onChanged: editable
                                ? (value) {
                                    setState(() {
                                      widget.user.favoriteClass = value;
                                      setClassImage();
                                    });
                                  }
                                : null,
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
              SizedBox(
                height: 25,
              ),
              editable
                  ? AnimatedOpacity(
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
                            userBloc.updateUser(widget.user);
                            Navigator.pop(context, widget.user);
                          },
                          child: Text(
                            'Save',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      ))
                  : Container()
            ],
          )),
    );
  }
}
