import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/advantage.dart';
import 'package:project_tc/components/articles.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/components/courses.dart';
import 'package:project_tc/components/navigation_bar/navigation_bar.dart';
import 'package:project_tc/components/static/article_data.dart';
import 'package:project_tc/components/static/course_data.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final bundleCourses =
      courses.where((course) => course.isBundle == true).take(3).toList();

  // First Row course
  final firstRowCourses =
      courses.where((course) => course.isBundle == false).take(3).toList();

// Second Row course
  final secondRowCourses = courses
      .where((course) => course.isBundle == false)
      .skip(3)
      .take(3)
      .toList();

  // First Row article
  final firstRowArticles = articles.take(3).toList();

// Second Row article
  final secondRowArticles = articles.skip(3).take(3).toList();

  List<bool> isHovered = [false, false, false];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: ListView(children: [
              Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * .045, vertical: height * .018),
                  alignment: Alignment.centerLeft,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CusNavigationBar(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 100),
                          child: Row(
                            children: [
                              SizedBox(
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 30),
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
                                          borderRadius:
                                              BorderRadius.circular(80),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(.25),
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
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          padding: MaterialStateProperty.all<
                                              EdgeInsetsGeometry>(
                                            EdgeInsets.symmetric(
                                              vertical: height * 0.025,
                                            ),
                                          ),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent),
                                          shadowColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent),
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
                              const Spacer(),
                              SvgPicture.asset(
                                'assets/svg/landing_page.svg',
                                width: width / 2.5,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 100),
                          child: Column(
                            children: [
                              Row(
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: const Color.fromRGBO(
                                                0, 0, 0, 1),
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
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 50, bottom: 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: advantage1
                                      .map((advantage1) =>
                                          Advantage(advantage: advantage1))
                                      .toList(),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: advantage2
                                    .map((advantage2) =>
                                        Advantage(advantage: advantage2))
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: bundleCourses
                                      .map(
                                        (course) => Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width *
                                                  .012), // Add right padding
                                          child: Courses(course: course),
                                        ),
                                      )
                                      .toList(),
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
                                      color: isHovered[0]
                                          ? const Color(0xFF86B1F2)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(64),
                                      border: Border.all(
                                        color: const Color(0xFF86B1F2),
                                        width: 1,
                                      ),
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        padding: MaterialStateProperty.all<
                                            EdgeInsetsGeometry>(
                                          EdgeInsets.symmetric(
                                            vertical: height * 0.025,
                                          ),
                                        ),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.transparent),
                                        shadowColor: MaterialStateProperty.all(
                                            Colors.transparent),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: Text(
                                              'See More Bundle',
                                              style: GoogleFonts.mulish(
                                                fontWeight: FontWeight.w700,
                                                color: isHovered[0]
                                                    ? Colors.white
                                                    : const Color(0xFF86B1F2),
                                                fontSize: width * 0.01,
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_outward_rounded,
                                            color: isHovered[0]
                                                ? Colors.white
                                                : const Color(0xFF86B1F2),
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
                                      margin: const EdgeInsets.only(
                                          top: 26, bottom: 70),
                                      width: 56,
                                      height: 2,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: const Color.fromRGBO(0, 0, 0, 1),
                                      )),
                                  Row(
                                    children: firstRowCourses
                                        .map(
                                          (course) => Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: width *
                                                    .012), // Add right padding
                                            child: Courses(course: course),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: secondRowCourses
                                        .map(
                                          (course) => Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: width *
                                                    .012), // Add right padding
                                            child: Courses(course: course),
                                          ),
                                        )
                                        .toList(),
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
                                      duration:
                                          const Duration(milliseconds: 300),
                                      width: width / 5,
                                      decoration: BoxDecoration(
                                        color: isHovered[1]
                                            ? const Color(0xFF86B1F2)
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(64),
                                        border: Border.all(
                                          color: const Color(0xFF86B1F2),
                                          width: 1,
                                        ),
                                      ),
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          padding: MaterialStateProperty.all<
                                              EdgeInsetsGeometry>(
                                            EdgeInsets.symmetric(
                                              vertical: height * 0.025,
                                            ),
                                          ),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent),
                                          shadowColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              child: Text(
                                                'See More Courses',
                                                style: GoogleFonts.mulish(
                                                  fontWeight: FontWeight.w700,
                                                  color: isHovered[1]
                                                      ? Colors.white
                                                      : const Color(0xFF86B1F2),
                                                  fontSize: width * 0.01,
                                                ),
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_outward_rounded,
                                              color: isHovered[1]
                                                  ? Colors.white
                                                  : const Color(0xFF86B1F2),
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
                                    margin: const EdgeInsets.only(
                                        top: 26, bottom: 70),
                                    width: 56,
                                    height: 2,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: const Color.fromRGBO(0, 0, 0, 1),
                                    )),
                                Row(
                                  children: firstRowArticles
                                      .map(
                                        (article) => Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width *
                                                  .012), // Add right padding
                                          child: Articles(article: article),
                                        ),
                                      )
                                      .toList(),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: secondRowArticles
                                      .map(
                                        (article) => Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width *
                                                  .012), // Add right padding
                                          child: Articles(article: article),
                                        ),
                                      )
                                      .toList(),
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
                                      color: isHovered[2]
                                          ? const Color(0xFF86B1F2)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(64),
                                      border: Border.all(
                                        color: const Color(0xFF86B1F2),
                                        width: 1,
                                      ),
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        padding: MaterialStateProperty.all<
                                            EdgeInsetsGeometry>(
                                          EdgeInsets.symmetric(
                                            vertical: height * 0.025,
                                          ),
                                        ),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.transparent),
                                        shadowColor: MaterialStateProperty.all(
                                            Colors.transparent),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: Text(
                                              'See More Article',
                                              style: GoogleFonts.mulish(
                                                fontWeight: FontWeight.w700,
                                                color: isHovered[2]
                                                    ? Colors.white
                                                    : const Color(0xFF86B1F2),
                                                fontSize: width * 0.01,
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_outward_rounded,
                                            color: isHovered[2]
                                                ? Colors.white
                                                : const Color(0xFF86B1F2),
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
                        Padding(
                          padding: const EdgeInsets.only(top: 100, bottom: 30),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only(bottom: 50),
                                height: 2,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF0081FE),
                                ),
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/logo_dac.png',
                                    width: width * .14,
                                  ),
                                  const Spacer(),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(right: 10),
                                            child: Icon(
                                              Icons.location_on,
                                              color: Color(0xFF0081FE),
                                            ),
                                          ),
                                          Text(
                                            'Jl. Karet Hijau no.52 Beji Timur,Depok - Jawa Barat 16421',
                                            style: GoogleFonts.assistant(
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xFF0A142F),
                                              fontSize: width * 0.01,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15, bottom: 35),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.phone,
                                              color: Color(0xFF0081FE),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10, right: width * .05),
                                              child: Text(
                                                '+62-21-7721-0358',
                                                style: GoogleFonts.assistant(
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      const Color(0xFF0A142F),
                                                  fontSize: width * 0.01,
                                                ),
                                              ),
                                            ),
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 10),
                                              child: Icon(
                                                Icons.mail,
                                                color: Color(0xFF0081FE),
                                              ),
                                            ),
                                            Text(
                                              'info@dac-solution.com',
                                              style: GoogleFonts.assistant(
                                                fontWeight: FontWeight.w500,
                                                color: const Color(0xFF0A142F),
                                                fontSize: width * 0.01,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Social Media',
                                            style: GoogleFonts.assistant(
                                              fontWeight: FontWeight.w500,
                                              color: CusColors.inactive,
                                              fontSize: width * 0.01,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 40),
                                            child: SvgPicture.asset(
                                                'assets/svg/facebook.svg'),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: SvgPicture.asset(
                                                'assets/svg/instagram.svg'),
                                          ),
                                          SvgPicture.asset(
                                              'assets/svg/whatsapp.svg'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                width: double.infinity,
                                margin:
                                    const EdgeInsets.only(top: 80, bottom: 25),
                                height: 2,
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xFF0081FE).withOpacity(0.2),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '© Copyright PT DAC Solution Informatika',
                                    style: GoogleFonts.assistant(
                                      fontWeight: FontWeight.w500,
                                      color: CusColors.inactive,
                                      fontSize: width * 0.01,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ]))
            ])));
  }
}
