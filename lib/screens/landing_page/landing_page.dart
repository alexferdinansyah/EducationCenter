import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/advantage.dart';
import 'package:project_tc/components/animation/animation_function.dart';
import 'package:project_tc/components/articles.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/components/courses.dart';
import 'package:project_tc/components/footer.dart';
import 'package:project_tc/components/static/article_data.dart';
import 'package:project_tc/components/static/course_data.dart';
import 'package:project_tc/routes/routes.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final bundleCourses =
      courses.where((course) => course.isBundle == true).take(3).toList();

  // list course
  final listCourses =
      courses.where((course) => course.isBundle == false).take(6).toList();

  // list article
  final listArticles = articles.take(6).toList();

  List<bool> isHovered = [false, false, false];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(top: 100, bottom: 200),
        child: Row(
          children: [
            AnimateIfVisible(
              reAnimateOnVisibility: true,
              key: const Key('item.1'),
              builder: (
                BuildContext context,
                Animation<double> animation,
              ) =>
                  FadeTransition(
                opacity: Tween<double>(
                  begin: 0,
                  end: 1,
                ).animate(animation),
                child: SizedBox(
                  width: width / 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'DAC Education Center',
                        style: GoogleFonts.mulish(
                            color: CusColors.header,
                            fontSize: width * .028,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Text(
                          'DAC provides progressive, and affordable courses, accessible on website, designed to empower individuals to enhance their skills.',
                          style: GoogleFonts.mulish(
                              color: CusColors.inactive,
                              fontSize: width * .012,
                              fontWeight: FontWeight.w300,
                              height: 1.5),
                        ),
                      ),
                      Container(
                        width: width * .09,
                        decoration: BoxDecoration(
                            color: const Color(0xFF00C8FF),
                            borderRadius: BorderRadius.circular(80),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(.25),
                                  spreadRadius: 0,
                                  blurRadius: 20,
                                  offset: const Offset(0, 4))
                            ]),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.symmetric(
                                vertical: height * 0.025,
                              ),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                            shadowColor:
                                MaterialStateProperty.all(Colors.transparent),
                          ),
                          child: Text(
                            'Start now',
                            style: GoogleFonts.mulish(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: width * 0.01,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            AnimateIfVisible(
              reAnimateOnVisibility: true,
              key: const Key('item.2'),
              builder: (
                BuildContext context,
                Animation<double> animation,
              ) =>
                  FadeTransition(
                opacity: Tween<double>(
                  begin: 0,
                  end: 1,
                ).animate(animation),
                child: SvgPicture.asset(
                  'assets/svg/landing_page.svg',
                  width: width / 2.5,
                ),
              ),
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          children: [
            AnimateIfVisible(
                reAnimateOnVisibility: true,
                key: const Key('item.3'),
                builder: (
                  BuildContext context,
                  Animation<double> animation,
                ) =>
                    FadeTransition(
                        opacity: Tween<double>(
                          begin: 0,
                          end: 1,
                        ).animate(animation),
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 2),
                            end: Offset.zero,
                          ).animate(animation),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Advantage join our education center',
                                    style: GoogleFonts.mulish(
                                        color: CusColors.header,
                                        fontSize: width * .018,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 26),
                                      width: 56,
                                      height: 2,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: const Color.fromRGBO(0, 0, 0, 1),
                                      )),
                                  SizedBox(
                                    width: width / 1.5,
                                    child: Text(
                                      'We provide to you the best choiches for you. Customize it according to your coding preferences, and ensure a seamless learning journey guided by our experienced instructors.',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.mulish(
                                          color: CusColors.inactive,
                                          fontSize: width * .01,
                                          fontWeight: FontWeight.w300,
                                          height: 1.5),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ))),
            Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: advantage1
                    .map((advantage1) => Advantage(advantage: advantage1))
                    .toList(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: advantage2
                  .map((advantage2) => Advantage(advantage: advantage2))
                  .toList(),
            ),
          ],
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: width / 1.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: const Color(0xFFF6F7F9),
            ),
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Text(
                  'Bundle Course',
                  style: GoogleFonts.mulish(
                      color: CusColors.header,
                      fontSize: width * .018,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: height / 1.9,
                width: width / 1.7,
                child: LiveGrid(
                    reAnimateOnVisibility: true,
                    itemCount: bundleCourses.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: height * .51,
                      crossAxisCount: 3, // Number of items per row
                      crossAxisSpacing: width *
                          .02, // Adjust spacing between items horizontally
                      mainAxisSpacing:
                          16.0, // Adjust spacing between rows vertically
                    ),
                    itemBuilder: animationBuilder(
                        (index) => Courses(course: bundleCourses[index]))),
              ),
              SizedBox(
                height: height / 10,
              ),
              MouseRegion(
                onEnter: (_) {
                  // Set the hover state
                  setState(() {
                    isHovered[0] = true;
                  });
                },
                onExit: (_) {
                  // Reset the hover state
                  setState(() {
                    isHovered[0] = false;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: width / 5,
                  decoration: BoxDecoration(
                    color: isHovered[0] ? CusColors.accentBlue : Colors.white,
                    borderRadius: BorderRadius.circular(64),
                    border: Border.all(
                      color: CusColors.accentBlue,
                      width: 1,
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(routeBundleCourses);
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
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                      shadowColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(
                            'See More Bundle',
                            style: GoogleFonts.mulish(
                              fontWeight: FontWeight.w700,
                              color: isHovered[0]
                                  ? Colors.white
                                  : CusColors.accentBlue,
                              fontSize: width * 0.01,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_outward_rounded,
                          color: isHovered[0]
                              ? Colors.white
                              : CusColors.accentBlue,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ]),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 100),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  'Courses',
                  style: GoogleFonts.mulish(
                      color: CusColors.header,
                      fontSize: width * .018,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 26, bottom: 70),
                    width: 56,
                    height: 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromRGBO(0, 0, 0, 1),
                    )),
                SizedBox(
                  height: (height / 2) * (listCourses.length / 3),
                  width: width / 1.7,
                  child: LiveGrid(
                      reAnimateOnVisibility: true,
                      itemCount: listCourses.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: height * .48,
                        crossAxisCount: 3, // Number of items per row
                        crossAxisSpacing: width *
                            .02, // Adjust spacing between items horizontally
                        mainAxisSpacing:
                            16.0, // Adjust spacing between rows vertically
                      ),
                      itemBuilder: animationBuilder(
                          (index) => Courses(course: listCourses[index]))),
                ),
                SizedBox(
                  height: height / 10,
                ),
                MouseRegion(
                  onEnter: (_) {
                    // Set the hover state
                    setState(() {
                      isHovered[1] = true;
                    });
                  },
                  onExit: (_) {
                    // Reset the hover state
                    setState(() {
                      isHovered[1] = false;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: width / 5,
                    decoration: BoxDecoration(
                      color: isHovered[1] ? CusColors.accentBlue : Colors.white,
                      borderRadius: BorderRadius.circular(64),
                      border: Border.all(
                        color: CusColors.accentBlue,
                        width: 1,
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(routeCourses);
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(
                            vertical: height * 0.025,
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                        shadowColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              'See More Courses',
                              style: GoogleFonts.mulish(
                                fontWeight: FontWeight.w700,
                                color: isHovered[1]
                                    ? Colors.white
                                    : CusColors.accentBlue,
                                fontSize: width * 0.01,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_outward_rounded,
                            color: isHovered[1]
                                ? Colors.white
                                : CusColors.accentBlue,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                'Articles',
                style: GoogleFonts.mulish(
                    color: CusColors.header,
                    fontSize: width * .018,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 26, bottom: 70),
                  width: 56,
                  height: 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color.fromRGBO(0, 0, 0, 1),
                  )),
              SizedBox(
                height: (height / 1.6) * (listArticles.length / 3),
                width: width / 1.5,
                child: LiveGrid(
                    reAnimateOnVisibility: true,
                    itemCount: listArticles.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: height * .59,
                      crossAxisCount: 3, // Number of items per row
                      crossAxisSpacing: width *
                          .02, // Adjust spacing between items horizontally
                      mainAxisSpacing:
                          16.0, // Adjust spacing between rows vertically
                    ),
                    itemBuilder: animationBuilder(
                        (index) => Articles(article: listArticles[index]))),
              ),
              SizedBox(
                height: height / 10,
              ),
              MouseRegion(
                onEnter: (_) {
                  // Set the hover state
                  setState(() {
                    isHovered[2] = true;
                  });
                },
                onExit: (_) {
                  // Reset the hover state
                  setState(() {
                    isHovered[2] = false;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: width / 5,
                  decoration: BoxDecoration(
                    color: isHovered[2] ? CusColors.accentBlue : Colors.white,
                    borderRadius: BorderRadius.circular(64),
                    border: Border.all(
                      color: CusColors.accentBlue,
                      width: 1,
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(routeArticle);
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
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                      shadowColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(
                            'See More Article',
                            style: GoogleFonts.mulish(
                              fontWeight: FontWeight.w700,
                              color: isHovered[2]
                                  ? Colors.white
                                  : CusColors.accentBlue,
                              fontSize: width * 0.01,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_outward_rounded,
                          color: isHovered[2]
                              ? Colors.white
                              : CusColors.accentBlue,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
      const Footer()
    ]);
  }
}
