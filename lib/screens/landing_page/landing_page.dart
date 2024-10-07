import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/advantage.dart';
import 'package:project_tc/components/articles.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/components/courses.dart';
import 'package:project_tc/components/faq.dart';
import 'package:project_tc/components/footer.dart';
import 'package:project_tc/models/article.dart';
import 'package:project_tc/models/course.dart';
import 'package:project_tc/routes/routes.dart';
import 'package:project_tc/services/firestore_service.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:carousel_slider/carousel_slider.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  List<bool> isHovered = [false, false, false];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var deviceType = getDeviceType(MediaQuery.of(context).size);
    int crossAxis = 0;
    double mainHeader = 0;
    double title = 0;
    double subHeader = 0;
    double widthCourse = 0;
    double widthArticle = 0;
    switch (deviceType) {
      case DeviceScreenType.desktop:
        crossAxis = 3;
        mainHeader = width * .028;
        subHeader = width * .01;
        title = width * .018;
        widthCourse = width / 1.7;
        widthArticle = width / 1.5;
        break;
      case DeviceScreenType.tablet:
        crossAxis = 2;
        mainHeader = width * .029;
        subHeader = width * .015;
        title = width * .022;
        widthCourse = width / 1.8;
        widthArticle = width / 1.6;

        break;
      case DeviceScreenType.mobile:
        crossAxis = 1;
        mainHeader = width * .04;
        subHeader = width * .018;
        title = width * .028;
        widthCourse = width / 2;
        widthArticle = width / 1.8;
        break;
      default:
        crossAxis = 0;
        mainHeader = 0;
        subHeader = 0;
        title = 0;
        widthCourse = 0;
    }
    return Column(children: [
      HeaderLandingPage(
          width: width,
          height: height,
          mainHeader: mainHeader,
          subHeader: subHeader),
      Padding(
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          children: [
            AnimateIfVisible(
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
                            'Advantages join our education center',
                            style: GoogleFonts.mulish(
                                color: CusColors.header,
                                fontSize: title,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: getValueForScreenType<double>(
                                context: context,
                                mobile: 10,
                                tablet: 20,
                                desktop: 26,
                              )),
                              width: width * .05,
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
                                  fontSize: subHeader,
                                  fontWeight: FontWeight.w300,
                                  height: 1.5),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const AdvantageListResponsive(),
          ],
        ),
      ),
      StreamBuilder(
          stream: FirestoreService.withoutUID().courseArticleStream(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              final List<Map> dataMaps = snapshot.data!;

              final List<Map> bestSalesCourses = dataMaps
                  .where((courseMap) {
                    final dynamic data = courseMap['course'];
                    return data is Course && data.isBestSales == true;
                  })
                  .map((courseMap) {
                    final Course course = courseMap['course'];
                    final String id = courseMap['id'];
                    return {'course': course, 'id': id};
                  })
                  .take(3)
                  .toList();

              final List<Map> singleCourses = dataMaps
                  .where((courseMap) {
                    final dynamic data = courseMap['course'];
                    return data is Course &&
                        data.isBundle == false &&
                        data.isDraft == false;
                  })
                  .map((courseMap) {
                    final Course course = courseMap['course'];
                    final String id = courseMap['id'];
                    return {'course': course, 'id': id};
                  })
                  .take(6)
                  .toList();

              final List<Map> articles = dataMaps
                  .where((articleData) {
                    final dynamic data = articleData['article'];
                    return data is Article;
                  })
                  .where(
                      (articleData) => articleData['article'].isDraft == false)
                  .map((articleData) {
                    final Article article = articleData['article'];
                    final String id = articleData['id'];
                    return {'article': article, 'id': id};
                  })
                  .take(3)
                  .toList();

              return Column(
                children: [
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
                              'Best Seller',
                              style: GoogleFonts.mulish(
                                  color: CusColors.header,
                                  fontSize: title,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: height / 1.9,
                            width: widthCourse,
                            child: ScrollConfiguration(
                              behavior: ScrollConfiguration.of(context)
                                  .copyWith(scrollbars: false),
                              child: MasonryGridView.count(
                                physics: const ScrollPhysics(
                                    parent: BouncingScrollPhysics()),
                                crossAxisSpacing: width *
                                    .02, // Adjust spacing between items horizontally
                                mainAxisSpacing:
                                    16.0, // Adjust spacing between rows vertically
                                crossAxisCount: crossAxis,
                                itemCount: bestSalesCourses.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Courses(
                                      course: bestSalesCourses[index]['course'],
                                      id: bestSalesCourses[index]['id']);
                                },
                              ),
                            ),
                          ),
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
                              'Latest Courses',
                              style: GoogleFonts.mulish(
                                  color: CusColors.header,
                                  fontSize: title,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                                margin: EdgeInsets.only(
                                    bottom: getValueForScreenType<double>(
                                      context: context,
                                      mobile: 40,
                                      tablet: 50,
                                      desktop: 70,
                                    ),
                                    top: getValueForScreenType<double>(
                                      context: context,
                                      mobile: 10,
                                      tablet: 20,
                                      desktop: 26,
                                    )),
                                width: width * .05,
                                height: 2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color.fromRGBO(0, 0, 0, 1),
                                )),
                            SizedBox(
                              height: getValueForScreenType<double>(
                                context: context,
                                mobile:
                                    (height / 4) * (singleCourses.length / 1),
                                tablet:
                                    (height / 2.8) * (singleCourses.length / 2),
                                desktop:
                                    (height / 2) * (singleCourses.length / 3),
                              ),
                              width: widthCourse,
                              child: ScrollConfiguration(
                                behavior: ScrollConfiguration.of(context)
                                    .copyWith(scrollbars: false),
                                child: MasonryGridView.count(
                                  physics: const ScrollPhysics(
                                      parent: BouncingScrollPhysics()),
                                  crossAxisSpacing: width *
                                      .02, // Adjust spacing between items horizontally
                                  mainAxisSpacing:
                                      16.0, // Adjust spacing between rows vertically
                                  crossAxisCount: crossAxis,
                                  itemCount: singleCourses.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Courses(
                                        course: singleCourses[index]['course'],
                                        id: singleCourses[index]['id']);
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: getValueForScreenType<double>(
                                context: context,
                                mobile: height * .05,
                                tablet: height / 10,
                                desktop: 0,
                              ),
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
                                height: getValueForScreenType<double>(
                                  context: context,
                                  mobile: 28,
                                  tablet: 35,
                                  desktop: 45,
                                ),
                                duration: const Duration(milliseconds: 300),
                                decoration: BoxDecoration(
                                  color: isHovered[1]
                                      ? CusColors.accentBlue
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(64),
                                  border: Border.all(
                                    color: CusColors.accentBlue,
                                    width: 1,
                                  ),
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Get.rootDelegate.toNamed(routeCourses);
                                  },
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    padding: MaterialStateProperty.all<
                                        EdgeInsetsGeometry>(
                                      EdgeInsets.symmetric(
                                        horizontal:
                                            getValueForScreenType<double>(
                                          context: context,
                                          mobile: width * .022,
                                          tablet: width * .011,
                                          desktop: width * .013,
                                        ),
                                      ),
                                    ),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    shadowColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          right: getValueForScreenType<double>(
                                            context: context,
                                            mobile: 4,
                                            tablet: 7,
                                            desktop: 10,
                                          ),
                                        ),
                                        child: Text(
                                          'See More Courses',
                                          style: GoogleFonts.mulish(
                                              fontWeight: FontWeight.w700,
                                              color: isHovered[1]
                                                  ? Colors.white
                                                  : CusColors.accentBlue,
                                              fontSize: subHeader),
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_outward_rounded,
                                        color: isHovered[1]
                                            ? Colors.white
                                            : CusColors.accentBlue,
                                        size: getValueForScreenType<double>(
                                          context: context,
                                          mobile: height * .018,
                                          tablet: height * .014,
                                          desktop: height * .025,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Column(
                  //       children: [
                  //         Text(
                  //           'Latest Articles',
                  //           style: GoogleFonts.mulish(
                  //               color: CusColors.header,
                  //               fontSize: title,
                  //               fontWeight: FontWeight.bold),
                  //         ),
                  //         Container(
                  //             margin: EdgeInsets.only(
                  //                 bottom: getValueForScreenType<double>(
                  //                   context: context,
                  //                   mobile: 40,
                  //                   tablet: 50,
                  //                   desktop: 70,
                  //                 ),
                  //                 top: getValueForScreenType<double>(
                  //                   context: context,
                  //                   mobile: 10,
                  //                   tablet: 20,
                  //                   desktop: 26,
                  //                 )),
                  //             width: width * .05,
                  //             height: 2,
                  //             decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(5),
                  //               color: const Color.fromRGBO(0, 0, 0, 1),
                  //             )),
                  //         SizedBox(
                  //           height: getValueForScreenType<double>(
                  //             context: context,
                  //             mobile: (height / 3) * (articles.length / 1),
                  //             tablet: (height / 1.9) * (articles.length / 2),
                  //             desktop: height / 1.6,
                  //           ),
                  //           width: widthArticle,
                  //           child: ScrollConfiguration(
                  //             behavior: ScrollConfiguration.of(context)
                  //                 .copyWith(scrollbars: false),
                  //             child: MasonryGridView.count(
                  //               physics: const ScrollPhysics(
                  //                   parent: BouncingScrollPhysics()),
                  //               crossAxisSpacing: width *
                  //                   .02, // Adjust spacing between items horizontally
                  //               mainAxisSpacing:
                  //                   16.0, // Adjust spacing between rows vertically
                  //               crossAxisCount: crossAxis,
                  //               itemCount: articles.length,
                  //               itemBuilder: (BuildContext context, int index) {
                  //                 return Articles(
                  //                   article: articles[index]['article'],
                  //                   id: articles[index]['id'],
                  //                 );
                  //               },
                  //             ),
                  //           ),
                  //         ),
                  //         SizedBox(
                  //           height: getValueForScreenType<double>(
                  //             context: context,
                  //             mobile: height * .05,
                  //             tablet: height / 10,
                  //             desktop: height / 10,
                  //           ),
                  //         ),
                  //         MouseRegion(
                  //           onEnter: (_) {
                  //             // Set the hover state
                  //             setState(() {
                  //               isHovered[2] = true;
                  //             });
                  //           },
                  //           onExit: (_) {
                  //             // Reset the hover state
                  //             setState(() {
                  //               isHovered[2] = false;
                  //             });
                  //           },
                  //           child: AnimatedContainer(
                  //             height: getValueForScreenType<double>(
                  //               context: context,
                  //               mobile: 28,
                  //               tablet: 35,
                  //               desktop: 45,
                  //             ),
                  //             duration: const Duration(milliseconds: 300),
                  //             decoration: BoxDecoration(
                  //               color: isHovered[2]
                  //                   ? CusColors.accentBlue
                  //                   : Colors.white,
                  //               borderRadius: BorderRadius.circular(64),
                  //               border: Border.all(
                  //                 color: CusColors.accentBlue,
                  //                 width: 1,
                  //               ),
                  //             ),
                  //             child: ElevatedButton(
                  //               onPressed: () {
                  //                 Get.rootDelegate.toNamed(routeArticle);
                  //               },
                  //               style: ButtonStyle(
                  //                 shape: MaterialStateProperty.all<
                  //                     RoundedRectangleBorder>(
                  //                   RoundedRectangleBorder(
                  //                     borderRadius: BorderRadius.circular(8),
                  //                   ),
                  //                 ),
                  //                 padding: MaterialStateProperty.all<
                  //                     EdgeInsetsGeometry>(
                  //                   EdgeInsets.symmetric(
                  //                     horizontal: getValueForScreenType<double>(
                  //                       context: context,
                  //                       mobile: width * .022,
                  //                       tablet: width * .011,
                  //                       desktop: width * .013,
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 backgroundColor: MaterialStateProperty.all(
                  //                     Colors.transparent),
                  //                 shadowColor: MaterialStateProperty.all(
                  //                     Colors.transparent),
                  //               ),
                  //               child: Row(
                  //                 crossAxisAlignment: CrossAxisAlignment.center,
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 children: [
                  //                   Padding(
                  //                     padding: EdgeInsets.only(
                  //                       right: getValueForScreenType<double>(
                  //                         context: context,
                  //                         mobile: 4,
                  //                         tablet: 7,
                  //                         desktop: 10,
                  //                       ),
                  //                     ),
                  //                     child: Text(
                  //                       'See More Articles',
                  //                       style: GoogleFonts.mulish(
                  //                           fontWeight: FontWeight.w700,
                  //                           color: isHovered[2]
                  //                               ? Colors.white
                  //                               : CusColors.accentBlue,
                  //                           fontSize: subHeader),
                  //                     ),
                  //                   ),
                  //                   Icon(
                  //                     Icons.arrow_outward_rounded,
                  //                     color: isHovered[2]
                  //                         ? Colors.white
                  //                         : CusColors.accentBlue,
                  //                     size: getValueForScreenType<double>(
                  //                       context: context,
                  //                       mobile: height * .018,
                  //                       tablet: height * .014,
                  //                       desktop: height * .025,
                  //                     ),
                  //                   )
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //   ],
                  // ),
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No data available.'),
              );
            } else {
              return const Center(
                child: Text('kok iso.'),
              );
            }
          }),

          const FAQSection(),

      const Footer()
    ]);
  }
}

class HeaderLandingPage extends StatelessWidget {
  final double width;
  final double height;
  final double mainHeader;
  final double subHeader;
  const HeaderLandingPage(
      {super.key,
      required this.width,
      required this.height,
      required this.mainHeader,
      required this.subHeader});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        // Check the sizing information here and return your UI
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          return _defaultHeader(context);
        }
        if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
          return _defaultHeader(context);
        }
        if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
          return Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 50),
            child: CarouselSlider(
              options: CarouselOptions(
                  autoPlay: true,
                  viewportFraction: 1,
                  pageSnapping: true,
                  aspectRatio: 16 / 13),
              items: [
                // Column(
                //   children: [
                //     AnimateIfVisible(
                //       key: const Key('item.2'),
                //       builder: (
                //         BuildContext context,
                //         Animation<double> animation,
                //       ) =>
                //           FadeTransition(
                //         opacity: Tween<double>(
                //           begin: 0,
                //           end: 1,
                //         ).animate(animation),
                //         child: SvgPicture.asset(
                //           'assets/svg/landing_page.svg',
                //           width: width / 1.8,
                //         ),
                //       ),
                //     ),
                //     AnimateIfVisible(
                //       key: const Key('item.1'),
                //       builder: (
                //         BuildContext context,
                //         Animation<double> animation,
                //       ) =>
                //           FadeTransition(
                //         opacity: Tween<double>(
                //           begin: 0,
                //           end: 1,
                //         ).animate(animation),
                //         child: Padding(
                //           padding: const EdgeInsets.symmetric(vertical: 20),
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.center,
                //             children: [
                //               Text(
                //                 'DAC Education Center',
                //                 style: GoogleFonts.mulish(
                //                     color: CusColors.header,
                //                     fontSize: mainHeader,
                //                     fontWeight: FontWeight.bold),
                //               ),
                //               Padding(
                //                 padding:
                //                     const EdgeInsets.only(top: 10, bottom: 15),
                //                 child: Text(
                //                   'DEC (DAC Education Center) is a learning platform that focuses on developing programming-based educational programs. DEC is committed to delivering interactive, in-depth, and relevant learning experiences for learners who want to enhance their skills and knowledge in the field of programming.',
                //                   textAlign: TextAlign.center,
                //                   style: GoogleFonts.mulish(
                //                       color: CusColors.inactive,
                //                       fontSize: subHeader,
                //                       fontWeight: FontWeight.w300,
                //                       height: 1.5),
                //                 ),
                //               ),
                //               Container(
                //                 height: 28,
                //                 decoration: BoxDecoration(
                //                     color: const Color(0xFF00C8FF),
                //                     borderRadius: BorderRadius.circular(80),
                //                     boxShadow: [
                //                       BoxShadow(
                //                           color: Colors.black.withOpacity(.25),
                //                           spreadRadius: 0,
                //                           blurRadius: 20,
                //                           offset: const Offset(0, 4))
                //                     ]),
                //                 child: ElevatedButton(
                //                   onPressed: () {
                //                     Get.rootDelegate.toNamed(routeLogin);
                //                   },
                //                   style: ButtonStyle(
                //                     shape: MaterialStateProperty.all<
                //                         RoundedRectangleBorder>(
                //                       RoundedRectangleBorder(
                //                         borderRadius: BorderRadius.circular(8),
                //                       ),
                //                     ),
                //                     backgroundColor: MaterialStateProperty.all(
                //                         Colors.transparent),
                //                     shadowColor: MaterialStateProperty.all(
                //                         Colors.transparent),
                //                   ),
                //                   child: Text(
                //                     'Start now',
                //                     style: GoogleFonts.mulish(
                //                       fontWeight: FontWeight.w700,
                //                       color: Colors.white,
                //                       fontSize: subHeader,
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                Image.asset(
                  'assets/images/SLIDE 1.png',
                ),
                Image.asset(
                  'assets/images/SLIDE 2.png',
                ),
                Image.asset(
                  'assets/images/SLIDE 3.png',
                ),
              ],
            ),
          );
        }

        return Container(color: Colors.white);
      },
    );
  }

  Widget _defaultHeader(context) {
    return Padding(
        padding: EdgeInsets.only(
          top: 100,
          bottom: getValueForScreenType<double>(
            context: context,
            mobile: 50,
            tablet: 100,
            desktop: 150,
          ),
        ),
        child: CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            viewportFraction: 1,
            pageSnapping: true,
            aspectRatio: getValueForScreenType<double>(
              context: context,
              mobile: 16 / 7,
              tablet: 16 / 5.7,
              desktop: 16 / 5.6,
            ),
          ),
          items: [
            // Column(
            //   children: [
            //     Row(
            //       children: [
            //         AnimateIfVisible(
            //           key: const Key('item.1'),
            //           builder: (
            //             BuildContext context,
            //             Animation<double> animation,
            //           ) =>
            //               FadeTransition(
            //             opacity: Tween<double>(
            //               begin: 0,
            //               end: 1,
            //             ).animate(animation),
            //             child: SizedBox(
            //               width: width / 2.5,
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Text(
            //                     'DAC Education Center',
            //                     style: GoogleFonts.mulish(
            //                         color: CusColors.header,
            //                         fontSize: mainHeader,
            //                         fontWeight: FontWeight.bold),
            //                   ),
            //                   Padding(
            //                     padding:
            //                         const EdgeInsets.symmetric(vertical: 30),
            //                     child: Text(
            //                       'DEC (DAC Education Center) is a learning platform that focuses on developing programming-based educational programs. DEC is committed to delivering interactive, in-depth, and relevant learning experiences for learners who want to enhance their skills and knowledge in the field of programming.',
            //                       style: GoogleFonts.mulish(
            //                           color: CusColors.inactive,
            //                           fontSize: subHeader,
            //                           fontWeight: FontWeight.w300,
            //                           height: 1.5),
            //                     ),
            //                   ),
            //                   Container(
            //                     width: width * .09,
            //                     decoration: BoxDecoration(
            //                       color: const Color(0xFF00C8FF),
            //                       borderRadius: BorderRadius.circular(80),
            //                     ),
            //                     child: ElevatedButton(
            //                       onPressed: () {
            //                         Get.rootDelegate.toNamed(routeLogin);
            //                       },
            //                       style: ButtonStyle(
            //                         shape: MaterialStateProperty.all<
            //                             RoundedRectangleBorder>(
            //                           RoundedRectangleBorder(
            //                             borderRadius: BorderRadius.circular(8),
            //                           ),
            //                         ),
            //                         padding: MaterialStateProperty.all<
            //                             EdgeInsetsGeometry>(
            //                           EdgeInsets.symmetric(
            //                             vertical: height * 0.015,
            //                           ),
            //                         ),
            //                         backgroundColor: MaterialStateProperty.all(
            //                             Colors.transparent),
            //                         shadowColor: MaterialStateProperty.all(
            //                             Colors.transparent),
            //                       ),
            //                       child: Text(
            //                         'Start now',
            //                         style: GoogleFonts.mulish(
            //                           fontWeight: FontWeight.w700,
            //                           color: Colors.white,
            //                           fontSize: width * 0.01,
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ),
            //         ),
            //         const Spacer(),
            //         AnimateIfVisible(
            //           key: const Key('item.2'),
            //           builder: (
            //             BuildContext context,
            //             Animation<double> animation,
            //           ) =>
            //               FadeTransition(
            //             opacity: Tween<double>(
            //               begin: 0,
            //               end: 1,
            //             ).animate(animation),
            //             child: SvgPicture.asset(
            //               'assets/svg/landing_page.svg',
            //               width: width / 2.5,
            //             ),
            //           ),
            //         )
            //       ],
            //     ),
            //   ],
            // ),
            Image.asset(
              'assets/images/SLIDE 1.png',
            ),
            Image.asset(
              'assets/images/SLIDE 2.png',
            ),
            Image.asset(
              'assets/images/SLIDE 3.png',
            ),
          ],
        ));
  }
}

class AdvantageListResponsive extends StatelessWidget {
  const AdvantageListResponsive({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      // Check the sizing information here and return your UI
      if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
        return _defaultList();
      }
      if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
        return _defaultList();
      }
      if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: advantage
                    .map((advantage1) => Advantage(advantage: advantage1))
                    .take(2)
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: advantage
                    .map((advantage2) => Advantage(advantage: advantage2))
                    .skip(2)
                    .take(2)
                    .toList(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: advantage
                  .map((advantage3) => Advantage(advantage: advantage3))
                  .skip(4)
                  .take(2)
                  .toList(),
            ),
          ],
        );
      }
      return Container();
    });
  }

  Widget _defaultList() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50, bottom: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: advantage
                .map((advantage1) => Advantage(advantage: advantage1))
                .take(3)
                .toList(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: advantage
              .map((advantage2) => Advantage(advantage: advantage2))
              .skip(3)
              .take(3)
              .toList(),
        ),
      ],
    );
  }
}
