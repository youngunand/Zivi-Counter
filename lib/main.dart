// @dart=2.9
import 'package:flutter/material.dart';
import 'package:zivi_counter_app/home_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.grey[900],
        accentColor: Colors.amber[100],
        canvasColor: Colors.grey[800],
        focusColor: Colors.orange[500],
        dividerColor: Colors.grey[400],
        shadowColor: Colors.grey[800],
      ),
      home: HomePage(),
      routes:{
        '/HomePage': (context) => HomePage()
      },
    );
  }
}
