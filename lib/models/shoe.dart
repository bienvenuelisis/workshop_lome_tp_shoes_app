// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Shoe {
  const Shoe({
    required this.name,
    required this.model,
    required this.price,
    required this.imgAddress,
    required this.modelColor,
  });

  final String imgAddress;
  final String model;
  final Color modelColor;
  final String name;
  final int price;
}
