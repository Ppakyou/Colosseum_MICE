import 'package:flutter/material.dart';
import 'package:localtest_1/login/loginpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Colosseum',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Loginpage(),
    );
  }
}
