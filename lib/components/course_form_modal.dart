import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/models/course.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/routes/routes.dart';
import 'package:project_tc/services/extension.dart';
import 'package:project_tc/services/firestore_service.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CourseFormModal extends StatefulWidget {
  final Course? course;
  final String? courseId;
  const CourseFormModal({super.key, this.course, this.courseId});

  @override
  State<CourseFormModal> createState() => _CourseFormModalState();
}

class _CourseFormModalState extends State<CourseFormModal> {
  final _formKey = GlobalKey<FormState>();

  String error = '';

  String? title;
  String? learnLimit;
  String? price;
  String? courseType;
  String? courseCategory;
  bool? isBundle;
  bool? isBestSales;

  List courseCategories = ['Online course', 'Offline course'];
  List courseTypes = ['Free', 'Premium'];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final user = Provider.of<UserModel?>(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Color(0xFFCCCCCC),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Text(
              widget.course == null ? 'Add Course' : 'Edit Course',
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
            const Spacer(),
            GestureDetector(
                onTap: () => Get.back(result: false),
                child: const Icon(Icons.close))
          ],
        ),
        const SizedBox(
          height: 10,
          width: 400,
        ),
      ]),
      content: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Title',
                    style: GoogleFonts.poppins(
                      fontSize: width * .009,
                      fontWeight: FontWeight.w600,
                      color: CusColors.subHeader.withOpacity(0.5),
                    ),
                  ),
                ),
                TextFormField(
                  initialValue:
                      widget.courseId != null ? widget.course!.title : '',
                  style: GoogleFonts.poppins(
                    fontSize: getValueForScreenType<double>(
                      context: context,
                      mobile: width * .018,
                      tablet: width * .015,
                      desktop: width * .009,
                    ),
                    fontWeight: FontWeight.w500,
                    color: CusColors.text,
                  ),
                  keyboardType: TextInputType.text,
                  decoration: editProfileDecoration.copyWith(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: getValueForScreenType<double>(
                          context: context,
                          mobile: 13,
                          tablet: 15,
                          desktop: 16,
                        ),
                        horizontal: 18),
                    hintText: 'Enter an title',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .018,
                        tablet: width * .015,
                        desktop: width * .009,
                      ),
                      fontWeight: FontWeight.w500,
                      color: CusColors.secondaryText,
                    ),
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Enter an title';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    title = val;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8, top: 15),
                  child: Text(
                    'Course Category',
                    style: GoogleFonts.poppins(
                      fontSize: width * .009,
                      fontWeight: FontWeight.w600,
                      color: CusColors.subHeader.withOpacity(0.5),
                    ),
                  ),
                ),
                DropdownButtonFormField<String>(
                  value: widget.courseId != null
                      ? widget.course!.courseCategory
                      : 'Online course',
                  icon: const Icon(IconlyLight.arrow_down_2),
                  decoration: editProfileDecoration.copyWith(
                    hintText: 'Course Category',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: width * .009,
                      fontWeight: FontWeight.w500,
                      color: CusColors.subHeader.withOpacity(0.5),
                    ),
                  ),
                  validator: (val) => val == null ||
                          val.isEmpty ||
                          val == 'Select last course category'
                      ? 'Please select a course category'
                      : null,
                  onChanged: (val) {
                    courseCategory = val!; // Update the selected value
                  },
                  items: courseCategories.map((category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(
                        category,
                        style: GoogleFonts.poppins(
                          fontSize: width * .009,
                          fontWeight: FontWeight.w500,
                          color: CusColors.text,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8, top: 15),
                  child: Text(
                    'Course Type',
                    style: GoogleFonts.poppins(
                      fontSize: width * .009,
                      fontWeight: FontWeight.w600,
                      color: CusColors.subHeader.withOpacity(0.5),
                    ),
                  ),
                ),
                DropdownButtonFormField<String>(
                  value: widget.courseId != null
                      ? widget.course!.courseType
                      : 'Free',
                  icon: const Icon(IconlyLight.arrow_down_2),
                  decoration: editProfileDecoration.copyWith(
                    hintText: 'Course Type',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: width * .009,
                      fontWeight: FontWeight.w500,
                      color: CusColors.subHeader.withOpacity(0.5),
                    ),
                  ),
                  validator: (val) => val == null ||
                          val.isEmpty ||
                          val == 'Select last course type'
                      ? 'Please select a course type'
                      : null,
                  onChanged: (val) {
                    courseType = val!; // Update the selected value
                  },
                  items: courseTypes.map((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(
                        type,
                        style: GoogleFonts.poppins(
                          fontSize: width * .009,
                          fontWeight: FontWeight.w500,
                          color: CusColors.text,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8, top: 15),
                  child: Text(
                    'Bundle course?',
                    style: GoogleFonts.poppins(
                      fontSize: width * .009,
                      fontWeight: FontWeight.w600,
                      color: CusColors.subHeader.withOpacity(0.5),
                    ),
                  ),
                ),
                DropdownButtonFormField<bool>(
                  value:
                      widget.courseId != null ? widget.course!.isBundle : false,
                  icon: const Icon(IconlyLight.arrow_down_2),
                  decoration: editProfileDecoration.copyWith(
                    hintText: 'Bundle Course?',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: width * .009,
                      fontWeight: FontWeight.w500,
                      color: CusColors.subHeader.withOpacity(0.5),
                    ),
                  ),
                  onChanged: (val) {
                    setState(() {
                      isBundle = val!;
                    });
                  },
                  items: [
                    DropdownMenuItem<bool>(
                      value: true,
                      child: Text(
                        'Yes',
                        style: GoogleFonts.poppins(
                          fontSize: width * .009,
                          fontWeight: FontWeight.w500,
                          color: CusColors.text,
                        ),
                      ),
                    ),
                    DropdownMenuItem<bool>(
                      value: false,
                      child: Text(
                        'No',
                        style: GoogleFonts.poppins(
                          fontSize: width * .009,
                          fontWeight: FontWeight.w500,
                          color: CusColors.text,
                        ),
                      ),
                    ),
                  ],
                ),
                if (widget.course != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8, top: 15),
                        child: Text(
                          'Best Sales',
                          style: GoogleFonts.poppins(
                            fontSize: width * .009,
                            fontWeight: FontWeight.w600,
                            color: CusColors.subHeader.withOpacity(0.5),
                          ),
                        ),
                      ),
                      DropdownButtonFormField<bool>(
                        value: widget.courseId != null
                            ? widget.course!.isBestSales
                            : false,
                        icon: const Icon(IconlyLight.arrow_down_2),
                        decoration: editProfileDecoration.copyWith(
                          hintText: 'Best Sales',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: width * .009,
                            fontWeight: FontWeight.w500,
                            color: CusColors.subHeader.withOpacity(0.5),
                          ),
                        ),
                        onChanged: (val) {
                          setState(() {
                            isBestSales = val!;
                          });
                        },
                        items: [
                          DropdownMenuItem<bool>(
                            value: true,
                            child: Text(
                              'Yes',
                              style: GoogleFonts.poppins(
                                fontSize: width * .009,
                                fontWeight: FontWeight.w500,
                                color: CusColors.text,
                              ),
                            ),
                          ),
                          DropdownMenuItem<bool>(
                            value: false,
                            child: Text(
                              'No',
                              style: GoogleFonts.poppins(
                                fontSize: width * .009,
                                fontWeight: FontWeight.w500,
                                color: CusColors.text,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8, top: 15),
                  child: Text(
                    'Learn limit for basic user',
                    style: GoogleFonts.poppins(
                      fontSize: width * .009,
                      fontWeight: FontWeight.w600,
                      color: CusColors.subHeader.withOpacity(0.5),
                    ),
                  ),
                ),
                TextFormField(
                  initialValue:
                      widget.courseId != null ? widget.course!.learnLimit : '3',
                  style: GoogleFonts.poppins(
                    fontSize: getValueForScreenType<double>(
                      context: context,
                      mobile: width * .018,
                      tablet: width * .015,
                      desktop: width * .009,
                    ),
                    fontWeight: FontWeight.w500,
                    color: CusColors.text,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*')),
                  ],
                  decoration: editProfileDecoration.copyWith(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: getValueForScreenType<double>(
                          context: context,
                          mobile: 13,
                          tablet: 15,
                          desktop: 16,
                        ),
                        horizontal: 18),
                    hintText: 'Enter an learn limit',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .018,
                        tablet: width * .015,
                        desktop: width * .009,
                      ),
                      fontWeight: FontWeight.w500,
                      color: CusColors.secondaryText,
                    ),
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Enter an learn limit';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    learnLimit = val;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8, top: 15),
                  child: Text(
                    'Price',
                    style: GoogleFonts.poppins(
                      fontSize: width * .009,
                      fontWeight: FontWeight.w600,
                      color: CusColors.subHeader.withOpacity(0.5),
                    ),
                  ),
                ),
                TextFormField(
                  initialValue:
                      widget.courseId != null ? widget.course!.price : '',
                  style: GoogleFonts.poppins(
                    fontSize: getValueForScreenType<double>(
                      context: context,
                      mobile: width * .018,
                      tablet: width * .015,
                      desktop: width * .009,
                    ),
                    fontWeight: FontWeight.w500,
                    color: CusColors.text,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    ThousandsFormatter(),
                  ],
                  decoration: editProfileDecoration.copyWith(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: getValueForScreenType<double>(
                          context: context,
                          mobile: 13,
                          tablet: 15,
                          desktop: 16,
                        ),
                        horizontal: 18),
                    hintText: 'Enter an price',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .018,
                        tablet: width * .015,
                        desktop: width * .009,
                      ),
                      fontWeight: FontWeight.w500,
                      color: CusColors.secondaryText,
                    ),
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Enter an price';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    price = val;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        SizedBox(
          height: getValueForScreenType<double>(
            context: context,
            mobile: 26,
            tablet: 33,
            desktop: 38,
          ),
          child: ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final FirestoreService firestore =
                    FirestoreService(uid: user!.uid);
                if (widget.course != null) {
                  await firestore.updateCourseFewField(
                    courseId: widget.courseId,
                    title: title ?? widget.course!.title,
                    learnLimit: learnLimit ?? widget.course!.learnLimit,
                    price: price ?? widget.course!.price,
                    courseCategory:
                        courseCategory ?? widget.course!.courseCategory,
                    courseType: courseType ?? widget.course!.courseType,
                    isBundle: isBundle ?? widget.course!.isBundle,
                    isBestSales: isBestSales ?? widget.course!.isBestSales,
                  );
                } else {
                  final Course data = Course(
                      image: '',
                      courseCategory: courseCategory ?? 'Online course',
                      courseType: courseType ?? 'Free',
                      title: title,
                      isBundle: isBundle ?? false,
                      completionBenefits: [],
                      chapterList: [ChapterList(chapter: '', subChapter: [])],
                      learnLimit: learnLimit ?? '3',
                      price: price,
                      isDraft: true,
                      createdAt: DateTime.now());

                  await firestore.addCourse(data);
                }
                Get.back(result: false);
              }
            },
            style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(
                    horizontal: getValueForScreenType<double>(
                      context: context,
                      mobile: 20,
                      tablet: 25,
                      desktop: 30,
                    ),
                  ),
                ),
                foregroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 23, 221, 1),
                ),
                backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 23, 221, 1),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                )),
            child: Text(
              widget.course != null ? 'Save' : 'Save as draf',
              style: GoogleFonts.poppins(
                fontSize: getValueForScreenType<double>(
                  context: context,
                  mobile: width * .018,
                  tablet: width * .015,
                  desktop: width * .01,
                ),
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        SizedBox(
          height: getValueForScreenType<double>(
            context: context,
            mobile: 26,
            tablet: 33,
            desktop: 38,
          ),
          child: ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final FirestoreService firestore =
                    FirestoreService(uid: user!.uid);
                if (widget.course != null) {
                  await firestore.updateCourseFewField(
                    courseId: widget.courseId,
                    title: title ?? widget.course!.title,
                    learnLimit: learnLimit ?? widget.course!.learnLimit,
                    price: price ?? widget.course!.price,
                    courseCategory:
                        courseCategory ?? widget.course!.courseCategory,
                    courseType: courseType ?? widget.course!.courseType,
                    isBundle: isBundle ?? widget.course!.isBundle,
                    isBestSales: isBestSales ?? widget.course!.isBestSales,
                  );
                } else {
                  final Course data = Course(
                      image: '',
                      courseCategory: courseCategory ?? 'Online course',
                      courseType: courseType ?? 'Free',
                      title: title,
                      isBundle: isBundle ?? false,
                      completionBenefits: [],
                      chapterList: [ChapterList(chapter: '', subChapter: [])],
                      learnLimit: learnLimit ?? '3',
                      price: price,
                      isDraft: true,
                      createdAt: DateTime.now());

                  final result = await firestore.addCourse(data);
                  Get.rootDelegate.toNamed(routeAdminDetailCourse,
                      parameters: {'id': result});
                }
                if (widget.courseId != null) {
                  Get.rootDelegate.toNamed(routeAdminDetailCourse,
                      parameters: {'id': widget.courseId!});
                }
              }
            },
            style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(
                    horizontal: getValueForScreenType<double>(
                      context: context,
                      mobile: 20,
                      tablet: 25,
                      desktop: 30,
                    ),
                  ),
                ),
                foregroundColor: MaterialStateProperty.all(
                  const Color(0xFF4351FF),
                ),
                backgroundColor: MaterialStateProperty.all(
                  const Color(0xFF4351FF),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                )),
            child: Text(
              'Continue',
              style: GoogleFonts.poppins(
                fontSize: getValueForScreenType<double>(
                  context: context,
                  mobile: width * .018,
                  tablet: width * .015,
                  desktop: width * .01,
                ),
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }
}
