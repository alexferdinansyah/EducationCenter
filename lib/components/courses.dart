import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/models/course.dart';
import 'package:project_tc/routes/routes.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:transparent_image/transparent_image.dart';

class Courses extends StatelessWidget {
  final Course course;
  final String id;
  const Courses({super.key, required this.course, required this.id});

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
        padding: EdgeInsets.fromLTRB(
            getValueForScreenType<double>(
              context: context,
              mobile: 15,
              tablet: 15,
              desktop: 20,
            ),
            getValueForScreenType<double>(
              context: context,
              mobile: 15,
              tablet: 15,
              desktop: 20,
            ),
            getValueForScreenType<double>(
              context: context,
              mobile: 15,
              tablet: 15,
              desktop: 20,
            ),
            10),
        child: Column(children: [
          course.image != ''
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: course.image!,
                  ),
                )
              : const Text('No Image'),
          Padding(
            padding: EdgeInsets.only(
              top: getValueForScreenType<double>(
                context: context,
                mobile: height * .011,
                tablet: height * .01,
                desktop: height * .01,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.courseCategory!,
                  style: GoogleFonts.mulish(
                      color: CusColors.inactive,
                      fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .024,
                        tablet: width * .014,
                        desktop: width * .011,
                      ),
                      fontWeight: FontWeight.w300,
                      height: 1.5),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: height * .006),
                  child: Text(
                    course.title!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.mulish(
                        color: CusColors.title,
                        fontSize: getValueForScreenType<double>(
                          context: context,
                          mobile: width * .028,
                          tablet: width * .014,
                          desktop: width * .012,
                        ),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                course.isBundle!
                    ? Text(
                        '(${course.totalCourse!})',
                        style: GoogleFonts.mulish(
                            color: CusColors.inactive,
                            fontSize: getValueForScreenType<double>(
                              context: context,
                              mobile: width * .024,
                              tablet: width * .014,
                              desktop: width * .011,
                            ),
                            fontWeight: FontWeight.w300,
                            height: 1.5),
                      )
                    : const SizedBox(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: getValueForScreenType<double>(
                      context: context,
                      mobile: height * .01,
                      tablet: height * .014,
                      desktop: height * .022,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Rp ${course.price!}',
                        style: GoogleFonts.mulish(
                            color: CusColors.title,
                            fontSize: getValueForScreenType<double>(
                              context: context,
                              mobile: width * .024,
                              tablet: width * .014,
                              desktop: width * .011,
                            ),
                            fontWeight: FontWeight.bold,
                            height: 1.5),
                      ),
                       course.discount != ''
                          ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${course.discount}% Off',
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFF2501FF),
                                      fontSize: getValueForScreenType<double>(
                                        context: context,
                                        mobile: width * .016,
                                        tablet: width * .01,
                                        desktop: width * .009,
                                      ),
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
                  height: getValueForScreenType<double>(
                    context: context,
                    mobile: 28,
                    tablet: 35,
                    desktop: 40,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF86B1F2),
                    borderRadius: BorderRadius.circular(64),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (course.isBundle == true) {
                        Get.rootDelegate.toNamed(
                          routeDetailBundleCourse,
                          parameters: {'id': id},
                        );
                      } else {
                        Get.rootDelegate.toNamed(
                          routeDetailSingleCourse,
                          parameters: {'id': id},
                        );
                      }
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
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
                            fontSize: getValueForScreenType<double>(
                              context: context,
                              mobile: width * .022,
                              tablet: width * .014,
                              desktop: width * .01,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_outward_rounded,
                          size: getValueForScreenType<double>(
                            context: context,
                            mobile: height * .02,
                            tablet: height * .021,
                            desktop: height * .025,
                          ),
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
            decoration: listCourse.image != ''
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(height * .03),
                    border: Border.all(
                      color: const Color(0xFF2501FF),
                      width: 1,
                    ),
                    image: DecorationImage(
                      image: NetworkImage(listCourse.image!),
                      fit: BoxFit.contain, // Adjust the fit as needed
                    ),
                  )
                : BoxDecoration(
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

class MyCourse extends StatelessWidget {
  final String id;
  final Course course;
  final bool? isPaid;
  final bool isAdmin;
  final Function()? onPressed;
  final Function()? onDelete;

  const MyCourse(
      {super.key,
      required this.course,
      required this.id,
      this.isPaid,
      required this.isAdmin,
      this.onPressed,
      this.onDelete});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          getValueForScreenType<double>(
            context: context,
            mobile: 18,
            tablet: 22,
            desktop: 25,
          ),
        ),
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFCCCCCC),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          course.image != ''
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: course.image!,
                  ),
                )
              : SizedBox(
                  height: 90,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('No Image',
                          style: GoogleFonts.mulish(
                              color: CusColors.title,
                              fontSize: getValueForScreenType<double>(
                                context: context,
                                mobile: width * .02,
                                tablet: width * .017,
                                desktop: width * .012,
                              ),
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
          Padding(
            padding: EdgeInsets.only(top: height * .01),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.courseCategory!,
                  style: GoogleFonts.mulish(
                      color: CusColors.inactive,
                      fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .017,
                        tablet: width * .014,
                        desktop: width * .009,
                      ),
                      fontWeight: FontWeight.w300,
                      height: 1.5),
                ),
                Padding(
                  padding: EdgeInsets.only(top: height * .006),
                  child: Text(
                    course.title!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.mulish(
                        color: CusColors.title,
                        fontSize: getValueForScreenType<double>(
                          context: context,
                          mobile: width * .02,
                          tablet: width * .017,
                          desktop: width * .012,
                        ),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                    width: double.infinity,
                    height: 1,
                    margin: EdgeInsets.symmetric(vertical: height * .012),
                    decoration: const BoxDecoration(
                      color: Color(0xFFCCCCCC),
                    )),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF86B1F2),
                          borderRadius: BorderRadius.circular(64),
                        ),
                        height: getValueForScreenType<double>(
                          context: context,
                          mobile: 26,
                          tablet: 33,
                          desktop: 38,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            if (isAdmin == true) {
                              onPressed!();
                            } else {
                              if (isPaid == true) {
                                Get.rootDelegate.toNamed(
                                  routeLearnCourse,
                                  parameters: {'id': id},
                                );
                              } else {
                                Get.rootDelegate.toNamed(
                                  routeOfferLearnCourse,
                                  parameters: {'id': id},
                                );
                              }
                            }
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                            shadowColor:
                                MaterialStateProperty.all(Colors.transparent),
                          ),
                          child: Text(
                            isAdmin ? 'Edit Course' : 'Learn Course',
                            style: GoogleFonts.mulish(
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontSize: getValueForScreenType<double>(
                                context: context,
                                mobile: width * .018,
                                tablet: width * .015,
                                desktop: width * .01,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    if (isAdmin)
                      GestureDetector(
                        onTap: () {
                          if (isAdmin == true) {
                            onDelete!();
                          }
                        },
                        child: Icon(
                          isAdmin ? IconlyLight.delete : IconlyLight.chat,
                          color: const Color(0xFF86B1F2),
                          size: getValueForScreenType<double>(
                            context: context,
                            mobile: 22,
                            tablet: 24,
                            desktop: 28,
                          ),
                        ),
                      )
                  ],
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
