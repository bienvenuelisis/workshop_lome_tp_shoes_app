import 'package:flutter/material.dart';
import 'package:flutter_paygateglobal/flutter_paygateglobal.dart';

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
  const MobileOperator({
    required this.slug,
    required this.label,
    required this.color,
    required this.provider,
    required this.asset,
    required this.prefixes,
  });

  final String asset;
  final Color color;
  final String label;
  final List<String> prefixes;
  final PaygateProvider provider;
  final String slug;
}

final List<MobileOperator> operators = [
  const MobileOperator(
    slug: "tmoney",
    label: "TMoney",
    color: Color(0xfffbd002),
    asset: "assets/images/payment_modes/t_money.png",
    provider: PaygateProvider.tmoney,
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
    provider: PaygateProvider.moovMoney,
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
