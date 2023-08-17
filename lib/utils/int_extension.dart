import 'package:intl/intl.dart';

extension IntExtension on int {
  String get formatted {
    // Create a NumberFormat instance for currency formatting
    var currencyFormat = NumberFormat.currency(
      locale: 'fr_FR',
      symbol: 'FCFA',
      decimalDigits: 0,
      customPattern: '#,##0.00 ¤',
    );

    return currencyFormat.format(this);
  }
}
