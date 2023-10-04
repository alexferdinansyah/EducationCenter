import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/animation/animation_function.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/components/courses.dart';
import 'package:project_tc/components/static/course_data.dart';
import 'package:project_tc/models/course.dart';
import 'package:project_tc/routes/routes.dart';

class MyCourses extends StatefulWidget {
  const MyCourses({Key? key}) : super(key: key);

  @override
  State<MyCourses> createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses> {
  List<Course> filteredCourses = [];

  void filterCourses(String criteria) {
    setState(() {
      filteredCourses = courses.where((course) {
        if (criteria == 'All Courses') {
          return true;
        } else if (criteria == 'Free Courses') {
          return course.courseType == 'Free';
        } else if (criteria == 'Premium') {
          return course.courseType == 'Premium';
        } else if (criteria == 'Finished') {
          return course.status == 'Finished';
        }
        return false;
      }).toList();
    });
  }

  List<bool> isHovered = [false, false, false, false];
  List<bool> isSelected = [true, false, false, false];
  bool isHover = false;

  // Define the list of criteria and button labels
  List<String> filterCriteria = [
    'All Courses',
    'Free Courses',
    'Premium',
    'Finished',
  ];

  @override
  void initState() {
    super.initState();
    // Initialize with "All Courses" as the default filter
    filterCourses('All Courses');
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * .83,
      height: height - 60,
      color: CusColors.bg,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Courses',
                  style: GoogleFonts.poppins(
                    fontSize: width * .014,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1F384C),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: List.generate(filterCriteria.length, (index) {
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
                        duration: const Duration(milliseconds: 300),
                        width: width * .1,
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
                              for (int i = 0; i < isSelected.length; i++) {
                                isSelected[i] = (i == index);
                              }
                            });
                            filterCourses(filterCriteria[index]);
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
                                vertical: height * 0.02,
                              ),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                            shadowColor:
                                MaterialStateProperty.all(Colors.transparent),
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
                              fontSize: width * 0.01,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(
                  height: 80,
                ),
                SizedBox(
                  height: filteredCourses.length / 5 > 1 &&
                          filteredCourses.length / 5 < 2
                      ? height / 2.5 * 2
                      : filteredCourses.length / 5 >= 2
                          ? height / 2.5 * (filteredCourses.length / 5)
                          : height / 1.6,
                  child: filteredCourses.isEmpty
                      ? Center(
                          // Show a message when data is null
                          child: Column(
                          children: [
                            SvgPicture.asset(
                              'assets/svg/course_none.svg',
                              height: height / 2.3,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Text(
                                "You don't take any courses, \n you can search for courses according to your needs",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: width * .013,
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
                                margin: const EdgeInsets.only(right: 10),
                                duration: const Duration(milliseconds: 300),
                                width: width * .17,
                                decoration: BoxDecoration(
                                  color: isHover
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
                                    Get.toNamed(routeCourses);
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
                                        vertical: height * 0.025,
                                      ),
                                    ),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    shadowColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: Text(
                                          'See Course',
                                          style: GoogleFonts.mulish(
                                            fontWeight: FontWeight.w700,
                                            color: isHover
                                                ? Colors.white
                                                : CusColors.accentBlue,
                                            fontSize: width * 0.01,
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_outward_rounded,
                                        color: isHover
                                            ? Colors.white
                                            : CusColors.accentBlue,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ))
                      : LiveGrid(
                          itemCount: filteredCourses.length,
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: height * .34,
                            crossAxisCount: 5, // Number of items per row
                            crossAxisSpacing: width *
                                .02, // Adjust spacing between items horizontally
                            mainAxisSpacing:
                                16.0, // Adjust spacing between rows vertically
                          ),
                          itemBuilder: animationBuilder((index) =>
                              MyCourse(course: filteredCourses[index]))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



// Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               ElevatedButton(
//                 onPressed: () => filterCourses('All Courses'),
//                 child: const Text('All Courses'),
//               ),
//               ElevatedButton(
//                 onPressed: () => filterCourses('Free Courses'),
//                 child: const Text('Free Courses'),
//               ),
//               ElevatedButton(
//                 onPressed: () => filterCourses('Premium'),
//                 child: const Text('Premium'),
//               ),
//               ElevatedButton(
//                 onPressed: () => filterCourses('Finished'),
//                 child: const Text('Finished'),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 500,
//           width: 600,
//           child: filteredCourses.isEmpty
//               ? const Center(
//                   // Show a message when data is null
//                   child: Text(
//                     'No courses available based on selected criteria.',
//                     style: TextStyle(fontSize: 18),
//                   ),
//                 )
//               : ListView.builder(
//                   itemCount: filteredCourses.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     Course course = filteredCourses[index];
//                     return ListTile(
//                       title: Text(course.title!),
//                       subtitle: Text(
//                           'Type: ${course.courseType}, Status: ${course.status}'),
//                     );
//                   },
//                 ),
//         ),
//       ],
//     );