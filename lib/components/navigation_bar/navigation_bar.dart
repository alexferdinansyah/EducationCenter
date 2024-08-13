import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/components/navigation_bar/navigation_item.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CusNavigationBar extends StatefulWidget {
  const CusNavigationBar({super.key});

  @override
  State<CusNavigationBar> createState() => _CusNavigationBarState();
}

class _CusNavigationBarState extends State<CusNavigationBar> {
  int index = 0;
  String? _selectedValue;
  final List<String> _listLinks = [
    'Course',
    'Bootcamp',
    'Webinar',
    'Review Cv/Portopolio',
    'E-Book'
  ];
  final List<String> _urlLinks = [
    routeCourses,
    routeBootcamp,
    '/Webinar',
    '/Review',
    '/E-Book'
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final user = Provider.of<UserModel?>(context);
    final currentRoute = Get.rootDelegate.currentConfiguration!.location!;

    if (_selectedValue != null) {
      _listLinks.asMap().forEach((index, link) {
        if (link == _selectedValue!) {
          print(index);
          print('pindah ke route ' + _selectedValue!);
          Get.rootDelegate.toNamed(_urlLinks[index]);
        }
      });
    }

    if (currentRoute.contains(routeDetailSingleCourse) ||
        currentRoute.contains(routeDetailBundleCourse) ||
        currentRoute == routeBundleCourses ||
        currentRoute == routeCourses) {
      setState(() {
        index = 1;
      });
    } else if (currentRoute == routeArticle ||
        currentRoute.contains(routeDetailArticle)) {
      setState(() {
        index = 2;
      });
    } else if (currentRoute == routeContacts) {
      setState(() {
        index = 3;
      });
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Get.rootDelegate.toNamed(routeHome);
          },
          child: Image.asset(
            'assets/images/dec_logo2.png',
            width: width * .06,
          ),
        ),
        const Spacer(),
        NavigationItem(
          selected: index == 0,
          title: 'Home',
          routeName: routeHome,
          onHighlight: onHighlight,
        ),
        Container(
          width: 90,
          padding: EdgeInsets.symmetric(
              horizontal: getValueForScreenType<double>(
                  context: context, mobile: 20, desktop: 10, tablet: 30),
              vertical: getValueForScreenType<double>(
                context: context,
                mobile: 8,
              )),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              style: TextStyle(
                fontSize: getValueForScreenType<double>(
                  context: context,
                  mobile: width * .04,
                  desktop: width * .01,
                  tablet: width * .024),
                  fontWeight: FontWeight.bold,
              ),
              hint: Text(
                'Program',
                style: TextStyle(
                  color: CusColors.inactive.withOpacity(0.4),
                )
                ),
              value: _selectedValue,
              icon: SizedBox.shrink(), // Remove the triangle icon
              onChanged: (String? newValue) {
                setState(() {
                  _selectedValue = newValue;
                });
              },
              items: _listLinks.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
        // NavigationItem(
        //   selected: index == 1,
        //   title: 'Courses',
        //   routeName: routeCourses,
        //   onHighlight: onHighlight,
        // ),
        NavigationItem(
          selected: index == 2,
          title: 'Blog',
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
          width: user == null ? width * .09 : width * .1,
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
              Get.rootDelegate.toNamed(routeLogin);
            },
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(
                  vertical: height * .015,
                )),
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                shadowColor: MaterialStateProperty.all(Colors.transparent)),
            child: Text(
              user == null ? 'Login' : 'Dashboard',
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
    final user = Provider.of<UserModel?>(context);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final currentRoute = Get.rootDelegate.currentConfiguration!.location!;
    if (currentRoute.contains(routeDetailSingleCourse) ||
        currentRoute.contains(routeDetailBundleCourse) ||
        currentRoute == routeBundleCourses ||
        currentRoute == routeCourses) {
      setState(() {
        index = 1;
      });
    } else if (currentRoute == routeArticle ||
        currentRoute.contains(routeDetailArticle)) {
      setState(() {
        index = 2;
      });
    } else if (currentRoute == routeContacts) {
      setState(() {
        index = 3;
      });
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * .03, vertical: height * .015),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.rootDelegate.toNamed(routeHome);
                },
                child: Image.asset(
                  'assets/images/dec_logo2.png',
                  width: getValueForScreenType<double>(
                    context: context,
                    mobile: width * .13,
                    tablet: width * .1,
                    desktop: width * .019,
                  ),
                ),
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
        SizedBox(
          height: height * .05,
        ),
        NavigationItem(
          selected: index == 0,
          title: 'Home',
          routeName: routeHome,
          onHighlight: onHighlight,
        ),
        // NavigationItem(
        //   selected: index == 1,
        //   title: 'Courses',
        //   routeName: routeCourses,
        //   onHighlight: onHighlight,
        // ),
        NavigationItem(
          selected: index == 2,
          title: 'Articles',
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
          margin: EdgeInsets.symmetric(
              horizontal: width * .04, vertical: height * .03),
          height: getValueForScreenType<double>(
            context: context,
            mobile: 40,
            tablet: 48,
            desktop: 45,
          ),
          width: double.infinity,
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
              Get.rootDelegate.toNamed(routeLogin);
            },
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                shadowColor: MaterialStateProperty.all(Colors.transparent)),
            child: Text(
              user == null ? 'Login' : 'Dashboard',
              style: GoogleFonts.mulish(
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontSize: width * .03,
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
