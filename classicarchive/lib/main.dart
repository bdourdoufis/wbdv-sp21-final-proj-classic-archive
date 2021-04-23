// @dart=2.9
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';

import 'home/home_page.dart';

void main() {
  runApp(EasyDynamicThemeWidget(child: MainApp()));
}

Map<int, Color> hordeSwatch = {
  50: Color.fromRGBO(136, 8, 8, .1),
  100: Color.fromRGBO(136, 8, 8, .2),
  200: Color.fromRGBO(136, 8, 8, .3),
  300: Color.fromRGBO(136, 8, 8, .4),
  400: Color.fromRGBO(136, 8, 8, .5),
  500: Color.fromRGBO(136, 8, 8, .6),
  600: Color.fromRGBO(136, 8, 8, .7),
  700: Color.fromRGBO(136, 8, 8, .8),
  800: Color.fromRGBO(136, 8, 8, .9),
  900: Color.fromRGBO(136, 8, 8, 1),
};

Map<int, Color> allianceSwatch = {
  50: Color.fromRGBO(0, 34, 238, .1),
  100: Color.fromRGBO(0, 34, 238, .2),
  200: Color.fromRGBO(0, 34, 238, .3),
  300: Color.fromRGBO(0, 34, 238, .4),
  400: Color.fromRGBO(0, 34, 238, .5),
  500: Color.fromRGBO(0, 34, 238, .6),
  600: Color.fromRGBO(0, 34, 238, .7),
  700: Color.fromRGBO(0, 34, 238, .8),
  800: Color.fromRGBO(0, 34, 238, .9),
  900: Color.fromRGBO(0, 34, 238, 1),
};

ThemeData allianceTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Color(0xFF0022EE),
  accentColor: Color(0xFFD4AF37),
  primarySwatch: MaterialColor(0xFF0022EE, allianceSwatch),
  buttonColor: Color(0xFFD4AF37),
  buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(primary: Color(0xFFD4AF37))),
  appBarTheme: AppBarTheme(
      actionsIconTheme: IconThemeData(color: Color(0xFFD4AF37)),
      iconTheme: IconThemeData(color: Color(0xFFD4AF37)),
      textTheme: TextTheme(
          headline6: TextStyle(color: Color(0xFFD4AF37)),
          button: TextStyle(color: Color(0xFFD4AF37)))),
);

ThemeData hordeTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Color(0xFF880808),
  accentColor: Color(0xFF000000),
  primarySwatch: MaterialColor(0xFF880808, hordeSwatch),
  buttonColor: Color(0xFF880808),
  buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent),
  textButtonTheme:
      TextButtonThemeData(style: TextButton.styleFrom(primary: Colors.black)),
  appBarTheme: AppBarTheme(
      actionsIconTheme: IconThemeData(color: Colors.black),
      iconTheme: IconThemeData(color: Colors.black),
      textTheme: TextTheme(
          headline6: TextStyle(color: Colors.black),
          button: TextStyle(color: Colors.black))),
);

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Classic Archive',
      theme: allianceTheme,
      darkTheme: hordeTheme,
      themeMode: EasyDynamicTheme.of(context).themeMode,
      home: HomePage(),
    );
  }
}
