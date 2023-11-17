import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime {
  String formatDate() {
    return DateFormat('d MMMM y').format(this);
  }

  String formatDateAndTime() {
    return DateFormat('d MMMM y | HH:MM a').format(this);
  }
}

class ThousandsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove any commas from the new value to work with plain numbers
    String newText = newValue.text.replaceAll(',', '');

    // Add commas every three digits from the right
    final regEx = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    newText = newText.replaceAllMapped(regEx, (Match match) => '${match[1]},');

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
