import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/animation/animation_function.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/components/courses.dart';
import 'package:project_tc/components/footer.dart';
import 'package:project_tc/components/static/course_data.dart';

class SingleCourseList extends StatelessWidget {
  const SingleCourseList({super.key});

  @override
  Widget build(BuildContext context) {
    // Define a list of courses or data that you want to display in rows
    final listCourses =
        courses.where((course) => course.isBundle == false).toList();

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(top: 100, bottom: 100),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Column(children: [
            Text(
              'Available courses',
              style: GoogleFonts.mulish(
                  color: CusColors.header,
                  fontSize: width * .018,
                  fontWeight: FontWeight.bold),
            ),
            Container(
                margin: const EdgeInsets.only(top: 26, bottom: 50),
                width: 56,
                height: 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color.fromRGBO(0, 0, 0, 1),
                )),
            SizedBox(
              height: (height / 2) * (listCourses.length / 3),
              width: width / 1.7,
              child: LiveGrid(
                  itemCount: listCourses.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: height * .48,
                    crossAxisCount: 3, // Number of items per row
                    crossAxisSpacing: width *
                        .02, // Adjust spacing between items horizontally
                    mainAxisSpacing:
                        16.0, // Adjust spacing between rows vertically
                  ),
                  itemBuilder: animationBuilder(
                      (index) => Courses(course: listCourses[index]))),
            ),
          ])
        ]),
      ),
      const Footer()
    ]);
  }
}
