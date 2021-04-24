import 'package:classicarchive/login/bloc/user_bloc.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';

class LoginDialog extends StatefulWidget {
  @override
  _LoginDialogState createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  double formOpacity = 0.0;
  final usernameFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    userBloc.userResult.listen((user) async {
      if (user.userId == null) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error"),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text('Login failed.'),
                      Text('Please make sure your credentials are correct.'),
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
        await FlutterSession().set("loggedInUser", user);
        ThemeMode currentTheme = EasyDynamicTheme.of(context).themeMode;
        while ((currentTheme == ThemeMode.light && user.faction == "Horde") ||
            (currentTheme == ThemeMode.dark && user.faction == "Alliance") ||
            (currentTheme == ThemeMode.system && user.faction == "Alliance")) {
          EasyDynamicTheme.of(context).changeTheme();
          currentTheme = EasyDynamicTheme.of(context).themeMode;
        }
        Navigator.pop(context, true);
      }
    });

    Future.delayed(Duration(milliseconds: 600), () {
      setState(() {
        formOpacity = 1.0;
      });
    });
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
                        Navigator.pop(context, false);
                      },
                      child: Icon(Icons.close_rounded,
                          color: Colors.black, size: 40.0),
                    ),
                  )),
              Text("Login",
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 50,
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
                        if (usernameFieldController.text != "" &&
                            passwordFieldController.text != "") {
                          userBloc.login(usernameFieldController.text,
                              passwordFieldController.text);
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Error"),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        Text('Login failed.'),
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
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ))
            ],
          )),
    );
  }
}
