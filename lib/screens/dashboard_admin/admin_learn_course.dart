import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/models/course.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/routes/routes.dart';
import 'package:project_tc/screens/auth/login/sign_in_responsive.dart';
import 'package:project_tc/services/firestore_service.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class AdminLearnCourse extends StatefulWidget {
  const AdminLearnCourse({super.key});

  @override
  State<AdminLearnCourse> createState() => _AdminLearnCourseState();
}

class _AdminLearnCourseState extends State<AdminLearnCourse> {
  late YoutubePlayerController _controller;

  String id = '';
  int selectedContainerIndex = -1;
  List<Map> learnCourse = [];
  List<String> learnCourseTitle = [];

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
        captionLanguage: 'id',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    var parameter = Get.rootDelegate.parameters;
    id = parameter['id']!;

    void itemSelected(index) {
      Future.delayed(const Duration(seconds: 1));
      setState(() {
        selectedContainerIndex = index;
        if (learnCourse.isNotEmpty && learnCourse.length > index) {
          _controller.loadVideoById(
              videoId: learnCourse[selectedContainerIndex]['learn_course']
                  .videoUrl!);
        }
      });
    }

    if (user == null) {
      return const ResponsiveSignIn();
    }

    return StreamBuilder<List<Map>?>(
        stream: FirestoreService(uid: user.uid, courseId: id).allLearnCourse,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<Map?> dataMaps = snapshot.data!;
            final dataLearnCourse = dataMaps
                .where((element) => element!['course_name'] == null)
                .map((data) {
              return {
                'id': data!['id'],
                'learn_course': data['learn_course'] as LearnCourse,
              };
            }).toList();

            learnCourse = List.from(dataLearnCourse);
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
                                    Get.rootDelegate.offNamed(routeHome);
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
                                  'Learning ${dataMaps[0]!["course_name"]}',
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
                                ),
                              ],
                            ),
                          ),
                          AdminLearnCourseForm(
                            learnCourse: learnCourse,
                            selectedContainerIndex: selectedContainerIndex,
                            onItemSelected: itemSelected,
                            player: player,
                            uid: user.uid,
                            courseId: id,
                          )
                        ]),
                      ),
                    ),
                  );
                });
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No learn course available.'),
            );
          } else {
            return const Center(
              child: Text('kok iso.'),
            );
          }
        });
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}

class AdminLearnCourseForm extends StatefulWidget {
  final String uid;
  final String courseId;
  final int selectedContainerIndex;
  final List<Map> learnCourse;
  final Function(int) onItemSelected;
  final Widget player;
  const AdminLearnCourseForm({
    super.key,
    required this.learnCourse,
    required this.selectedContainerIndex,
    required this.onItemSelected,
    required this.player,
    required this.uid,
    required this.courseId,
  });

  @override
  State<AdminLearnCourseForm> createState() => _AdminLearnCourseFormState();
}

class _AdminLearnCourseFormState extends State<AdminLearnCourseForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Form(
      key: _formKey,
      child: Row(
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
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: widget.learnCourse.isEmpty
                    ? [
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black.withOpacity(.2),
                              ),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              hintText: 'Title',
                              hintStyle: GoogleFonts.inter(
                                color: CusColors.inactive,
                                fontSize: getValueForScreenType<double>(
                                  context: context,
                                  mobile: width * .017,
                                  tablet: width * .014,
                                  desktop: width * .009,
                                ),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            onChanged: (value) async {
                              FirestoreService firestore =
                                  FirestoreService(uid: widget.uid);

                              await firestore.addLearnCourse(
                                  courseId: widget.courseId,
                                  data: LearnCourse(
                                      title: value,
                                      videoUrl: '',
                                      createdAt: DateTime.now()));
                            },
                          ),
                        ),
                      ]
                    : List.generate(widget.learnCourse.length, (index) {
                        return Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black.withOpacity(.2),
                              ),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: TextFormField(
                            onTap: () {
                              widget.onItemSelected(index);
                            },
                            key: ValueKey(widget.learnCourse[index]['id']),
                            initialValue:
                                widget.learnCourse[index]['learn_course'].title,
                            textAlign: TextAlign.center,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              hintText: 'Input Title',
                              hintStyle: GoogleFonts.inter(
                                color: CusColors.inactive,
                                fontSize: getValueForScreenType<double>(
                                  context: context,
                                  mobile: width * .017,
                                  tablet: width * .014,
                                  desktop: width * .009,
                                ),
                                fontWeight: FontWeight.normal,
                              ),
                              suffixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                      onTap: () async {
                                        FirestoreService firestore =
                                            FirestoreService(uid: widget.uid);
                                        await firestore.addLearnCourse(
                                          courseId: widget.courseId,
                                          data: LearnCourse(
                                            title: '',
                                            videoUrl: '',
                                            createdAt: DateTime.now(),
                                          ),
                                        );
                                        setState(() {});
                                      },
                                      child: const Icon(IconlyLight.plus)),
                                  GestureDetector(
                                      onTap: () async {
                                        FirestoreService firestore =
                                            FirestoreService(uid: widget.uid);
                                        await firestore.updateLearnCourse(
                                          isUpdating: false,
                                          courseId: widget.courseId,
                                          learnCourseId:
                                              widget.learnCourse[index]['id'],
                                        );
                                        setState(() {});
                                      },
                                      child: const Icon(IconlyLight.delete)),
                                ],
                              ),
                            ),
                            onChanged: (value) {
                              FirestoreService firestore =
                                  FirestoreService(uid: widget.uid);
                              firestore.updateLearnCourse(
                                isUpdating: true,
                                courseId: widget.courseId,
                                learnCourseId: widget.learnCourse[index]['id'],
                                fieldName: 'title',
                                data: value,
                              );
                            },
                          ),
                        );
                      }),
              ),
            ),
          ),
          const Spacer(),
          Container(
            width: width / 1.4,
            margin: const EdgeInsets.only(right: 20, top: 20),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              color: CusColors.bgSideBar,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: widget.selectedContainerIndex == -1
                  ? const Text(
                      "No Part Selected",
                      style: TextStyle(fontSize: 18),
                    )
                  : widget
                              .learnCourse[widget.selectedContainerIndex]
                                  ['learn_course']
                              .videoUrl ==
                          ''
                      ? TextFormField(
                          textAlign: TextAlign.center,
                          decoration: editProfileDecoration.copyWith(
                            hintText: 'Input video youtube id',
                            hintStyle: GoogleFonts.inter(
                              color: CusColors.inactive,
                              fontSize: getValueForScreenType<double>(
                                context: context,
                                mobile: width * .017,
                                tablet: width * .014,
                                desktop: width * .009,
                              ),
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          onChanged: (value) async {
                            FirestoreService firestore =
                                FirestoreService(uid: widget.uid);
                            firestore.updateLearnCourse(
                              isUpdating: true,
                              courseId: widget.courseId,
                              learnCourseId: widget.learnCourse[
                                  widget.selectedContainerIndex]['id'],
                              fieldName: 'video_url',
                              data: value,
                            );
                          },
                        )
                      : Column(
                          children: [
                            TextFormField(
                              initialValue: widget
                                  .learnCourse[widget.selectedContainerIndex]
                                      ['learn_course']
                                  .videoUrl,
                              textAlign: TextAlign.center,
                              decoration: editProfileDecoration.copyWith(
                                hintText: 'Input video youtube id',
                                hintStyle: GoogleFonts.inter(
                                  color: CusColors.inactive,
                                  fontSize: getValueForScreenType<double>(
                                    context: context,
                                    mobile: width * .017,
                                    tablet: width * .014,
                                    desktop: width * .009,
                                  ),
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              onChanged: (value) async {
                                FirestoreService firestore =
                                    FirestoreService(uid: widget.uid);
                                firestore.updateLearnCourse(
                                  isUpdating: true,
                                  courseId: widget.courseId,
                                  learnCourseId: widget.learnCourse[
                                      widget.selectedContainerIndex]['id'],
                                  fieldName: 'video_url',
                                  data: value,
                                );
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: SizedBox(
                                  width: width / 1.3,
                                  height: height / 1.5,
                                  child: widget.player),
                            ),
                          ],
                        ),
            ),
          ),
        ],
      ),
    );
  }
}
