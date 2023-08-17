import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Accept only numbers, limited to length of [length]
class PhoneNumberInputFormatter extends TextInputFormatter {
  final int length;

  PhoneNumberInputFormatter([this.length = 8]);

  static const String _separator = " ";

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    /// User is deleting characters in field.
    if (newValue.text.length <= oldValue.text.length) {
      return newValue;
    } else {
      String newValueNoSpaces = newValue.text.replaceAll(_separator, "");
      String oldValueNoSpaces = oldValue.text.replaceAll(_separator, "");

      /// No changes or user deleting last character.
      if (oldValueNoSpaces.length >= length) {
        return oldValue;
      } else {
        /// Only numbers, limited to length of [length].
        String regex = "^[0-9]{0,$length}\$";

        if (RegExp(regex).hasMatch(newValueNoSpaces)) {
          if ((newValue.text.length % 3) == 0) {
            if (oldValue.text.characters.last == _separator) {
              return newValue;
            } else {
              int offset = newValue.text.length + 1;

              return TextEditingValue(
                text: newValue.text.replaceRange(
                  0,
                  newValue.text.length - 1,
                  newValue.text.substring(0, newValue.text.length - 1) +
                      _separator,
                ),
                selection: TextSelection(
                  baseOffset: offset,
                  extentOffset: offset,
                  affinity: newValue.selection.affinity,
                  isDirectional: newValue.selection.isDirectional,
                ),
              );
            }
          } else if ((newValue.text.length % 3) == 2) {
            bool endOfNumber = newValueNoSpaces.length == length;
            int offset =
                endOfNumber ? newValue.text.length : newValue.text.length + 1;

            return newValue.copyWith(
              text: endOfNumber ? newValue.text : newValue.text + _separator,
              selection: TextSelection(
                baseOffset: offset,
                extentOffset: offset,
                affinity: newValue.selection.affinity,
                isDirectional: newValue.selection.isDirectional,
              ),
            );
          } else {
            return newValue;
          }
        } else {
          return oldValue;
        }
      }
    }
  }
}
