import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/components/navigation_bar/navigation_item.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/routes/routes.dart';
import 'package:project_tc/screens/wrapper.dart';
import 'package:provider/provider.dart';

class CusNavigationBar extends StatefulWidget {
  const CusNavigationBar({super.key});

  @override
  State<CusNavigationBar> createState() => _CusNavigationBarState();
}

class _CusNavigationBarState extends State<CusNavigationBar> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final user = Provider.of<UserModel?>(context);
    if (Get.currentRoute == routeDetailBundleCourse ||
        Get.currentRoute == routeDetailSingleCourse ||
        Get.currentRoute == routeBundleCourses ||
        Get.currentRoute == routeCourses) {
      setState(() {
        index = 1;
      });
    } else if (Get.currentRoute == routeArticle ||
        Get.currentRoute == routeDetailArticle) {
      setState(() {
        index = 2;
      });
    } else if (Get.currentRoute == routeContacts) {
      setState(() {
        index = 3;
      });
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/logo_dac.png',
          width: width * .14,
        ),
        const Spacer(),
        NavigationItem(
          selected: index == 0,
          title: 'Home',
          routeName: routeHome,
          onHighlight: onHighlight,
        ),
        NavigationItem(
          selected: index == 1,
          title: 'Courses',
          routeName: routeCourses,
          onHighlight: onHighlight,
        ),
        NavigationItem(
          selected: index == 2,
          title: 'Article',
          routeName: routeArticle,
          onHighlight: onHighlight,
        ),
        NavigationItem(
          selected: index == 3,
          title: 'Contact',
          routeName: routeContacts,
          onHighlight: onHighlight,
        ),
        const Spacer(),
        Container(
          margin: EdgeInsets.only(left: width * .03),
          width: user != null ? width * .09 : width * .1,
          decoration: BoxDecoration(
              gradient:
                  LinearGradient(begin: const Alignment(-1.2, 0.0), colors: [
                const Color(0xFF00C8FF),
                CusColors.mainColor,
              ]),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(.25),
                    spreadRadius: 0,
                    blurRadius: 20,
                    offset: const Offset(0, 4))
              ]),
          child: ElevatedButton(
            onPressed: () {
              Get.toNamed(routeLogin);
            },
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(
                  vertical: height * .025,
                )),
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                shadowColor: MaterialStateProperty.all(Colors.transparent)),
            child: Text(
              user != null ? 'Login' : 'Dashboard',
              style: GoogleFonts.mulish(
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontSize: width * .012,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void onHighlight(String route) {
    switch (route) {
      case routeHome:
        changeHighlight(0);
        break;
      case routeCourses:
        changeHighlight(1);
        break;
      case routeArticle:
        changeHighlight(2);
        break;
      case routeContacts:
        changeHighlight(3);
        break;
    }
  }

  void changeHighlight(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }
}

class CusNavigationBarMobile extends StatefulWidget {
  const CusNavigationBarMobile({super.key});

  @override
  State<CusNavigationBarMobile> createState() => _CusNavigationBarMobileState();
}

class _CusNavigationBarMobileState extends State<CusNavigationBarMobile> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if (Get.currentRoute == '/detail-bundle-courses' ||
        Get.currentRoute == '/detail-single-courses') {
      setState(() {
        index = 1;
      });
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * .03, vertical: height * .015),
          child: Row(
            children: [
              Image.asset(
                'assets/images/logo_dac.png',
                width: width * .3,
              ),
              const Spacer(),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.close, color: Color(0xFF458FF6)))
            ],
          ),
        ),
        NavigationItem(
          selected: index == 0,
          title: 'Home',
          routeName: routeHome,
          onHighlight: onHighlight,
        ),
        NavigationItem(
          selected: index == 1,
          title: 'Courses',
          routeName: routeCourses,
          onHighlight: onHighlight,
        ),
        NavigationItem(
          selected: index == 2,
          title: 'Article',
          routeName: routeArticle,
          onHighlight: onHighlight,
        ),
        NavigationItem(
          selected: index == 3,
          title: 'Contact',
          routeName: routeContacts,
          onHighlight: onHighlight,
        ),
        Container(
          margin: EdgeInsets.only(left: width * .03),
          width: width * .09,
          decoration: BoxDecoration(
              gradient:
                  LinearGradient(begin: const Alignment(-1.2, 0.0), colors: [
                const Color(0xFF00C8FF),
                CusColors.mainColor,
              ]),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(.25),
                    spreadRadius: 0,
                    blurRadius: 20,
                    offset: const Offset(0, 4))
              ]),
          child: ElevatedButton(
            onPressed: () {
              Get.to(() => const Wrapper());
            },
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(
                  vertical: height * .025,
                )),
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                shadowColor: MaterialStateProperty.all(Colors.transparent)),
            child: Text(
              'Login',
              style: GoogleFonts.mulish(
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontSize: width * .012,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void onHighlight(String route) {
    switch (route) {
      case routeHome:
        changeHighlight(0);
        break;
      case routeCourses:
        changeHighlight(1);
        break;
      case routeArticle:
        changeHighlight(2);
        break;
      case routeContacts:
        changeHighlight(3);
        break;
    }
  }

  void changeHighlight(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }
}
