import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plasmabank/pages/Inteface.dart';
import 'package:plasmabank/pages/LoginPage.dart';
import 'package:plasmabank/pages/Register.dart';
import 'package:plasmabank/pages/donorRegister.dart';
import 'package:plasmabank/pages/patientRegister.dart';
import 'package:plasmabank/requisities/styles.dart';

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




