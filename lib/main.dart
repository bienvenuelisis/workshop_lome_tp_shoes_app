// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:workshop_lome_tp_shoes_app/view/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Quicksand',
      ),
      title: "FLutter WorkShop Demo",
      home: HomeScreen(),
    );
  }
}
