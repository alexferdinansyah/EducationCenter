import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/custom_list.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/controllers/detail_controller.dart';
import 'package:project_tc/controllers/learn_course_controller.dart';
import 'package:project_tc/models/user.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class DetailSingleCourse extends StatefulWidget {
  const DetailSingleCourse({super.key});

  @override
  State<DetailSingleCourse> createState() => _DetailSingleCourseState();
}

class _DetailSingleCourseState extends State<DetailSingleCourse> {
  String id = '';

  final DetailCourseController controller = Get.put(DetailCourseController());
  final LearnCourseController learnController =
      Get.put(LearnCourseController());
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    var argument = Get.rootDelegate.parameters;
    id = argument['id']!;
    controller.fetchDocument(id);

    // Course course = courses[3];

    return Obx(() {
      final course = controller.documentSnapshot.value;

      if (course == null) {
        return const Center(child: Text('Loading...'));
      }

      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.only(
            top: getValueForScreenType<double>(
              context: context,
              mobile: 25,
              tablet: 40,
              desktop: 100,
            ),
            bottom: getValueForScreenType<double>(
              context: context,
              mobile: 60,
              tablet: 70,
              desktop: 200,
            ),
          ),
          child: ResponsiveBuilder(
            builder: (context, sizingInformation) {
              // Check the sizing information here and return your UI
              if (sizingInformation.deviceScreenType ==
                  DeviceScreenType.desktop) {
                return _defaultHeader(width, course.courseCategory,
                    course.title, course.description, course.image);
              }
              if (sizingInformation.deviceScreenType ==
                  DeviceScreenType.tablet) {
                return _defaultHeader(width, course.courseCategory,
                    course.title, course.description, course.image);
              }
              if (sizingInformation.deviceScreenType ==
                  DeviceScreenType.mobile) {
                return _headerMobile(width, course.courseCategory, course.title,
                    course.description, course.image);
              }
              return Container();
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: getValueForScreenType<double>(
              context: context,
              mobile: 50,
              tablet: 70,
              desktop: 100,
            ),
          ),
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
                              'What you will learn on this course',
                              style: GoogleFonts.mulish(
                                  color: CusColors.header,
                                  fontSize: getValueForScreenType<double>(
                                    context: context,
                                    mobile: width * .028,
                                    tablet: width * .022,
                                    desktop: width * .018,
                                  ),
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: getValueForScreenType<double>(
                                    context: context,
                                    mobile: 30,
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
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              BorderList(
                chapterList: course.chapterList!,
                fontSize: getValueForScreenType<double>(
                  context: context,
                  mobile: width * .02,
                  tablet: width * .017,
                  desktop: width * .012,
                ),
                subFontSize: getValueForScreenType<double>(
                  context: context,
                  mobile: width * .019,
                  tablet: width * .016,
                  desktop: width * .011,
                ),
                subPadding: getValueForScreenType<double>(
                  context: context,
                  mobile: 5,
                  tablet: 10,
                  desktop: 15,
                ),
                padding: getValueForScreenType<double>(
                  context: context,
                  mobile: 4,
                  tablet: 5,
                  desktop: 5,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: getValueForScreenType<double>(
              context: context,
              mobile: 40,
              tablet: 70,
              desktop: 100,
            ),
          ),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  width: width / 1.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color(0xFFF6F7F9),
                  ),
                  padding: EdgeInsets.only(
                    top: 20,
                    bottom: getValueForScreenType<double>(
                      context: context,
                      mobile: 40,
                      tablet: 70,
                      desktop: 100,
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 50),
                        child: Text(
                          'What you get after completing this course',
                          style: GoogleFonts.mulish(
                              color: CusColors.header,
                              fontSize: getValueForScreenType<double>(
                                context: context,
                                mobile: width * .025,
                                tablet: width * .019,
                                desktop: width * .015,
                              ),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      BulletList(
                        course.completionBenefits!,
                        padding: getValueForScreenType<double>(
                          context: context,
                          mobile: 4,
                          tablet: 5,
                          desktop: 7,
                        ),
                        border: true,
                        fontSize: getValueForScreenType<double>(
                          context: context,
                          mobile: width * .019,
                          tablet: width * .016,
                          desktop: width * .011,
                        ),
                      )
                    ],
                  ),
                ),
              ]),
            ],
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            width: width * .5,
            margin: const EdgeInsets.only(bottom: 100),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white,
              border: Border.all(
                color: const Color(0xFFCCCCCC),
                width: 1,
              ),
            ),
            padding: EdgeInsets.all(
              getValueForScreenType<double>(
                context: context,
                mobile: width * .015,
                tablet: width * .012,
                desktop: width * .012,
              ),
            ),
            child: ResponsiveBuilder(
              builder: (context, sizingInformation) {
                // Check the sizing information here and return your UI
                if (sizingInformation.deviceScreenType ==
                    DeviceScreenType.desktop) {
                  return Row(
                    children: [
                      _defaultPaymentCard(user, width, height, course.price,
                          course.discount, course.isBundle, course.courseType)
                    ],
                  );
                }
                if (sizingInformation.deviceScreenType ==
                    DeviceScreenType.tablet) {
                  return _defaultPaymentCard(user, width, height, course.price,
                      course.discount, course.isBundle, course.courseType);
                }
                if (sizingInformation.deviceScreenType ==
                    DeviceScreenType.mobile) {
                  return _mobilePaymentCard(user, width, height, course.price,
                      course.discount, course.isBundle, course.courseType);
                }
                return Container();
              },
            ),
          ),
        ]),
      ]);
    });
  }

  Widget _defaultHeader(width, courseCategory, title, description, image) {
    return Row(
      children: [
        AnimateIfVisible(
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
                    courseCategory,
                    style: GoogleFonts.mulish(
                      color: CusColors.accentBlue,
                      fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .02,
                        tablet: width * .017,
                        desktop: width * .012,
                      ),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      title,
                      style: GoogleFonts.mulish(
                          color: CusColors.header,
                          fontSize: getValueForScreenType<double>(
                            context: context,
                            mobile: width * .04,
                            tablet: width * .029,
                            desktop: width * .028,
                          ),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    description,
                    style: GoogleFonts.mulish(
                        color: CusColors.inactive,
                        fontSize: getValueForScreenType<double>(
                          context: context,
                          mobile: width * .02,
                          tablet: width * .017,
                          desktop: width * .012,
                        ),
                        fontWeight: FontWeight.w300,
                        height: 1.5),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Spacer(),
        AnimateIfVisible(
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
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(image, width: width / 2.7)),
          ),
        )
      ],
    );
  }

  Widget _headerMobile(width, courseCategory, title, description, image) {
    return Column(
      children: [
        AnimateIfVisible(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(image, width: double.infinity),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        courseCategory,
                        style: GoogleFonts.mulish(
                          color: CusColors.accentBlue,
                          fontSize: width * .022,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          title,
                          style: GoogleFonts.mulish(
                              color: CusColors.header,
                              fontSize: width * .04,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        description,
                        style: GoogleFonts.mulish(
                            color: CusColors.inactive,
                            fontSize: width * .022,
                            fontWeight: FontWeight.w300,
                            height: 1.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _defaultPayment(user, width, height, isBundle, courseType) {
    return user != null
        ? FutureBuilder<bool?>(
            future: learnController.getIsPaid(
                user.uid, id), // Assuming `getIsPaid` returns a `Future<bool>`
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // You can return a loading indicator or placeholder widget here
                return const Center(
                  child: SpinKitCircle(
                    color: Colors.blue,
                    size: 34,
                  ),
                ); // Replace with your loading widget
              } else if (snapshot.hasError) {
                // Handle error
                return Text('Error: ${snapshot.error}');
              } else {
                return cusPaymentWidgetOn(width, height, id, user.uid, isBundle,
                    courseType, snapshot.data, context);
              }
            })
        : cusPaymentWidgetOff(width, height, isBundle, id, courseType, context);
  }

  Widget _defaultPaymentCard(
      user, width, height, price, discount, isBundle, courseType) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: width * .25,
          height: height * .28,
          margin: EdgeInsets.only(right: width * .012),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            image: const DecorationImage(
              image: AssetImage('assets/images/certificate.png'),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Join now',
              style: GoogleFonts.mulish(
                  color: CusColors.header,
                  fontSize: getValueForScreenType<double>(
                    context: context,
                    mobile: width * .023,
                    tablet: width * .020,
                    desktop: width * .015,
                  ),
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: height * .015,
                bottom: getValueForScreenType<double>(
                  context: context,
                  mobile: width * .017,
                  tablet: width * .02,
                  desktop: height * .03,
                ),
              ),
              child: BulletList(
                const [
                  'Up-to-date Content',
                  'Learn with study case',
                  'Beginner friendly'
                ],
                border: false,
                fontSize: getValueForScreenType<double>(
                  context: context,
                  mobile: width * .019,
                  tablet: width * .016,
                  desktop: width * .011,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: height * .025),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Rp $price',
                    style: GoogleFonts.mulish(
                        color: CusColors.title,
                        fontSize: getValueForScreenType<double>(
                          context: context,
                          mobile: width * .023,
                          tablet: width * .020,
                          desktop: width * .015,
                        ),
                        fontWeight: FontWeight.bold,
                        height: 1.5),
                  ),
                  discount != ''
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.transparent,
                            border: Border.all(
                              color: const Color(0xFF2501FF),
                              width: 1,
                            ),
                          ),
                          margin: const EdgeInsets.only(left: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 3),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '$discount% Off',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF2501FF),
                                  fontSize: getValueForScreenType<double>(
                                    context: context,
                                    mobile: width * .017,
                                    tablet: width * .014,
                                    desktop: width * .009,
                                  ),
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            _defaultPayment(user, width, height, isBundle, courseType)
          ],
        ),
      ],
    );
  }

  Widget _mobilePaymentCard(
      user, width, height, price, discount, isBundle, courseType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: height * .2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            image: const DecorationImage(
              image: AssetImage('assets/images/certificate.png'),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Join now',
                style: GoogleFonts.mulish(
                    color: CusColors.header,
                    fontSize: width * .026,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: height * .015,
                  bottom: width * .017,
                ),
                child: BulletList(
                  const [
                    'Up-to-date Content',
                    'Learn with study case',
                    'Beginner friendly'
                  ],
                  border: false,
                  fontSize: width * .019,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: height * .025),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Rp. $price',
                      style: GoogleFonts.mulish(
                          color: CusColors.title,
                          fontSize: width * .025,
                          fontWeight: FontWeight.bold,
                          height: 1.5),
                    ),
                    discount != ''
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.transparent,
                              border: Border.all(
                                color: const Color(0xFF2501FF),
                                width: 1,
                              ),
                            ),
                            margin: const EdgeInsets.only(left: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 3),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '$discount% Off',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF2501FF),
                                    fontSize: width * .017,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
              _defaultPayment(user, width, height, isBundle, courseType)
            ],
          ),
        ),
      ],
    );
  }
}
