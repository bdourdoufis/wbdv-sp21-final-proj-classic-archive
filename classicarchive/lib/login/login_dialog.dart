import 'package:classicarchive/login/bloc/user_bloc.dart';
import 'package:classicarchive/login/register_dialog.dart';
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
    userBloc.userResult.listen((user) {
      print("User " + user.username + " successfully logged in!");
      FlutterSession().set("loggedIn", true);
      FlutterSession().set("faction", user.faction);
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
                        Navigator.pop(context);
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
                        userBloc.login(usernameFieldController.text,
                            passwordFieldController.text);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  )),
              AnimatedOpacity(
                  opacity: formOpacity,
                  duration: Duration(seconds: 1),
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return RegisterDialog();
                            });
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(color: Colors.blue, fontSize: 18),
                      )))
            ],
          )),
    );
  }
}
