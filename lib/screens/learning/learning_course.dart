import "dart:async";

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_slider_drawer/flutter_slider_drawer.dart";
import "package:get/get.dart";
import "package:google_fonts/google_fonts.dart";
import "package:project_tc/components/constants.dart";
import "package:project_tc/controllers/learn_course_controller.dart";
import "package:project_tc/models/course.dart";
import "package:project_tc/models/user.dart";
import "package:project_tc/routes/routes.dart";
import "package:project_tc/screens/auth/confirm_email.dart";
import "package:project_tc/screens/auth/login/sign_in_responsive.dart";
import "package:project_tc/screens/learning/course_offer.dart";
import "package:project_tc/screens/learning/form_zoom_meet.dart";
import "package:provider/provider.dart";
import "package:responsive_builder/responsive_builder.dart";
import "package:youtube_player_iframe/youtube_player_iframe.dart";

class LearningCourse extends StatefulWidget {
  const LearningCourse({super.key});

  @override
  State<LearningCourse> createState() => _LearningCourseState();
}

class _LearningCourseState extends State<LearningCourse> {
  late YoutubePlayerController _controller;
  final GlobalKey<SliderDrawerState> _sliderDrawerKey =
      GlobalKey<SliderDrawerState>();
  String id = '';
  int selectedContainerIndex = -1;
  List<String> learnCourseTitle = [];

  bool? isVerify;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
          strictRelatedVideos: true,
          showControls: true,
          mute: false,
          showFullscreenButton: true,
          loop: false,
          captionLanguage: 'id'),
    );

    if (FirebaseAuth.instance.currentUser != null) {
      setState(() {
        isVerify = FirebaseAuth.instance.currentUser!.emailVerified;
      });
    }
  }

  final LearnCourseController controller = Get.put(LearnCourseController());
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    checkEmailVerified() async {
      await FirebaseAuth.instance.currentUser?.reload();

      setState(() {
        isVerify = FirebaseAuth.instance.currentUser!.emailVerified;
      });

      if (isVerify!) {
        timer?.cancel();
      }
    }

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    var parameter = Get.rootDelegate.parameters;
    var route = Get.rootDelegate.currentConfiguration!.location!;

    id = parameter['id']!;
    if (user == null) {
      return const ResponsiveSignIn();
    }
    if (isVerify == false) {
      timer = Timer(const Duration(seconds: 2), () => checkEmailVerified());
      return const ConfirmEmail();
    }
    controller.fetchDocument(id, user.uid);
    return Obx(() {
      final data = controller.documentSnapshot.value;

      if (data == null) {
        return Center(
            child: Text(
          'Loading...',
          style: GoogleFonts.poppins(
              fontSize: 20,
              color: Colors.black,
              decoration: TextDecoration.none),
        ));
      }
      final List<LearnCourse> learnCourse = data['learn_course'].toList();

      learnCourseTitle = List.from(learnCourse.map((learn) => learn.title));

      // Data has been fetched successfully
      if (route.contains('/learn-course/offers')) {
        return CourseOffer(
          price: data['price'],
          isPaid: data['isPaid'],
          id: id,
        );
      }
      if (data['isPaid'] == null) {
        return Scaffold(
          body: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'You Dont Have This Course, please go back',
                          style: GoogleFonts.poppins(
                            fontSize: getValueForScreenType<double>(
                              context: context,
                              mobile: width * .022,
                              tablet: width * .02,
                              desktop: width * .015,
                            ),
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1F384C),
                          ),
                        ),
                        Container(
                          height: getValueForScreenType<double>(
                            context: context,
                            mobile: 26,
                            tablet: 33,
                            desktop: 40,
                          ),
                          margin: const EdgeInsets.only(top: 20),
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
                            onPressed: () {
                              Get.rootDelegate.toNamed(routeHome);
                            },
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
                                  horizontal: width * .015,
                                ),
                              ),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              shadowColor:
                                  MaterialStateProperty.all(Colors.transparent),
                            ),
                            child: Text(
                              'Back',
                              style: GoogleFonts.mulish(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: getValueForScreenType<double>(
                                  context: context,
                                  mobile: width * .019,
                                  tablet: width * .016,
                                  desktop: width * .011,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }
      return YoutubePlayerScaffold(
          controller: _controller,
          builder: (context, player) {
            return ResponsiveBuilder(builder: (context, sizingInformation) {
              // Check the sizing information here and return your UI
              if (sizingInformation.deviceScreenType ==
                  DeviceScreenType.desktop) {
                return Scaffold(
                  body: _defaultLayout(
                    width,
                    height,
                    player,
                    false,
                    learnCourse: learnCourse,
                    isPaid: data['isPaid'],
                    memberType: data['user_membership']['type'],
                    limitCourse: data['limit_course'],
                    courseName: data["course_name"],
                    noWhatsapp: data['no_whatsapp'],
                  ),
                );
              }
              if (sizingInformation.deviceScreenType ==
                  DeviceScreenType.tablet) {
                return Scaffold(
                  body: _defaultLayout(
                    width,
                    height,
                    player,
                    false,
                    learnCourse: learnCourse,
                    isPaid: data['isPaid'],
                    memberType: data['user_membership']['type'],
                    limitCourse: data['limit_course'],
                    courseName: data['course_name'],
                    noWhatsapp: data['no_whatsapp'],
                  ),
                );
              }
              if (sizingInformation.deviceScreenType ==
                  DeviceScreenType.mobile) {
                return Scaffold(
                  body: SliderDrawer(
                    appBar: SliderAppBar(
                        appBarColor: Colors.white,
                        title: Text(
                          data['course_name'],
                          style: GoogleFonts.poppins(
                            fontSize: getValueForScreenType<double>(
                              context: context,
                              mobile: width * .023,
                              tablet: width * .02,
                              desktop: width * .015,
                            ),
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1F384C),
                          ),
                        )),
                    key: _sliderDrawerKey,
                    sliderOpenSize: 200,
                    slider: _sideMenuMobile(
                      width,
                      height,
                      onTap: (index) {
                        _sliderDrawerKey.currentState!.closeSlider();

                        // Handle the item selection and update the selected index
                        setState(() {
                          selectedContainerIndex = index;
                          _controller.loadVideoById(
                              videoId: learnCourse[selectedContainerIndex]
                                  .videoUrl!);
                        });
                      },

                      learnCourse: learnCourse,
                      isPaid: data['isPaid'],
                      memberType: data['user_membership']['type'],
                      limitCourse: data['limit_course'],
                      // onItemClick: (title) {
                      //   _sliderDrawerKey.currentState!.closeSlider();
                      //   setState(() {
                      //     this.title = title;
                      //   });
                      // },
                    ),
                    child: _defaultLayout(
                      width,
                      height,
                      player,
                      true,
                      learnCourse: learnCourse,
                      courseName: data["course_name"],
                      noWhatsapp: data['no_whatsapp'],
                      isPaid: data['isPaid'],
                    ),
                  ),
                );
              }
              return Container();
            });
          });
    });
  }

  Widget _defaultLayout(width, height, player, bool isMobile,
      {List<LearnCourse>? learnCourse,
      bool? isPaid,
      String? memberType,
      String? limitCourse,
      String? courseName,
      String? noWhatsapp}) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: width * .03, vertical: height * .015),
      color: CusColors.bg,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView(children: [
          if (isMobile == false) _navBarDesktop(width, courseName),
          if (isMobile == false)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sideMenuDesktop(
                  width,
                  height,
                  learnCourse: learnCourse,
                  isPaid: isPaid,
                  memberType: memberType,
                  limitCourse: limitCourse,
                ),
                const Spacer(),
                Container(
                  width: width / 1.4,
                  height: height / 1.5,
                  margin: const EdgeInsets.only(right: 20, top: 20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    color: CusColors.bgSideBar,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: selectedContainerIndex == -1
                        ? const Text(
                            "No Part Selected",
                            style: TextStyle(fontSize: 18),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                                width: width / 1.3,
                                height: height / 1.5,
                                child: player),
                          ),
                  ),
                ),
              ],
            ),
          if (isMobile == true)
            Container(
              width: double.infinity,
              height: height / 2.3,
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                color: CusColors.bgSideBar,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: selectedContainerIndex == -1
                    ? Text(
                        "No Part Selected",
                        style: GoogleFonts.poppins(
                          fontSize: getValueForScreenType<double>(
                            context: context,
                            mobile: width * .023,
                            tablet: width * .02,
                            desktop: width * .015,
                          ),
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1F384C),
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                            width: double.infinity,
                            height: height / 2.3,
                            child: player),
                      ),
              ),
            ),
          if (isPaid == true)
            FormZoomMeeting(
              noWhatsapp: noWhatsapp!,
              id: id,
              courseName: courseName!,
            )
        ]),
      ),
    );
  }

  Widget _navBarDesktop(width, courseName) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              Get.rootDelegate.toNamed(routeHome);
            },
            child: Image.asset(
              'assets/images/dec_logo2.png',
              width: getValueForScreenType<double>(
                context: context,
                mobile: width * .1,
                tablet: width * .08,
                desktop: width * .06,
              ),
            ),
          ),
          const Spacer(),
          Text(
            'Learning $courseName',
            style: GoogleFonts.poppins(
              fontSize: getValueForScreenType<double>(
                context: context,
                mobile: width * .023,
                tablet: width * .02,
                desktop: width * .015,
              ),
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1F384C),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: getValueForScreenType<double>(
              context: context,
              mobile: width * .1,
              tablet: width * .08,
              desktop: width * .06,
            ),
          )
        ],
      ),
    );
  }

  Widget _sideMenuMobile(width, height,
      {Function(int index)? onTap,
      List<LearnCourse>? learnCourse,
      bool? isPaid,
      String? memberType,
      String? limitCourse}) {
    return Container(
      width: width * .17,
      height: height / 1.2,
      margin: const EdgeInsets.only(left: 20, top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(10),
          color: CusColors.bgSideBar),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView(physics: const BouncingScrollPhysics(), children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 30),
            child: GestureDetector(
              onTap: () {
                Get.rootDelegate.toNamed(routeHome);
              },
              child: Image.asset(
                'assets/images/dec_logo2.png',
                height: 40,
              ),
            ),
          ),
          Column(
            children: List.generate(learnCourse!.length, (index) {
              if (isPaid == true) {
                return GestureDetector(
                  onTap: () {
                    onTap!(index);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: selectedContainerIndex != index
                        ? BoxDecoration(
                            border: Border.all(
                              color: Colors.black.withOpacity(.2),
                            ),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white)
                        : BoxDecoration(
                            border: Border.all(
                              color: Colors.black.withOpacity(.2),
                            ),
                            color: CusColors.accentBlue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                    child: Text(
                      learnCourseTitle[index],
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: getValueForScreenType<double>(
                          context: context,
                          mobile: width * .018,
                          tablet: width * .015,
                          desktop: width * .01,
                        ),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                );
              } else if (isPaid == false &&
                  memberType == 'Pro' &&
                  index < (num.parse(limitCourse!) + 2)) {
                return GestureDetector(
                  onTap: () {
                    onTap!(index);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: selectedContainerIndex != index
                        ? BoxDecoration(
                            border: Border.all(
                              color: Colors.black.withOpacity(.2),
                            ),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white)
                        : BoxDecoration(
                            border: Border.all(
                              color: Colors.black.withOpacity(.2),
                            ),
                            color: CusColors.accentBlue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                    child: Text(
                      learnCourseTitle[index],
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: getValueForScreenType<double>(
                          context: context,
                          mobile: width * .018,
                          tablet: width * .015,
                          desktop: width * .01,
                        ),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                );
              } else if (index < num.parse(limitCourse!)) {
                return GestureDetector(
                  onTap: () {
                    onTap!(index);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: selectedContainerIndex != index
                        ? BoxDecoration(
                            border: Border.all(
                              color: Colors.black.withOpacity(.2),
                            ),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white)
                        : BoxDecoration(
                            border: Border.all(
                              color: Colors.black.withOpacity(.2),
                            ),
                            color: CusColors.accentBlue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                    child: Text(
                      learnCourseTitle[index],
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: getValueForScreenType<double>(
                          context: context,
                          mobile: width * .018,
                          tablet: width * .015,
                          desktop: width * .01,
                        ),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                );
              } else {
                return Tooltip(
                  message: 'Content is lock, please buy this course to unlock',
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black.withOpacity(.2),
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black26),
                    child: Text(
                      learnCourseTitle[index],
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: getValueForScreenType<double>(
                          context: context,
                          mobile: width * .018,
                          tablet: width * .015,
                          desktop: width * .01,
                        ),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                );
              }
            }),
          )
        ]),
      ),
    );
  }

  Widget _sideMenuDesktop(width, height,
      {List<LearnCourse>? learnCourse,
      bool? isPaid,
      String? memberType,
      String? limitCourse}) {
    return Container(
      width: width * .17,
      height: height / 1.5,
      margin: const EdgeInsets.only(left: 20, top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(10),
          color: CusColors.bgSideBar),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: List.generate(learnCourse!.length, (index) {
            if (isPaid == true) {
              return GestureDetector(
                onTap: () {
                  // Handle the item selection and update the selected index
                  setState(() {
                    selectedContainerIndex = index;
                    _controller.loadVideoById(
                        videoId: learnCourse[selectedContainerIndex].videoUrl!);
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: selectedContainerIndex != index
                      ? BoxDecoration(
                          border: Border.all(
                            color: Colors.black.withOpacity(.2),
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white)
                      : BoxDecoration(
                          border: Border.all(
                            color: Colors.black.withOpacity(.2),
                          ),
                          color: CusColors.accentBlue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                  child: Text(
                    learnCourseTitle[index],
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .018,
                        tablet: width * .015,
                        desktop: width * .01,
                      ),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              );
            } else if (isPaid == false &&
                memberType == 'Pro' &&
                index < (num.parse(limitCourse!) + 2)) {
              return GestureDetector(
                onTap: () {
                  // Handle the item selection and update the selected index
                  setState(() {
                    selectedContainerIndex = index;
                    _controller.loadVideoById(
                        videoId: learnCourse[selectedContainerIndex].videoUrl!);
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: selectedContainerIndex != index
                      ? BoxDecoration(
                          border: Border.all(
                            color: Colors.black.withOpacity(.2),
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white)
                      : BoxDecoration(
                          border: Border.all(
                            color: Colors.black.withOpacity(.2),
                          ),
                          color: CusColors.accentBlue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                  child: Text(
                    learnCourseTitle[index],
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .018,
                        tablet: width * .015,
                        desktop: width * .01,
                      ),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              );
            } else if (index < num.parse(limitCourse!)) {
              return GestureDetector(
                onTap: () {
                  // Handle the item selection and update the selected index
                  setState(() {
                    selectedContainerIndex = index;
                    _controller.loadVideoById(
                        videoId: learnCourse[selectedContainerIndex].videoUrl!);
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: selectedContainerIndex != index
                      ? BoxDecoration(
                          border: Border.all(
                            color: Colors.black.withOpacity(.2),
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white)
                      : BoxDecoration(
                          border: Border.all(
                            color: Colors.black.withOpacity(.2),
                          ),
                          color: CusColors.accentBlue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                  child: Text(
                    learnCourseTitle[index],
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .018,
                        tablet: width * .015,
                        desktop: width * .01,
                      ),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              );
            } else {
              return Tooltip(
                message: 'Content is lock, please buy this course to unlock',
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black.withOpacity(.2),
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black26),
                  child: Text(
                    learnCourseTitle[index],
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .018,
                        tablet: width * .015,
                        desktop: width * .01,
                      ),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              );
            }
          }),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
