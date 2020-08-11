import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plasmabank/pages/LoginPage.dart';
import 'package:plasmabank/pages/Register.dart';

void main() {
  runApp(
      MaterialApp(
          home: RegisterPage(),
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




