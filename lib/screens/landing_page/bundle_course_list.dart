import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/animation/animation_function.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/components/courses.dart';
import 'package:project_tc/components/footer.dart';
import 'package:project_tc/components/reviews.dart';
import 'package:project_tc/components/static/review_data.dart';
import 'package:project_tc/models/course.dart';
import 'package:project_tc/services/firestore_service.dart';

class BundleCourseList extends StatefulWidget {
  const BundleCourseList({super.key});

  @override
  State<BundleCourseList> createState() => _BundleCourseListState();
}

class _BundleCourseListState extends State<BundleCourseList> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(top: 100, bottom: 100),
        child: Row(
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
                        'Bundling Courses',
                        style: GoogleFonts.mulish(
                          color: CusColors.accentBlue,
                          fontSize: width * .012,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          'Bundling course for who want to success',
                          style: GoogleFonts.mulish(
                              color: CusColors.header,
                              fontSize: width * .024,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        'This bundle course is designed to prepare you to master the skills you want.\nBy purchasing a course bundle, you will learn more at a lower price',
                        style: GoogleFonts.mulish(
                            color: CusColors.inactive,
                            fontSize: width * .012,
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
                      child: SvgPicture.asset(
                        'assets/svg/bundle_course.svg',
                        width: width / 3,
                      )),
            )
          ],
        ),
      ),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        StreamBuilder(
            stream: FirestoreService.withoutUID().allCourses,
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                final List<Map> dataMaps = snapshot.data!;

                final List<Map> bundleCourses = dataMaps.where((courseMap) {
                  final dynamic data = courseMap['course'];
                  return data is Course && data.isBundle == true;
                }).map((courseMap) {
                  final Course course = courseMap['course'];
                  final String id = courseMap['id'];
                  return {'course': course, 'id': id};
                }).toList();
                return Column(children: [
                  Text(
                    'Available bundle',
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
                    height: (height / 1.9) * (bundleCourses.length / 3),
                    width: width / 1.7,
                    child: LiveGrid(
                        itemCount: bundleCourses.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: height * .51,
                          crossAxisCount: 3, // Number of items per row
                          crossAxisSpacing: width *
                              .02, // Adjust spacing between items horizontally
                          mainAxisSpacing:
                              16.0, // Adjust spacing between rows vertically
                        ),
                        itemBuilder: animationBuilder((index) => Courses(
                            course: bundleCourses[index]['course'],
                            id: bundleCourses[index]['id']))),
                  ),
                ]);
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('No courses available.'),
                );
              } else {
                return const Center(
                  child: Text('kok iso.'),
                );
              }
            }),
      ]),
      SizedBox(
        height: height / 8,
      ),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Column(children: [
          Text(
            'Reviews',
            style: GoogleFonts.mulish(
                color: CusColors.header,
                fontSize: width * .018,
                fontWeight: FontWeight.bold),
          ),
          Container(
              margin: const EdgeInsets.only(top: 26, bottom: 70),
              width: 56,
              height: 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color.fromRGBO(0, 0, 0, 1),
              )),
          SizedBox(
            height: (height / 2) * (reviews.length / 4),
            width: width / 1.5,
            child: LiveGrid(
                itemCount: reviews.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: height * .4,
                  crossAxisCount: 4, // Number of items per row
                  crossAxisSpacing:
                      width * .02, // Adjust spacing between items horizontally
                  mainAxisSpacing:
                      16.0, // Adjust spacing between rows vertically
                ),
                itemBuilder: animationBuilder(
                    (index) => Reviews(review: reviews[index]))),
          ),
        ])
      ]),
      const Footer()
    ]);
  }
}
