import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

class CusColors {
  static Color mainColor = const Color(0xFF19A7CE);
  static Color header = const Color(0xFF37373E);
  static Color subHeader = const Color(0xFF676767);
  static Color footer = const Color(0xFF94A3B8);
  static Color text = const Color(0XFF2C2C2C);
  static Color secondaryText = const Color(0XFF828282);
  static Color title = const Color(0XFF363636);
  static Color inactive = const Color(0XFF7D7987);
  static Color accentBlue = const Color(0XFF86B1F2);
  static Color bg = const Color(0XFFFAFAFA);
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

class CusSearchBar extends StatelessWidget {
  const CusSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        style: GoogleFonts.mPlus1(
          fontWeight: FontWeight.w500,
          color: CusColors.subHeader,
          fontSize: width * .009,
        ),
        cursorColor: const Color(0xFFCCCCCC),
        textAlign: TextAlign.justify,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: CusColors.subHeader.withOpacity(.5)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFCCCCCC)),
            borderRadius: BorderRadius.circular(15),
          ),
          prefixIcon: const Icon(
            IconlyBroken.search,
          ),
          prefixIconColor: MaterialStateColor.resolveWith((states) =>
              states.contains(MaterialState.focused)
                  ? CusColors.subHeader.withOpacity(0.5)
                  : const Color(0xFFCCCCCC)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          isDense: true,
          hintText: 'Search article...',
          hintStyle: GoogleFonts.mPlus1(
            fontWeight: FontWeight.w500,
            color: CusColors.subHeader.withOpacity(0.5),
            fontSize: width * .009,
          ),
        ),
      ),
    );
  }
}
