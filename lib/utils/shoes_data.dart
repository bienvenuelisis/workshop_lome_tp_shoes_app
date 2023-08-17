import 'package:flutter/material.dart';
import 'package:workshop_demo_app/models/shoe.dart';

final List<Shoe> availableShoes = [
  const Shoe(
    name: "NIKE",
    model: "AIR-MAX",
    price: 13000,
    imgAddress: "assets/images/nike1.png",
    modelColor: Color(0xffDE0106),
  ),
  const Shoe(
    name: "NIKE",
    model: "AIR-JORDAN MID",
    price: 19000,
    imgAddress: "assets/images/nike8.png",
    modelColor: Color(0xff3F7943),
  ),
  const Shoe(
    name: "NIKE",
    model: "ZOOM",
    price: 16000,
    imgAddress: "assets/images/nike2.png",
    modelColor: Color(0xffE66863),
  ),
  const Shoe(
    name: "NIKE",
    model: "Air-FORCE",
    price: 11000,
    imgAddress: "assets/images/nike3.png",
    modelColor: Color(0xffD7D8DC),
  ),
  const Shoe(
    name: "NIKE",
    model: "AIR-JORDAN LOW",
    price: 15000,
    imgAddress: "assets/images/nike5.png",
    modelColor: Color(0xff37376B),
  ),
  const Shoe(
    name: "NIKE",
    model: "ZOOM",
    price: 11500,
    imgAddress: "assets/images/nike4.png",
    modelColor: Color(0xffE4E3E8),
  ),
  const Shoe(
    name: "NIKE",
    model: "AIR-JORDAN LOW",
    price: 15000,
    imgAddress: "assets/images/nike7.png",
    modelColor: Color(0xffD68043),
  ),
  const Shoe(
    name: "NIKE",
    model: "AIR-JORDAN LOW",
    price: 15000,
    imgAddress: "assets/images/nike6.png",
    modelColor: Color(0xffE2E3E5),
  ),
];

List<Shoe> itemsOnBag = [];

final List<double> sizes = [6, 7.5, 8, 9.5];
