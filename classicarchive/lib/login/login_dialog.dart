import 'package:flutter/material.dart';

class LoginDialog extends StatefulWidget {
  @override
  _LoginDialogState createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  double formOpacity = 0.0;

  @override
  void initState() {
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
                        //TODO: Login action here
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
