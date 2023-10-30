import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tc/routes/routes.dart';

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
  static Color bgSideBar = const Color(0XFFF1F2F7);
  static Color sidebarInactive = const Color(0XFF787f89);
  static Color sidebarActive = const Color(0XFF5A6ACF);
  static Color sidebarIconInactive = const Color(0XFFA6ABC8);
  static Color sidebarIconActive = const Color(0XFF707FDD);
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

InputDecoration editProfileDecoration = InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderSide:
          BorderSide(color: CusColors.subHeader.withOpacity(.5), width: 1.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide:
          BorderSide(color: CusColors.subHeader.withOpacity(.2), width: 1.0),
    ),
    isCollapsed: true,
    contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15));

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

Widget cusPaymentWidgetOn(
    width, height, courseId, userId, isBundle, courseType, haveCourse) {
  return Container(
    width: width * .2,
    decoration: BoxDecoration(
      color: const Color(0xFF86B1F2),
      borderRadius: BorderRadius.circular(64),
    ),
    child: ElevatedButton(
      onPressed: () async {
        if (haveCourse == null) {
          if (courseType == 'Free') {
            Get.toNamed(
              routeOfferLearnCourse,
              parameters: {'id': courseId},
            );
          } else {
            // ganti jadi route payment
            Get.toNamed(
              routeBuyCourse,
              parameters: {'id': courseId},
            );
          }
        } else if (haveCourse == false) {
          Get.toNamed(
            routeOfferLearnCourse,
            parameters: {'id': courseId},
          );
        } else {
          Get.toNamed(
            routeLearnCourse,
            parameters: {'id': courseId},
          );
        }
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(
            vertical: height * 0.025,
          ),
        ),
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        shadowColor: MaterialStateProperty.all(Colors.transparent),
      ),
      child: haveCourse != null
          ? Text(
              'Learn Courses',
              style: GoogleFonts.mulish(
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontSize: width * 0.01,
              ),
            )
          : Text(
              isBundle ? 'Buy Courses Bundle' : 'Buy Course',
              style: GoogleFonts.mulish(
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontSize: width * 0.01,
              ),
            ),
    ),
  );
}

Widget cusPaymentWidgetOff(width, height, isBundle) {
  return Container(
    width: width * .2,
    decoration: BoxDecoration(
      color: const Color(0xFF86B1F2),
      borderRadius: BorderRadius.circular(64),
    ),
    child: ElevatedButton(
      onPressed: () {
        Get.toNamed(routeLogin);
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(
            vertical: height * 0.025,
          ),
        ),
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        shadowColor: MaterialStateProperty.all(Colors.transparent),
      ),
      child: Text(
        isBundle ? 'Buy Courses Bundle' : 'Buy Course',
        style: GoogleFonts.mulish(
          fontWeight: FontWeight.w700,
          color: Colors.white,
          fontSize: width * 0.01,
        ),
      ),
    ),
  );
}
