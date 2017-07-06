import 'package:flutter/material.dart';
import 'package:chui/src/home/home_state.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);
  final String title;
  @override
  HomeState createState() => new HomeState();
}
