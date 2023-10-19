import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:project_tc/controllers/learn_course_controller.dart";
import "package:project_tc/models/course.dart";
import "package:project_tc/models/user.dart";
import "package:provider/provider.dart";
import "package:youtube_player_iframe/youtube_player_iframe.dart";

class LearningCourse extends StatefulWidget {
  const LearningCourse({super.key});

  @override
  State<LearningCourse> createState() => _LearningCourseState();
}

class _LearningCourseState extends State<LearningCourse> {
  late YoutubePlayerController _controller;
  String id = '';
  int selectedContainerIndex = -1;
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
        return const Center(child: Text('Loading...'));
      }
      final List<LearnCourse> learnCourse = data['learn_course'].toList();

      learnCourseTitle = List.from(learnCourse.map((learn) => learn.title));

      return YoutubePlayerScaffold(
          controller: _controller,
          builder: (context, player) {
            return Scaffold(
              body: Column(children: [
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
                )
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
