import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plasmabank/pages/Inteface.dart';
import 'package:plasmabank/pages/LoginPage.dart';
import 'package:plasmabank/pages/Register.dart';

void main() {
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
          home: LoginPage(),
      )
  );
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}




