import 'package:flutter/material.dart';
import 'package:chui/src/home/home_screen.dart';

class ChuiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Chui AI',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new HomeScreen(title: 'Chui AI'),
    );
  }
}