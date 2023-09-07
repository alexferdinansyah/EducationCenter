import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/animation/animation_function.dart';
import 'package:project_tc/components/custom_list.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/components/courses.dart';
import 'package:project_tc/models/course.dart';

class DetailBundleCourse extends StatelessWidget {
  final Course course;
  const DetailBundleCourse({super.key, required this.course});

  List<Widget> generateListCourses(List<ListCourse> courses) {
    return courses.asMap().entries.map((entry) {
      final index = entry.key;
      final listCourse = entry.value;
      return ListCourses(
        listCourse: listCourse,
        index: index,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 100, bottom: 200),
          child: Row(
            children: [
              AnimateIfVisible(
                reAnimateOnVisibility: true,
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
                          'Bundle Courses',
                          style: GoogleFonts.mulish(
                            color: CusColors.accentBlue,
                            fontSize: width * .012,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 8),
                          child: Text(
                            course.title!,
                            style: GoogleFonts.mulish(
                                color: CusColors.header,
                                fontSize: width * .028,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          '(Contains ${course.totalCourse!} Courses)',
                          style: GoogleFonts.mulish(
                            color: CusColors.accentBlue,
                            fontSize: width * .011,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 40),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 3),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: Colors.transparent,
                                  border: Border.all(
                                    color: const Color(0xFF2501FF),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Certificate',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.mulish(
                                        color: const Color(0xFF2501FF),
                                        fontSize: width * .011,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 3),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: Colors.transparent,
                                  border: Border.all(
                                    color: const Color(0xFF2501FF),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Beginner friendly',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.mulish(
                                        color: const Color(0xFF2501FF),
                                        fontSize: width * .011,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          course.description!,
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
                  reAnimateOnVisibility: true,
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
                          child: Container(
                            width: width / 2.7,
                            height: height / 2.1,
                            decoration: course.image != ''
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    // color: const Color(0xFFD9D9D9),
                                    image: DecorationImage(
                                        image: AssetImage(course.image!),
                                        fit: BoxFit
                                            .contain, // Adjust the fit as needed
                                        alignment: Alignment.topCenter),
                                  )
                                : BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    color: const Color(0xFFD9D9D9),
                                  ),
                          )))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            children: [
              AnimateIfVisible(
                key: const Key('item.3'),
                builder: (
                  BuildContext context,
                  Animation<double> animation,
                ) =>
                    FadeTransition(
                  opacity: Tween<double>(
                    begin: 0,
                    end: 1,
                  ).animate(animation),
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 2),
                      end: Offset.zero,
                    ).animate(animation),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              'This bundle includes :',
                              style: GoogleFonts.mulish(
                                  color: CusColors.header,
                                  fontSize: width * .018,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 26),
                                width: 56,
                                height: 2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color.fromRGBO(0, 0, 0, 1),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: width / 1.6,
                height: height * .13 * course.listCourse!.length + 150,
                child: LiveList(
                  showItemInterval: const Duration(milliseconds: 150),
                  showItemDuration: const Duration(milliseconds: 350),
                  reAnimateOnVisibility: true,
                  scrollDirection: Axis.vertical,
                  itemCount: course.listCourse!.length,
                  itemBuilder: animationBuilder(
                    (index) => ListCourses(
                      listCourse: course.listCourse![index],
                      index: index,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  width: width / 1.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color(0xFFF6F7F9),
                  ),
                  padding: const EdgeInsets.only(top: 20, bottom: 100),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 50),
                        child: Text(
                          'What you get after completing this bundle',
                          style: GoogleFonts.mulish(
                              color: CusColors.header,
                              fontSize: width * .015,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      BulletList(
                        course.completionBenefits!,
                        border: true,
                      )
                    ],
                  ),
                ),
              ]),
            ],
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            width: width * .5,
            margin: const EdgeInsets.only(bottom: 100),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white,
              border: Border.all(
                color: const Color(0xFFCCCCCC),
                width: 1,
              ),
            ),
            padding: EdgeInsets.all(width * .012),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: width * .25,
                  height: height * .28,
                  margin: EdgeInsets.only(right: width * .012),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: const Color(0xFFD9D9D9),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Join now',
                      style: GoogleFonts.mulish(
                          color: CusColors.header,
                          fontSize: width * .015,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: height * .015, bottom: height * .03),
                      child: const BulletList([
                        'Up-to-date Content',
                        'Learn with study case',
                        'Beginner friendly'
                      ], border: false),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: height * .025),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Rp. ${course.price!}',
                            style: GoogleFonts.mulish(
                                color: CusColors.title,
                                fontSize: width * .015,
                                fontWeight: FontWeight.bold,
                                height: 1.5),
                          ),
                          course.discount != ''
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.transparent,
                                    border: Border.all(
                                      color: const Color(0xFF2501FF),
                                      width: 1,
                                    ),
                                  ),
                                  margin: const EdgeInsets.only(left: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 3),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '${course.discount}% Off',
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.inter(
                                          color: const Color(0xFF2501FF),
                                          fontSize: width * .009,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                    Container(
                      width: width * .2,
                      decoration: BoxDecoration(
                        color: const Color(0xFF86B1F2),
                        borderRadius: BorderRadius.circular(64),
                      ),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(
                              vertical: height * 0.025,
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          shadowColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: Text(
                          course.isBundle!
                              ? 'Buy Courses Bundle'
                              : 'Buy Course',
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
              ],
            ),
          ),
        ]),
      ],
    );
  }
}
