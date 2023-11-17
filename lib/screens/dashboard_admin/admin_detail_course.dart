import 'package:auto_animated/auto_animated.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/components/custom_list.dart';
import 'package:project_tc/controllers/detail_controller.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/screens/dashboard_admin/dashboard_admin.dart';
import 'package:project_tc/services/extension.dart';
import 'package:project_tc/services/firestore_service.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AdminDetailCourse extends StatefulWidget {
  const AdminDetailCourse({super.key});

  @override
  State<AdminDetailCourse> createState() => _AdminDetailCourseState();
}

class _AdminDetailCourseState extends State<AdminDetailCourse> {
  String id = '';
  String imageUrl = '';
  bool showSave = true;

  Uint8List? image;
  String? downloadURL;

  selectImageFromGallery() async {
    final picker = ImagePicker();
    XFile? imageFile = await picker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      var file = await imageFile.readAsBytes();
      setState(() {
        image = file;
        showSave = true;
      });
    }
  }

  Future<String?> uploadFile(Uint8List image) async {
    String postId = DateTime.now().millisecondsSinceEpoch.toString();
    var contentType = lookupMimeType('', headerBytes: image);

    Reference ref = FirebaseStorage.instance
        .ref()
        .child("thumbnail_course")
        .child("post_$postId.jpg");
    await ref.putData(image, SettableMetadata(contentType: contentType));
    downloadURL = await ref.getDownloadURL();
    return downloadURL;
  }

  uploadToFirebase(image) async {
    await uploadFile(image).then((value) {
      setState(() {
        showSave = false;
      });
    }); // this will upload the file and store url in the variable 'url'
  }

  Future<void> deleteExistingPhoto() async {
    if (imageUrl != '') {
      try {
        // Define a regular expression to match the filename
        RegExp regExp = RegExp(r'[^\/]+(?=\?)');

        // Use the regular expression to extract the filename
        String? fileUrl = regExp.firstMatch(imageUrl)?.group(0);

        String fileName = fileUrl!.replaceFirst("thumbnail_course%2F", "");

        // Create a reference to the previous image in Firebase Storage
        final storageRef = FirebaseStorage.instance
            .ref()
            .child("thumbnail_course")
            .child(fileName);

        // Delete the previous image from Firebase Storage
        await storageRef.delete();
      } catch (e) {
        print('Error deleting previous image: $e');
      }
    }
  }

  final DetailCourseController controller = Get.put(DetailCourseController());
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    var argument = Get.parameters;
    id = argument['id']!;
    controller.fetchDocument(id);

    return Scaffold(
      body: Obx(() {
        final course = controller.documentSnapshot.value;

        if (course == null) {
          return const Center(child: Text('Loading...'));
        }

        imageUrl = course.image!;

        return SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: width * .045, vertical: height * .018),
                color: CusColors.bg,
                alignment: Alignment.centerLeft,
                child: AnimateIfVisibleWrapper(
                  showItemInterval: const Duration(milliseconds: 150),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: getValueForScreenType<double>(
                                context: context,
                                mobile: 25,
                                tablet: 40,
                                desktop: 100,
                              ),
                              bottom: getValueForScreenType<double>(
                                context: context,
                                mobile: 60,
                                tablet: 70,
                                desktop: 200,
                              ),
                            ),
                            child: ResponsiveBuilder(
                              builder: (context, sizingInformation) {
                                // Check the sizing information here and return your UI
                                if (sizingInformation.deviceScreenType ==
                                    DeviceScreenType.desktop) {
                                  return _defaultHeader(width,
                                      courseCategory: course.courseCategory,
                                      courseImage: course.image,
                                      title: course.title,
                                      description: course.description,
                                      user: user);
                                }
                                if (sizingInformation.deviceScreenType ==
                                    DeviceScreenType.tablet) {
                                  return _defaultHeader(width,
                                      courseCategory: course.courseCategory,
                                      courseImage: course.image,
                                      title: course.title,
                                      description: course.description);
                                }
                                if (sizingInformation.deviceScreenType ==
                                    DeviceScreenType.mobile) {
                                  return _headerMobile(width,
                                      courseCategory: course.courseCategory,
                                      courseImage: course.image,
                                      title: course.title,
                                      description: course.description);
                                }
                                return Container();
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: getValueForScreenType<double>(
                                context: context,
                                mobile: 50,
                                tablet: 70,
                                desktop: 100,
                              ),
                            ),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                'What you will learn on this course',
                                                style: GoogleFonts.mulish(
                                                    color: CusColors.header,
                                                    fontSize:
                                                        getValueForScreenType<
                                                            double>(
                                                      context: context,
                                                      mobile: width * .028,
                                                      tablet: width * .022,
                                                      desktop: width * .018,
                                                    ),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    bottom:
                                                        getValueForScreenType<
                                                            double>(
                                                      context: context,
                                                      mobile: 30,
                                                      tablet: 50,
                                                      desktop: 70,
                                                    ),
                                                    top: getValueForScreenType<
                                                        double>(
                                                      context: context,
                                                      mobile: 10,
                                                      tablet: 20,
                                                      desktop: 26,
                                                    )),
                                                width: width * .05,
                                                height: 2,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: const Color.fromRGBO(
                                                      0, 0, 0, 1),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                BorderFormList(
                                  chapterList: course.chapterList!,
                                  uid: user!.uid,
                                  courseId: id,
                                  fontSize: getValueForScreenType<double>(
                                    context: context,
                                    mobile: width * .02,
                                    tablet: width * .017,
                                    desktop: width * .012,
                                  ),
                                  subFontSize: getValueForScreenType<double>(
                                    context: context,
                                    mobile: width * .019,
                                    tablet: width * .016,
                                    desktop: width * .011,
                                  ),
                                  subPadding: getValueForScreenType<double>(
                                    context: context,
                                    mobile: 5,
                                    tablet: 10,
                                    desktop: 15,
                                  ),
                                  padding: getValueForScreenType<double>(
                                    context: context,
                                    mobile: 4,
                                    tablet: 5,
                                    desktop: 5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: getValueForScreenType<double>(
                                context: context,
                                mobile: 40,
                                tablet: 70,
                                desktop: 100,
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: width / 1.4,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: const Color(0xFFF6F7F9),
                                        ),
                                        padding: EdgeInsets.only(
                                          top: 20,
                                          bottom: getValueForScreenType<double>(
                                            context: context,
                                            mobile: 40,
                                            tablet: 70,
                                            desktop: 100,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 50),
                                              child: Text(
                                                'What you get after completing this course',
                                                style: GoogleFonts.mulish(
                                                    color: CusColors.header,
                                                    fontSize:
                                                        getValueForScreenType<
                                                            double>(
                                                      context: context,
                                                      mobile: width * .025,
                                                      tablet: width * .019,
                                                      desktop: width * .015,
                                                    ),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            BulletFormList(
                                              course.completionBenefits!,
                                              uid: user.uid,
                                              courseId: id,
                                              padding:
                                                  getValueForScreenType<double>(
                                                context: context,
                                                mobile: 4,
                                                tablet: 5,
                                                desktop: 7,
                                              ),
                                              fontSize:
                                                  getValueForScreenType<double>(
                                                context: context,
                                                mobile: width * .019,
                                                tablet: width * .016,
                                                desktop: width * .011,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                      padding: EdgeInsets.all(
                        getValueForScreenType<double>(
                          context: context,
                          mobile: width * .015,
                          tablet: width * .012,
                          desktop: width * .012,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: width * .25,
                            height: height * .28,
                            margin: EdgeInsets.only(right: width * .012),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              image: const DecorationImage(
                                image:
                                    AssetImage('assets/images/certificate.png'),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Join now',
                                style: GoogleFonts.mulish(
                                    color: CusColors.header,
                                    fontSize: getValueForScreenType<double>(
                                      context: context,
                                      mobile: width * .023,
                                      tablet: width * .020,
                                      desktop: width * .015,
                                    ),
                                    fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: height * .015,
                                  bottom: getValueForScreenType<double>(
                                    context: context,
                                    mobile: width * .017,
                                    tablet: width * .02,
                                    desktop: height * .03,
                                  ),
                                ),
                                child: BulletList(
                                  const [
                                    'Up-to-date Content',
                                    'Learn with study case',
                                    'Beginner friendly'
                                  ],
                                  border: false,
                                  fontSize: getValueForScreenType<double>(
                                    context: context,
                                    mobile: width * .019,
                                    tablet: width * .016,
                                    desktop: width * .011,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: height * .025),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Rp ',
                                            style: GoogleFonts.mulish(
                                                color: CusColors.title,
                                                fontSize: getValueForScreenType<
                                                    double>(
                                                  context: context,
                                                  mobile: width * .023,
                                                  tablet: width * .020,
                                                  desktop: width * .015,
                                                ),
                                                fontWeight: FontWeight.bold,
                                                height: 1.5),
                                          ),
                                          Expanded(
                                            child: TextFormField(
                                              initialValue: course.price,
                                              style: GoogleFonts.mulish(
                                                  color: CusColors.title,
                                                  fontSize:
                                                      getValueForScreenType<
                                                          double>(
                                                    context: context,
                                                    mobile: width * .023,
                                                    tablet: width * .020,
                                                    desktop: width * .015,
                                                  ),
                                                  fontWeight: FontWeight.bold,
                                                  height: 1.5),
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: [
                                                ThousandsFormatter(),
                                              ],
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.zero,
                                                hintText: 'Enter an price',
                                                hintStyle: GoogleFonts.mulish(
                                                    color: CusColors.inactive,
                                                    fontSize:
                                                        getValueForScreenType<
                                                            double>(
                                                      context: context,
                                                      mobile: width * .02,
                                                      tablet: width * .017,
                                                      desktop: width * .012,
                                                    ),
                                                    fontWeight: FontWeight.w300,
                                                    height: 1.5),
                                              ),
                                              validator: (val) {
                                                if (val!.isEmpty) {
                                                  return 'Enter an price';
                                                }
                                                return null;
                                              },
                                              onChanged: (value) {
                                                FirestoreService firestore =
                                                    FirestoreService(
                                                        uid: user.uid);

                                                firestore.updateCourseEachField(
                                                  courseId: id,
                                                  fieldName: 'price',
                                                  data: value,
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.transparent,
                                        border: Border.all(
                                          color: const Color(0xFF2501FF),
                                          width: 1,
                                        ),
                                      ),
                                      margin: const EdgeInsets.only(left: 10),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 20,
                                            child: TextFormField(
                                              initialValue: course.discount,
                                              style: GoogleFonts.inter(
                                                color: const Color(0xFF2501FF),
                                                fontSize: getValueForScreenType<
                                                    double>(
                                                  context: context,
                                                  mobile: width * .017,
                                                  tablet: width * .014,
                                                  desktop: width * .009,
                                                ),
                                                fontWeight: FontWeight.normal,
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(
                                                        r'^[0-9\-\+\s()]*$')),
                                              ],
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.zero,
                                                hintText: 'Discount',
                                                hintStyle: GoogleFonts.inter(
                                                  color: CusColors.inactive,
                                                  fontSize:
                                                      getValueForScreenType<
                                                          double>(
                                                    context: context,
                                                    mobile: width * .017,
                                                    tablet: width * .014,
                                                    desktop: width * .009,
                                                  ),
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              validator: (val) {
                                                if (val!.isEmpty) {
                                                  return 'Enter an price';
                                                }
                                                return null;
                                              },
                                              onChanged: (value) {
                                                FirestoreService firestore =
                                                    FirestoreService(
                                                        uid: user.uid);

                                                firestore.updateCourseEachField(
                                                  courseId: id,
                                                  fieldName: 'discount',
                                                  data: value,
                                                );
                                              },
                                            ),
                                          ),
                                          Text(
                                            '% Off',
                                            textAlign: TextAlign.left,
                                            style: GoogleFonts.inter(
                                              color: const Color(0xFF2501FF),
                                              fontSize:
                                                  getValueForScreenType<double>(
                                                context: context,
                                                mobile: width * .017,
                                                tablet: width * .014,
                                                desktop: width * .009,
                                              ),
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: getValueForScreenType<double>(
                                  context: context,
                                  mobile: double.infinity,
                                  tablet: width * .2,
                                  desktop: width * .2,
                                ),
                                height: getValueForScreenType<double>(
                                  context: context,
                                  mobile: 28,
                                  tablet: 35,
                                  desktop: 45,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF86B1F2),
                                  borderRadius: BorderRadius.circular(64),
                                ),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    shadowColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                  ),
                                  child: Text(
                                    course.isBundle!
                                        ? 'Buy Courses Bundle'
                                        : 'Buy Course',
                                    style: GoogleFonts.mulish(
                                      fontWeight: FontWeight.w700,
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
                            ],
                          ),
                        ],
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40, right: 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (course.isDraf != false)
                      SizedBox(
                        height: getValueForScreenType<double>(
                          context: context,
                          mobile: 26,
                          tablet: 33,
                          desktop: 38,
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                            Get.to(
                                () => DashboardAdmin(
                                      selected: 'Courses',
                                    ),
                                routeName: '/login');
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
                            'Save as draf',
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
                                FirestoreService(uid: user.uid);
                            if (course.isDraf!) {
                              await firestore.updateCourseEachField(
                                  courseId: id,
                                  fieldName: 'is_draf',
                                  data: false);
                            }

                            Get.to(
                                () => DashboardAdmin(
                                      selected: 'Courses',
                                    ),
                                routeName: '/login');
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
                          course.isDraf! ? 'Publish' : 'Save',
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
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  Widget _defaultHeader(
    width, {
    String? courseCategory,
    String? title,
    String? courseImage,
    String? description,
    UserModel? user,
  }) {
    return Row(
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
                  TextFormField(
                    initialValue: courseCategory,
                    style: GoogleFonts.mulish(
                      color: CusColors.accentBlue,
                      fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .02,
                        tablet: width * .017,
                        desktop: width * .012,
                      ),
                      fontWeight: FontWeight.w700,
                    ),
                    decoration: const InputDecoration(border: InputBorder.none),
                    keyboardType: TextInputType.text,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Enter an course category';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      FirestoreService firestore =
                          FirestoreService(uid: user!.uid);
                      firestore.updateCourseEachField(
                        courseId: id,
                        fieldName: 'course_category',
                        data: value,
                      );
                    },
                  ),
                  TextFormField(
                    initialValue: title,
                    style: GoogleFonts.mulish(
                      color: CusColors.header,
                      fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .04,
                        tablet: width * .029,
                        desktop: width * .028,
                      ),
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero),
                    keyboardType: TextInputType.text,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Enter an title';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      FirestoreService firestore =
                          FirestoreService(uid: user!.uid);

                      firestore.updateCourseEachField(
                        courseId: id,
                        fieldName: 'title',
                        data: value,
                      );
                    },
                  ),
                  TextFormField(
                    initialValue: description ?? '',
                    style: GoogleFonts.mulish(
                        color: CusColors.inactive,
                        fontSize: getValueForScreenType<double>(
                          context: context,
                          mobile: width * .02,
                          tablet: width * .017,
                          desktop: width * .012,
                        ),
                        fontWeight: FontWeight.w300,
                        height: 1.5),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      hintText: 'Enter an description',
                      hintStyle: GoogleFonts.mulish(
                          color: CusColors.inactive,
                          fontSize: getValueForScreenType<double>(
                            context: context,
                            mobile: width * .02,
                            tablet: width * .017,
                            desktop: width * .012,
                          ),
                          fontWeight: FontWeight.w300,
                          height: 1.5),
                    ),
                    keyboardType: TextInputType.text,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Enter an description';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      FirestoreService firestore =
                          FirestoreService(uid: user!.uid);
                      firestore.updateCourseEachField(
                        courseId: id,
                        fieldName: 'description',
                        data: value,
                      );
                    },
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
            child: image != null
                ? GestureDetector(
                    onTap: selectImageFromGallery,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.memory(image!, width: width / 2.7),
                            if (showSave)
                              Container(
                                width: width * .09,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF00C8FF),
                                    borderRadius: BorderRadius.circular(80),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(.25),
                                          spreadRadius: 0,
                                          blurRadius: 20,
                                          offset: const Offset(0, 4))
                                    ]),
                                child: ElevatedButton(
                                  onPressed: loading
                                      ? null
                                      : () async {
                                          await deleteExistingPhoto();
                                          await uploadToFirebase(image);
                                          FirestoreService firestore =
                                              FirestoreService(uid: user!.uid);
                                          firestore.updateCourseEachField(
                                              courseId: id,
                                              fieldName: 'image',
                                              data: downloadURL);
                                        },
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    shadowColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                  ),
                                  child: loading
                                      ? const CircularProgressIndicator()
                                      : Text(
                                          'Save Image',
                                          style: GoogleFonts.mulish(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                            fontSize: width * 0.01,
                                          ),
                                        ),
                                ),
                              ),
                          ],
                        )),
                  )
                : courseImage != ''
                    ? GestureDetector(
                        onTap: selectImageFromGallery,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(courseImage!,
                                width: width / 2.7)),
                      )
                    : GestureDetector(
                        onTap: selectImageFromGallery,
                        child: Container(
                          width: 300,
                          height: 300,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey, style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(15)),
                          child: const Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.grey,
                            size: 72,
                          ),
                        ),
                      ),
          ),
        ),
      ],
    );
  }

  Widget _headerMobile(width,
      {String? courseCategory,
      String? title,
      String? courseImage,
      String? description}) {
    return Column(
      children: [
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                courseImage != ''
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child:
                            Image.network(courseImage!, width: double.infinity),
                      )
                    : Container(
                        width: width / 2.7,
                        height: 200,
                        color: Colors.grey,
                      ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        courseCategory!,
                        style: GoogleFonts.mulish(
                          color: CusColors.accentBlue,
                          fontSize: width * .022,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          title!,
                          style: GoogleFonts.mulish(
                              color: CusColors.header,
                              fontSize: width * .04,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        description ?? '',
                        style: GoogleFonts.mulish(
                            color: CusColors.inactive,
                            fontSize: width * .022,
                            fontWeight: FontWeight.w300,
                            height: 1.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
