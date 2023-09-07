import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/models/course.dart';
import 'package:project_tc/routes/routes.dart';

class Courses extends StatelessWidget {
  final Course course;
  const Courses({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width / 5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFCCCCCC),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: Column(children: [
          Container(
            width: double.infinity,
            height: height * .2,
            decoration: course.image != ''
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    image: DecorationImage(
                      image: AssetImage(course.image!),
                      fit: BoxFit.contain, // Adjust the fit as needed
                    ),
                  )
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: const Color(0xFFD9D9D9),
                  ),
          ),
          Padding(
            padding: EdgeInsets.only(top: height * .01),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.typeCourse!,
                  style: GoogleFonts.mulish(
                      color: CusColors.inactive,
                      fontSize: width * .011,
                      fontWeight: FontWeight.w300,
                      height: 1.5),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: height * .006),
                  child: Text(
                    course.title!,
                    style: GoogleFonts.mulish(
                        color: CusColors.title,
                        fontSize: width * .012,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                course.isBundle!
                    ? Text(
                        '(${course.totalCourse!})',
                        style: GoogleFonts.mulish(
                            color: CusColors.inactive,
                            fontSize: width * .011,
                            fontWeight: FontWeight.w300,
                            height: 1.5),
                      )
                    : const SizedBox(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: height * .022),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Rp. ${course.price!}',
                        style: GoogleFonts.mulish(
                            color: CusColors.title,
                            fontSize: width * .011,
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
                              margin: EdgeInsets.only(left: height * .01),
                              padding: EdgeInsets.symmetric(
                                  horizontal: height * .005,
                                  vertical: height * .004),
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
                    width: double.infinity,
                    height: 1,
                    margin: EdgeInsets.only(bottom: height * .01),
                    decoration: const BoxDecoration(
                      color: Color(0xFFCCCCCC),
                    )),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF86B1F2),
                    borderRadius: BorderRadius.circular(64),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (course.isBundle == true) {
                        Get.toNamed(
                          routeDetailBundleCourse,
                          arguments: {'course': course},
                        );
                      } else {
                        Get.toNamed(
                          routeDetailSingleCourse,
                          arguments: {'course': course},
                        );
                      }
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(
                          vertical: height * 0.025,
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                      shadowColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          course.isBundle! ? 'View Bundle' : 'View Course',
                          style: GoogleFonts.mulish(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: width * 0.01,
                          ),
                        ),
                        Icon(
                          Icons.arrow_outward_rounded,
                          size: height * .025,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class ListCourses extends StatelessWidget {
  final ListCourse listCourse;
  final int index;
  const ListCourses({super.key, required this.listCourse, required this.index});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * .6,
      padding: EdgeInsets.only(right: width * .015),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(height * .03),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFF2501FF).withOpacity(0.25),
              offset: const Offset(0, 4),
              blurRadius: 4)
        ],
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFF2501FF),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: width * .05,
            height: height * .05,
            decoration: BoxDecoration(
                color: CusColors.accentBlue, shape: BoxShape.circle),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${index + 1}',
                  style: GoogleFonts.mulish(
                    color: Colors.white,
                    fontSize: width * .011,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: width * .1,
            height: height * .13,
            margin: EdgeInsets.only(right: width * .015),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(height * .03),
              color: CusColors.inactive.withOpacity(0.4),
              border: Border.all(
                color: const Color(0xFF2501FF),
                width: 1,
              ),
            ),
          ),
          SizedBox(
            width: width * .33,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  listCourse.title!,
                  style: GoogleFonts.mulish(
                    color: CusColors.text,
                    fontSize: width * .014,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  listCourse.description!,
                  style: GoogleFonts.mulish(
                    color: CusColors.accentBlue,
                    fontSize: width * .011,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Text(
            listCourse.price!,
            style: GoogleFonts.mulish(
              color: CusColors.text,
              fontSize: width * .014,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
