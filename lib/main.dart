import 'package:flutter/material.dart';
import 'package:hashfame/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<int, Color> color = {
      50: Color.fromRGBO(71, 96, 114, .1),
      100: Color.fromRGBO(71, 96, 114, .2),
      200: Color.fromRGBO(71, 96, 114, .3),
      300: Color.fromRGBO(71, 96, 114, .4),
      400: Color.fromRGBO(71, 96, 114, .5),
      500: Color.fromRGBO(71, 96, 114, .6),
      600: Color.fromRGBO(71, 96, 114, .7),
      700: Color.fromRGBO(71, 96, 114, .8),
      800: Color.fromRGBO(71, 96, 114, .9),
      900: Color.fromRGBO(71, 96, 114, 1),
    };
    MaterialColor colorCustom = MaterialColor(0xff476072, color);
    return MaterialApp(
      theme: ThemeData(primarySwatch: colorCustom),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
