import 'package:flutter/material.dart';

extension MobileOperatorUtils on String {
  MobileOperator get operator {
    for (MobileOperator operator in operators) {
      List<String> prefixes = operator.prefixes;

      for (String prefix in prefixes) {
        if (startsWith(prefix)) {
          return operator;
        }
      }
    }

    return operators.first;
  }
}

class MobileOperator {
  final String slug;
  final String label;
  final Color color;
  final String asset;
  final List<String> prefixes;

  const MobileOperator({
    required this.slug,
    required this.label,
    required this.color,
    required this.asset,
    required this.prefixes,
  });
}

final List<MobileOperator> operators = [
  const MobileOperator(
    slug: "tmoney",
    label: "TMoney",
    color: Color(0xfffbd002),
    asset: "assets/images/payment_modes/t_money.png",
    prefixes: [
      "93",
      "92",
      "91",
      "90",
      "705",
      "704",
      "703",
      "702",
      "701",
      "700",
    ],
  ),
  const MobileOperator(
    slug: "moovMoney",
    label: "Moov Money",
    color: Color(0xfff37d01),
    asset: "assets/images/payment_modes/moov_money.png",
    prefixes: [
      "99",
      "98",
      "97",
      "96",
      "799",
      "798",
      "797",
      "796",
      "795",
      "794",
      "793",
    ],
  ),
];
