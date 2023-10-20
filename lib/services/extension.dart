import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime {
  String formatDate() {
    return DateFormat('d MMMM y').format(this);
  }

  String formatDateAndTime() {
    return DateFormat('d MMMM y | HH:MM a').format(this);
  }
}
