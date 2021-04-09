import 'package:flutter/material.dart';

class RegisterDialog extends StatefulWidget {
  @override
  _RegisterDialogState createState() => _RegisterDialogState();
}

class _RegisterDialogState extends State<RegisterDialog> {
  double formOpacity = 0.0;
  String faction;
  List<DropdownMenuItem> factionDropdownItems;

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 600), () {
      setState(() {
        formOpacity = 1.0;
      });
    });

    factionDropdownItems = [
      DropdownMenuItem(child: Text("Alliance"), value: "Alliance"),
      DropdownMenuItem(child: Text("Horde"), value: "Horde"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 20,
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
                        Navigator.pop(context);
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
              AnimatedOpacity(
                  opacity: formOpacity,
                  duration: Duration(seconds: 1),
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                      child: DropdownButton(
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
                        //TODO: Register action here
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
