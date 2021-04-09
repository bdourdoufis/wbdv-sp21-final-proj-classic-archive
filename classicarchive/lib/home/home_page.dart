import 'package:classicarchive/login/login_dialog.dart';
import 'package:classicarchive/login/register_dialog.dart';
import 'package:classicarchive/search/search_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double titleOpacity = 0.0;
  double subtitleOpacity = 0.0;
  double searchButtonOpacity = 0.0;

  SnackBar emptySearchSnackBar;

  final controller = TextEditingController();

  @override
  void initState() {
    //Fade in home page widgets
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        titleOpacity = 1.0;
      });
    });

    Future.delayed(Duration(milliseconds: 600), () {
      setState(() {
        subtitleOpacity = 1.0;
      });
    });

    Future.delayed(Duration(milliseconds: 800), () {
      searchButtonOpacity = 1.0;
    });
  }

  AppBar _buildAppBar(BuildContext context) {
    // TODO: If user is logged in, show link to profile
    // If not, show login/signup actions
    return AppBar(
      leading: InkWell(
        child: Image.asset("assets/images/logo.png"),
        onTap: () {},
      ),
      actions: [
        //Only want to display these actions if not logged in
        //If logged in, instead have a textbutton containing the username
        //which routes to the profile page
        TextButton(
            onPressed: () {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return LoginDialog();
                  });
            },
            child: Text(
              "Login",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.white),
            )),
        SizedBox(
          width: 25,
        ),
        TextButton(
            onPressed: () {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return RegisterDialog();
                  });
            },
            child: Text("Register",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white)))
      ],
    );
  }

  void _routeToSearch(BuildContext context) {
    if (controller.text.length > 0) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SearchPage(searchValue: controller.text)));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SearchPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/dark_portal.jpg"),
                  fit: BoxFit.cover)),
          child: Center(
              child: Column(children: [
            AnimatedOpacity(
              opacity: titleOpacity,
              duration: Duration(seconds: 2),
              child: Text("Classic Archive",
                  style: TextStyle(fontSize: 72, fontWeight: FontWeight.bold)),
            ),
            AnimatedOpacity(
              opacity: subtitleOpacity,
              duration: Duration(seconds: 2),
              child: Text("World of Warcraft: Classic Item Database",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 200),
            Container(
                width: 800,
                child: TextField(
                    controller: controller,
                    onSubmitted: (value) => _routeToSearch(context),
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                        labelText: "Search for an item..."))),
            SizedBox(height: 50),
            SizedBox(
                width: 150,
                height: 75,
                child: ElevatedButton(
                  child: Text("SEARCH",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
                  onPressed: () => _routeToSearch(context),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                  ),
                ))
          ])),
        ));
  }
}
