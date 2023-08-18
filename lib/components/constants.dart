import 'package:flutter/material.dart';

class CusColors {
  static Color mainColor = const Color(0xFF19A7CE);
  static Color header = const Color(0xFF37373E);
  static Color subHeader = const Color(0xFF676767);
  static Color footer = const Color(0xFF94A3B8);
  static Color text = const Color(0XFF2C2C2C);
}

InputDecoration textInputDecoration = InputDecoration(
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: CusColors.subHeader.withOpacity(.2)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.transparent),
    borderRadius: BorderRadius.circular(15),
  ),
  contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
  isDense: true,
  filled: true,
  fillColor: const Color(0xFFF6F7F9),
);
