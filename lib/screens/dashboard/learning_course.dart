import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:get/get.dart";
import "package:google_fonts/google_fonts.dart";
import "package:omni_datetime_picker/omni_datetime_picker.dart";
import "package:project_tc/components/constants.dart";
import "package:project_tc/controllers/learn_course_controller.dart";
import "package:project_tc/models/course.dart";
import "package:project_tc/models/user.dart";
import "package:project_tc/services/extension.dart";
import "package:project_tc/services/firestore_service.dart";
import "package:provider/provider.dart";
import "package:youtube_player_iframe/youtube_player_iframe.dart";

class LearningCourse extends StatefulWidget {
  const LearningCourse({super.key});

  @override
  State<LearningCourse> createState() => _LearningCourseState();
}

class _LearningCourseState extends State<LearningCourse> {
  final _formKey = GlobalKey<FormState>();
  late YoutubePlayerController _controller;
  String id = '';
  int selectedContainerIndex = -1;
  List<String> learnCourseTitle = [];
  DateTime minDate = DateTime.now().add(const Duration(days: 1));
  DateTime? selectedDate;
  String? noWhatsapp;
  String? note;

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
      ),
    );
  }

  final LearnCourseController controller = Get.put(LearnCourseController());
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context, listen: false);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    var argument = Get.parameters;
    id = argument['id']!;
    controller.fetchDocument(id);
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

      return YoutubePlayerScaffold(
          controller: _controller,
          builder: (context, player) {
            return Scaffold(
              body: ListView(children: [
                Row(
                  children: [
                    Container(
                      width: width / 4,
                      height: height - 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      child: Column(
                        children: List.generate(learnCourse.length, (index) {
                          if (index < num.parse(data['limit_course'])) {
                            return GestureDetector(
                              onTap: () {
                                // Handle the item selection and update the selected index
                                setState(() {
                                  selectedContainerIndex = index;
                                  _controller.loadVideoById(
                                      videoId:
                                          learnCourse[selectedContainerIndex]
                                              .videoUrl!);
                                });
                              },
                              child: Container(
                                color: selectedContainerIndex == index
                                    ? Colors
                                        .blue // Change the color or style for the selected item
                                    : Colors.white,
                                child: Text(learnCourseTitle[index]),
                              ),
                            );
                          } else {
                            return Container(
                              color: Colors.grey, // Disable non-clickable items
                              child: Text(learnCourseTitle[index]),
                            );
                          }
                        }),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: width / 2,
                      height: height - 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      child: Center(
                        child: selectedContainerIndex == -1
                            ? const Text(
                                "No Part Selected",
                                style: TextStyle(fontSize: 18),
                              )
                            : player,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                color: CusColors.subHeader.withOpacity(0.5),
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
                          selectedDate == null
                              ? Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        selectedDate =
                                            await showOmniDateTimePicker(
                                          context: context,
                                          initialDate: minDate,
                                          firstDate: minDate,
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
                                            // Disable 25th Feb 2023
                                            if (dateTime ==
                                                DateTime(2023, 2, 25)) {
                                              return false;
                                            } else {
                                              return true;
                                            }
                                          },
                                        ).then((value) {
                                          setState(() {});
                                          return value;
                                        });
                                      },
                                      child: const Text('Select Date')),
                                )
                              : Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    children: [
                                      Text(selectedDate!.formatDateAndTime())
                                    ],
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
                                color: CusColors.subHeader.withOpacity(0.5),
                              ),
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                final firestoreService =
                                    FirestoreService(uid: user!.uid);
                                final scheduleData = MeetModel(
                                    noWhatsapp: noWhatsapp,
                                    uid: user.uid,
                                    courseId: id,
                                    dateAndTime: selectedDate,
                                    note: note ?? '');
                                await firestoreService
                                    .addMeetRequest(scheduleData, id, user.uid)
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
                              child: const Text('Confirm'))
                        ]),
                  ),
                ),
              ]),
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
