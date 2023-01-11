import 'package:flutter/material.dart';
import 'package:sos/view/welcomepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sos Sfax',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: WelcomePage(),
    );
  }
}
