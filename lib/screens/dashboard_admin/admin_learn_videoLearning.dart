import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/models/learning.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/routes/routes.dart';
import 'package:project_tc/screens/auth/login/sign_in_responsive.dart';
import 'package:project_tc/services/firestore_service.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class AdminLearnVideolearning extends StatefulWidget {
  const AdminLearnVideolearning({super.key});

  @override
  State<AdminLearnVideolearning> createState() =>
      _AdminLearnVideolearningState();
}

class _AdminLearnVideolearningState extends State<AdminLearnVideolearning> {
  late YoutubePlayerController _controller;

  String id = '';
  int selectedContainerIndex = -1;
  List<Map> learnVideo = [];
  List<String> learnVideoTitle = [];

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
        if (learnVideo.isNotEmpty && learnVideo.length > index) {
          _controller.loadVideoById(
              videoId: learnVideo[selectedContainerIndex]['learn_videoLearning']
                  .videoUrl!);
        }
      });
    }

    if (user == null) {
      return const ResponsiveSignIn();
    }

    return StreamBuilder<List<Map>?>(
        stream:
            FirestoreService(uid: user.uid, videoLearningId: id).allLearnVideo,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<Map?> dataMaps = snapshot.data!;
            final dataLearnVideo = dataMaps
                .where((element) => element!['videoLearning_name'] == null)
                .map((data) {
              return {
                'id': data!['id'],
                'learn_videoLearning':
                    data['learn_videoLearning'] as LearnVideo,
              };
            }).toList();

            learnVideo = List.from(dataLearnVideo);
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
                                    Get.rootDelegate.offAndToNamed(routeHome);
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
                                  'Learning ${dataMaps[0]!["videoLearning_name"]}',
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
                          AdminLearnVideolearningForm(
                            learnVideo: learnVideo,
                            selectedContainerIndex: selectedContainerIndex,
                            onItemSelected: itemSelected,
                            player: player,
                            uid: user.uid,
                            videoLearningId: id,
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
              child: Text('No learn video learning available.'),
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

class AdminLearnVideolearningForm extends StatefulWidget {
  final String uid;
  final String videoLearningId;
  final int selectedContainerIndex;
  final List<Map> learnVideo;
  final Function(int) onItemSelected;
  final Widget player;
  const AdminLearnVideolearningForm(
      {super.key,
      required this.uid,
      required this.videoLearningId,
      required this.selectedContainerIndex,
      required this.learnVideo,
      required this.onItemSelected,
      required this.player});

  @override
  State<AdminLearnVideolearningForm> createState() =>
      _AdminLearnVideolearningFormState();
}

class _AdminLearnVideolearningFormState
    extends State<AdminLearnVideolearningForm> {
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
                children: widget.learnVideo.isEmpty
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

                              await firestore.addLearningVideo(
                                  videoLearningId: widget.videoLearningId,
                                  data: LearnVideo(
                                      title: value,
                                      videoUrl: '',
                                      createdAt: DateTime.now()));
                            },
                          ),
                        ),
                      ]
                    : List.generate(widget.learnVideo.length, (index) {
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
                            key: ValueKey(widget.learnVideo[index]['id']),
                            initialValue: widget
                                .learnVideo[index]['learn_videoLearning'].title,
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
                                          await firestore.addLearningVideo(
                                            videoLearningId:
                                                widget.videoLearningId,
                                            data: LearnVideo(
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
                                          await firestore.updateLearnVideo(
                                            isUpdating: false,
                                            videoLearningId:
                                                widget.videoLearningId,
                                            learnVideoId:
                                                widget.learnVideo[index]['id'],
                                          );
                                          setState(() {});
                                        },
                                        child: const Icon(IconlyLight.delete)),
                                  ],
                                )),
                            onChanged: (value) {
                              FirestoreService firestore =
                                  FirestoreService(uid: widget.uid);
                              firestore.updateLearnVideo(
                                isUpdating: true,
                                videoLearningId: widget.videoLearningId,
                                learnVideoId: widget.learnVideo[index]['id'],
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
                              .learnVideo[widget.selectedContainerIndex]
                                  ['learn_videoLearning']
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
                            firestore.updateLearnVideo(
                              isUpdating: true,
                              videoLearningId: widget.videoLearningId,
                              learnVideoId: widget
                                      .learnVideo[widget.selectedContainerIndex]
                                  ['id'],
                              fieldName: 'video_url',
                              data: value,
                            );
                          },
                        )
                      : Column(
                          children: [
                            TextFormField(
                              initialValue: widget
                                  .learnVideo[widget.selectedContainerIndex]
                                      ['learn_videoLearning']
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
                                firestore.updateLearnVideo(
                                  isUpdating: true,
                                  videoLearningId: widget.videoLearningId,
                                  learnVideoId: widget.learnVideo[
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
          )
        ],
      ),
    );
  }
}
