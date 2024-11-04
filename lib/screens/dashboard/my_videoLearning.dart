import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/components/loading.dart';
import 'package:project_tc/components/videoLearnings.dart';
import 'package:project_tc/models/learning.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/routes/routes.dart';
import 'package:project_tc/services/firestore_service.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MyVideolearning extends StatefulWidget {
  final UserModel user;
  const MyVideolearning({Key? key, required this.user}) : super(key: key);

  @override
  State<MyVideolearning> createState() => _MyVideolearningState();
}

class _MyVideolearningState extends State<MyVideolearning> {
  List<Map> videoLearning = [];
  List<Map> filteredVideoLearnings = [];
  bool iniVideo = false;

  void filterVideoLearnings(String criteria) {
    setState(() {
      filteredVideoLearnings = videoLearning.where((videoLearning) {
        if (criteria == 'video learning') {
          return true;
        }
        return false;
      }).toList();
    });
  }

  List<bool> isHovered = [false];
  List<bool> isSelected = [true];
  bool isHover = false;

  // Define the list of criteria and button labels
  List<String> filterCriteria = [
    'video learning',
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return StreamBuilder(
        stream: FirestoreService(uid: widget.user.uid).allMyVideoLearnings,
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active && !iniVideo) {
            iniVideo = true;
            Future.delayed(const Duration(milliseconds: 300),
                () => filterVideoLearnings('video learning'));
          }
          if (snapshot.hasData) {
            final List<Map<String, dynamic>?> dataMaps = snapshot.data!;
            final dataVideos = dataMaps.map((data) {
              return {
                'id': data!['id'],
                'videoLearning': data['videoLearning'] as VideoLearning,
                'status': data['status'],
                'isPaid': data['isPaid']
              };
            }).toList();

            videoLearning = List.from(dataVideos);

            return Container(
              width: getValueForScreenType<double>(
                context: context,
                mobile: width * .86,
                tablet: width * .79,
                desktop: width * .83,
              ),
              height: getValueForScreenType<double>(
                context: context,
                mobile: height - 40,
                tablet: height - 50,
                desktop: height - 60,
              ),
              color: CusColors.bg,
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getValueForScreenType<double>(
                        context: context,
                        mobile: 20,
                        tablet: 30,
                        desktop: 40,
                      ),
                      vertical: getValueForScreenType<double>(
                        context: context,
                        mobile: 20,
                        tablet: 30,
                        desktop: 35,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My video learning',
                          style: GoogleFonts.poppins(
                            fontSize: getValueForScreenType<double>(
                              context: context,
                              mobile: width * .022,
                              tablet: width * .019,
                              desktop: width * .014,
                            ),
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF1F384C),
                          ),
                        ),
                        SizedBox(
                          height: getValueForScreenType<double>(
                            context: context,
                            mobile: 20,
                            tablet: 25,
                            desktop: 40,
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: getValueForScreenType<double>(
                            context: context,
                            mobile: 38,
                            tablet: 45,
                            desktop: 50,
                          ),
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Row(
                                children: List.generate(filterCriteria.length,
                                    (index) {
                                  return MouseRegion(
                                    onEnter: (_) {
                                      // Set the hover state
                                      setState(() {
                                        isHovered[index] = true;
                                      });
                                    },
                                    onExit: (_) {
                                      // Reset the hover state
                                      setState(() {
                                        isHovered[index] = false;
                                      });
                                    },
                                    child: AnimatedContainer(
                                      margin: const EdgeInsets.only(right: 10),
                                      duration:
                                          const Duration(milliseconds: 300),
                                      height: getValueForScreenType<double>(
                                        context: context,
                                        mobile: 28,
                                        tablet: 35,
                                        desktop: 40,
                                      ),
                                      width: getValueForScreenType<double>(
                                        context: context,
                                        mobile: width * .2,
                                        tablet: width * .15,
                                        desktop: width * .1,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isSelected[index]
                                            ? CusColors.accentBlue
                                            : isHovered[index]
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
                                          setState(() {
                                            for (int i = 0;
                                                i < isSelected.length;
                                                i++) {
                                              isSelected[i] = (i == index);
                                            }
                                          });
                                          filterVideoLearnings(
                                              filterCriteria[index]);
                                        },
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
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
                                          filterCriteria[index],
                                          style: GoogleFonts.mulish(
                                            fontWeight: FontWeight.w700,
                                            color: isSelected[index]
                                                ? Colors.white
                                                : isHovered[index]
                                                    ? Colors.white
                                                    : CusColors.accentBlue,
                                            fontSize:
                                                getValueForScreenType<double>(
                                              context: context,
                                              mobile: width * .018,
                                              tablet: width * .015,
                                              desktop: width * .01,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: getValueForScreenType<double>(
                            context: context,
                            mobile: 20,
                            tablet: 40,
                            desktop: 50,
                          ),
                        ),
                        SizedBox(
                          height: filteredVideoLearnings.length / 5 > 1 &&
                                  filteredVideoLearnings.length / 5 < 2
                              ? height / 3
                              : filteredVideoLearnings.length / 5 >= 2
                                  ? height /
                                      2.5 *
                                      (filteredVideoLearnings.length / 5)
                                  : height / 1.6,
                          child: filteredVideoLearnings.isEmpty
                              ? Center(
                                  // Show a message when data is null
                                  child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svg/course_none.svg',
                                      height: getValueForScreenType<double>(
                                        context: context,
                                        mobile: height / 3,
                                        tablet: height / 2.7,
                                        desktop: height / 2.3,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      child: Text(
                                        "You don't have any video, \n you can search for video according to your needs",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                          fontSize:
                                              getValueForScreenType<double>(
                                            context: context,
                                            mobile: width * .021,
                                            tablet: width * .018,
                                            desktop: width * .013,
                                          ),
                                          color: const Color(0xFF1F384C),
                                        ),
                                      ),
                                    ),
                                    MouseRegion(
                                      onEnter: (_) {
                                        // Set the hover state
                                        setState(() {
                                          isHover = true;
                                        });
                                      },
                                      onExit: (_) {
                                        // Reset the hover state
                                        setState(() {
                                          isHover = false;
                                        });
                                      },
                                      child: AnimatedContainer(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        duration:
                                            const Duration(milliseconds: 300),
                                        height: getValueForScreenType<double>(
                                          context: context,
                                          mobile: 28,
                                          tablet: 35,
                                          desktop: 40,
                                        ),
                                        width: getValueForScreenType<double>(
                                          context: context,
                                          mobile: width * .23,
                                          tablet: width * .2,
                                          desktop: width * .17,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isHover
                                              ? CusColors.accentBlue
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(64),
                                          border: Border.all(
                                            color: CusColors.accentBlue,
                                            width: 1,
                                          ),
                                        ),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Get.rootDelegate
                                                .toNamed(routeVideoLearning);
                                          },
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 5),
                                                child: Text(
                                                  'See video',
                                                  style: GoogleFonts.mulish(
                                                    fontWeight: FontWeight.w700,
                                                    color: isHover
                                                        ? Colors.white
                                                        : CusColors.accentBlue,
                                                    fontSize:
                                                        getValueForScreenType<
                                                            double>(
                                                      context: context,
                                                      mobile: width * .018,
                                                      tablet: width * .015,
                                                      desktop: width * .01,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Icon(
                                                Icons.arrow_outward_rounded,
                                                color: isHover
                                                    ? Colors.white
                                                    : CusColors.accentBlue,
                                                size: getValueForScreenType<
                                                    double>(
                                                  context: context,
                                                  mobile: 20,
                                                  tablet: 22,
                                                  desktop: 24,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ))
                              : ScrollConfiguration(
                                  behavior: ScrollConfiguration.of(context)
                                      .copyWith(scrollbars: false),
                                  child: MasonryGridView.count(
                                    physics: const ScrollPhysics(
                                        parent: BouncingScrollPhysics()),
                                    crossAxisSpacing: width *
                                        .02, // Adjust spacing between items horizontally
                                    mainAxisSpacing:
                                        16.0, // Adjust spacing between rows vertically
                                    crossAxisCount: getValueForScreenType<int>(
                                      context: context,
                                      mobile: 2,
                                      tablet: 3,
                                      desktop: 5,
                                    ),
                                    itemCount: filteredVideoLearnings.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return MyVideoLearning(
                                        videoLearning:
                                            filteredVideoLearnings[index]
                                                ['videoLearning'],
                                        id: filteredVideoLearnings[index]['id'],
                                        isPaid: filteredVideoLearnings[index]
                                            ['isPaid'],
                                        isAdmin: false,
                                      );
                                    },
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No courses available.'),
            );
          } else {
            return const Center(
              child: Text('kok iso.'),
            );
          }
        });
  }
}
