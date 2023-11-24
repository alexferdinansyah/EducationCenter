import "dart:async";

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:get/get.dart";
import "package:google_fonts/google_fonts.dart";
import "package:omni_datetime_picker/omni_datetime_picker.dart";
import "package:project_tc/components/constants.dart";
import "package:project_tc/controllers/learn_course_controller.dart";
import "package:project_tc/models/course.dart";
import "package:project_tc/models/user.dart";
import "package:project_tc/routes/routes.dart";
import "package:project_tc/screens/auth/confirm_email.dart";
import "package:project_tc/screens/auth/login/sign_in_responsive.dart";
import "package:project_tc/services/extension.dart";
import "package:project_tc/services/firestore_service.dart";
import "package:provider/provider.dart";
import "package:responsive_builder/responsive_builder.dart";
import "package:youtube_player_iframe/youtube_player_iframe.dart";

class LearningCourse extends StatefulWidget {
  const LearningCourse({super.key});

  @override
  State<LearningCourse> createState() => _LearningCourseState();
}

class _LearningCourseState extends State<LearningCourse> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  late YoutubePlayerController _controller;
  String id = '';
  bool? offers;
  int selectedContainerIndex = -1;
  List<String> learnCourseTitle = [];
  DateTime today = DateTime.now();
  DateTime? nextMonday;
  DateTime? selectedDate;
  String? noWhatsapp;
  String? note;
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

    nextMonday = today.add(Duration(days: DateTime.monday - today.weekday + 7));

    setState(() {
      isVerify = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (selectedDate != null) {
      dateController.text = selectedDate!.formatDateAndTime();
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

    var parameter = Get.parameters;
    var route = Get.currentRoute;

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
        return Scaffold(
            body: ListView(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Learning Course',
                      style: GoogleFonts.poppins(
                        fontSize: width * .015,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1F384C),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 30),
                      child: Text(
                        'Get more benefits from buying Our plus Courses',
                        style: GoogleFonts.poppins(
                          fontSize: width * .011,
                          fontWeight: FontWeight.w400,
                          color: CusColors.sidebarInactive,
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: width / 5,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      const Color(0xFF14142B).withOpacity(.08),
                                  offset: const Offset(0, 2),
                                  blurRadius: 12)
                            ],
                            color: Colors.white,
                            border: Border.all(
                              color: const Color(0xFFEFF0F6),
                              width: 1,
                            ),
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svg/basic_plan.svg',
                                      height: 60,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Standard',
                                        style: GoogleFonts.poppins(
                                          fontSize: width * .013,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF170F49),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Text(
                                    'Access and learn about the Class for free without certificate',
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      fontSize: width * .01,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFF6F6C90),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 20),
                                  child: Text(
                                    'Rp 0',
                                    style: GoogleFonts.poppins(
                                      fontSize: width * .02,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF170F49),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    "What's included",
                                    style: GoogleFonts.poppins(
                                      fontSize: width * .009,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF170F49),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.check_circle,
                                      color: Color(0xFF4351FF),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Free",
                                      style: GoogleFonts.poppins(
                                        fontSize: width * .009,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF170F49),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.check_circle,
                                      color: Color(0xFF4351FF),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Lifetime courses",
                                      style: GoogleFonts.poppins(
                                        fontSize: width * .009,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF170F49),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.check_circle,
                                      color: Color(0xFF4351FF),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "First three videos free",
                                      style: GoogleFonts.poppins(
                                        fontSize: width * .009,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF170F49),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFdcd8ff),
                                    borderRadius: BorderRadius.circular(64),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (data['isPaid'] == null) {
                                        final firestore =
                                            FirestoreService(uid: user.uid);
                                        await firestore.addMyCourse(
                                            id, user.uid, false);
                                      }
                                      Get.toNamed(routeLearnCourse,
                                          parameters: {'id': id});
                                    },
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
                                    child: Text(
                                      'Start Learning',
                                      style: GoogleFonts.mulish(
                                        fontWeight: FontWeight.w700,
                                        color: CusColors.text,
                                        fontSize: width * 0.01,
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        Container(
                          width: width / 5,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      const Color(0xFF14142B).withOpacity(.08),
                                  offset: const Offset(0, 2),
                                  blurRadius: 12)
                            ],
                            color: Colors.white,
                            border: Border.all(
                              color: const Color(0xFFEFF0F6),
                              width: 1,
                            ),
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svg/pro_plan.svg',
                                      height: 60,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Plus',
                                        style: GoogleFonts.poppins(
                                          fontSize: width * .012,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF170F49),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Text(
                                    'Unlock many benefits that can be obtained in the Class',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      fontSize: width * .01,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFF6F6C90),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 20),
                                  child: Text(
                                    "Rp ${data['price']}",
                                    style: GoogleFonts.poppins(
                                      fontSize: width * .02,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF170F49),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    "What's included",
                                    style: GoogleFonts.poppins(
                                      fontSize: width * .009,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF170F49),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.check_circle,
                                      color: Color(0xFF4351FF),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Unlock all content",
                                      style: GoogleFonts.poppins(
                                        fontSize: width * .009,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF170F49),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.check_circle,
                                      color: Color(0xFF4351FF),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Lifetime courses",
                                      style: GoogleFonts.poppins(
                                        fontSize: width * .009,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF170F49),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.check_circle,
                                      color: Color(0xFF4351FF),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Get certificate class",
                                      style: GoogleFonts.poppins(
                                        fontSize: width * .009,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF170F49),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.check_circle,
                                      color: Color(0xFF4351FF),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Zoom meeting with instructor",
                                      style: GoogleFonts.poppins(
                                        fontSize: width * .009,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF170F49),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF4351FF),
                                    borderRadius: BorderRadius.circular(64),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Get.toNamed(routeBuyCourse,
                                          parameters: {'id': id});
                                    },
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
                                    child: Text(
                                      'Start Learning & benefits',
                                      style: GoogleFonts.mulish(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                        fontSize: width * 0.01,
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ]));
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
                            fontSize: width * .015,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1F384C),
                          ),
                        ),
                        Container(
                          width: width * .09,
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
                              Get.toNamed(routeHome);
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
                                  vertical: height * 0.015,
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
                                fontSize: width * 0.01,
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
            return Scaffold(
              body: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: width * .03, vertical: height * .015),
                color: CusColors.bg,
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: ListView(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(routeHome);
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
                            'Learning ${data["course_name"]}',
                            style: GoogleFonts.poppins(
                              fontSize: width * .015,
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
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
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
                            behavior: ScrollConfiguration.of(context)
                                .copyWith(scrollbars: false),
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              children:
                                  List.generate(learnCourse.length, (index) {
                                if (data['isPaid'] == true) {
                                  return GestureDetector(
                                    onTap: () {
                                      // Handle the item selection and update the selected index
                                      setState(() {
                                        selectedContainerIndex = index;
                                        _controller.loadVideoById(
                                            videoId: learnCourse[
                                                    selectedContainerIndex]
                                                .videoUrl!);
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      decoration:
                                          selectedContainerIndex != index
                                              ? BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.black
                                                        .withOpacity(.2),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white)
                                              : BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.black
                                                        .withOpacity(.2),
                                                  ),
                                                  color: CusColors.accentBlue,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                      child: Text(
                                        learnCourseTitle[index],
                                        style: GoogleFonts.poppins(
                                            color: Colors.black),
                                      ),
                                    ),
                                  );
                                } else if (data['isPaid'] == false &&
                                    data['user_membership']['type'] == 'Pro' &&
                                    index <
                                        (num.parse(data['limit_course']) + 2)) {
                                  return GestureDetector(
                                    onTap: () {
                                      // Handle the item selection and update the selected index
                                      setState(() {
                                        selectedContainerIndex = index;
                                        _controller.loadVideoById(
                                            videoId: learnCourse[
                                                    selectedContainerIndex]
                                                .videoUrl!);
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      decoration:
                                          selectedContainerIndex != index
                                              ? BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.black
                                                        .withOpacity(.2),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white)
                                              : BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.black
                                                        .withOpacity(.2),
                                                  ),
                                                  color: CusColors.accentBlue,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                      child: Text(
                                        learnCourseTitle[index],
                                        style: GoogleFonts.poppins(
                                            color: Colors.black),
                                      ),
                                    ),
                                  );
                                } else if (index <
                                    num.parse(data['limit_course'])) {
                                  return GestureDetector(
                                    onTap: () {
                                      // Handle the item selection and update the selected index
                                      setState(() {
                                        selectedContainerIndex = index;
                                        _controller.loadVideoById(
                                            videoId: learnCourse[
                                                    selectedContainerIndex]
                                                .videoUrl!);
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      decoration:
                                          selectedContainerIndex != index
                                              ? BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.black
                                                        .withOpacity(.2),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white)
                                              : BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.black
                                                        .withOpacity(.2),
                                                  ),
                                                  color: CusColors.accentBlue,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                      child: Text(
                                        learnCourseTitle[index],
                                        style: GoogleFonts.poppins(
                                            color: Colors.black),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Tooltip(
                                    message:
                                        'Content is lock, please buy this course to unlock',
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black.withOpacity(.2),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.black26),
                                      child: Text(
                                        learnCourseTitle[index],
                                        style: GoogleFonts.poppins(
                                            color: Colors.white),
                                      ),
                                    ),
                                  );
                                }
                              }),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: width / 1.4,
                          height: height / 1.5,
                          margin: const EdgeInsets.only(right: 20, top: 20),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
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
                    if (data['isPaid'] == true)
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 30),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            color: CusColors.bgSideBar,
                            borderRadius: BorderRadius.circular(10)),
                        child: Form(
                          key: _formKey,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Form for request zoom meeting to instructor',
                                      style: GoogleFonts.poppins(
                                        fontSize: width * .011,
                                        fontWeight: FontWeight.w600,
                                        color: CusColors.title,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  'No Whatsapp',
                                  style: GoogleFonts.poppins(
                                    fontSize: width * .009,
                                    fontWeight: FontWeight.w600,
                                    color: CusColors.subHeader.withOpacity(0.5),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.phone,
                                  initialValue: data['no_whatsapp'],
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^[0-9\-\+\s()]*$')),
                                  ],
                                  style: GoogleFonts.poppins(
                                      fontSize: width * .009,
                                      fontWeight: FontWeight.w500,
                                      color: CusColors.subHeader),
                                  onChanged: (value) {
                                    noWhatsapp = value;
                                  },
                                  decoration: editProfileDecoration.copyWith(
                                    hintText: 'No Whatsapp',
                                    hintStyle: GoogleFonts.poppins(
                                      fontSize: width * .009,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          CusColors.subHeader.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'Date and Time',
                                  style: GoogleFonts.poppins(
                                    fontSize: width * .009,
                                    fontWeight: FontWeight.w600,
                                    color: CusColors.subHeader.withOpacity(0.5),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: GestureDetector(
                                    onTap: () async {
                                      selectedDate =
                                          await showOmniDateTimePicker(
                                        context: context,
                                        initialDate: nextMonday,
                                        firstDate: nextMonday,
                                        lastDate: DateTime.now().add(
                                          const Duration(days: 3652),
                                        ),
                                        is24HourMode: false,
                                        isShowSeconds: false,
                                        minutesInterval: 1,
                                        secondsInterval: 1,
                                        isForce2Digits: true,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(16)),
                                        constraints: const BoxConstraints(
                                          maxWidth: 350,
                                          maxHeight: 650,
                                        ),
                                        transitionBuilder:
                                            (context, anim1, anim2, child) {
                                          return FadeTransition(
                                            opacity: anim1.drive(
                                              Tween(
                                                begin: 0,
                                                end: 1,
                                              ),
                                            ),
                                            child: child,
                                          );
                                        },
                                        transitionDuration:
                                            const Duration(milliseconds: 200),
                                        barrierDismissible: true,
                                        selectableDayPredicate: (dateTime) {
                                          return dateTime.weekday !=
                                                  DateTime.saturday &&
                                              dateTime.weekday !=
                                                  DateTime.sunday;
                                        },
                                      ).then((value) {
                                        setState(() {
                                          selectedDate = value;
                                          dateController.text = selectedDate
                                                  ?.formatDateAndTime() ??
                                              '';
                                        });
                                        return value;
                                      });
                                    },
                                    child: TextFormField(
                                      enabled: false,
                                      controller: dateController,
                                      keyboardType: TextInputType.text,
                                      style: GoogleFonts.poppins(
                                          fontSize: width * .009,
                                          fontWeight: FontWeight.w500,
                                          color: CusColors.subHeader),
                                      decoration:
                                          editProfileDecoration.copyWith(
                                        hintText: 'Select date',
                                        hintStyle: GoogleFonts.poppins(
                                          fontSize: width * .009,
                                          fontWeight: FontWeight.w500,
                                          color: CusColors.subHeader
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  'Note',
                                  style: GoogleFonts.poppins(
                                    fontSize: width * .009,
                                    fontWeight: FontWeight.w600,
                                    color: CusColors.subHeader.withOpacity(0.5),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.text,
                                  style: GoogleFonts.poppins(
                                      fontSize: width * .009,
                                      fontWeight: FontWeight.w500,
                                      color: CusColors.subHeader),
                                  onChanged: (value) {
                                    note = value;
                                  },
                                  decoration: editProfileDecoration.copyWith(
                                    hintText: 'Note (Opsional)',
                                    hintStyle: GoogleFonts.poppins(
                                      fontSize: width * .009,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          CusColors.subHeader.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Container(
                                    width: width * .09,
                                    decoration: BoxDecoration(
                                        color: CusColors.accentBlue,
                                        borderRadius: BorderRadius.circular(80),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(.25),
                                              spreadRadius: 0,
                                              blurRadius: 20,
                                              offset: const Offset(0, 4))
                                        ]),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        final firestoreService =
                                            FirestoreService(uid: user.uid);
                                        final scheduleData = MeetModel(
                                            noWhatsapp: noWhatsapp,
                                            uid: user.uid,
                                            courseId: id,
                                            dateAndTime: selectedDate,
                                            note: note ?? '');
                                        await firestoreService
                                            .addMeetRequest(
                                                scheduleData, id, user.uid)
                                            .then((value) async {
                                          if (value == true) {
                                            await firestoreService.openWhatsapp(
                                                selectedDate!,
                                                note ?? '',
                                                data['course_name']);
                                          } else {
                                            Get.snackbar('Cannot make schedule',
                                                'Already make schedule 5 times');
                                          }
                                        });
                                      },
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
                                            vertical: height * 0.015,
                                          ),
                                        ),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.transparent),
                                        shadowColor: MaterialStateProperty.all(
                                            Colors.transparent),
                                      ),
                                      child: Text(
                                        'Confirm',
                                        style: GoogleFonts.mulish(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                          fontSize: width * 0.01,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ]),
                        ),
                      ),
                  ]),
                ),
              ),
            );
          });
    });
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
