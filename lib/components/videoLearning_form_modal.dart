import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/models/learning.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/routes/routes.dart';
import 'package:project_tc/services/extension.dart';
import 'package:project_tc/services/firestore_service.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class VideolearningFormModal extends StatefulWidget {
  final VideoLearning? videoLearning;
  final String? videoLearningId;
  const VideolearningFormModal(
      {super.key, this.videoLearning, this.videoLearningId});

  @override
  State<VideolearningFormModal> createState() => _VideolearningFormModalState();
}

class _VideolearningFormModalState extends State<VideolearningFormModal> {
  final _formKey = GlobalKey<FormState>();

  String error = '';

  String? title;
  String? price;
  String? description;
  String image = '';

  @override
  void initState() {
    if (widget.videoLearningId != null) {
      setState(() {
        image = widget.videoLearning!.image!;
      });
    }
    super.initState();
  }

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
              widget.videoLearning == null
                  ? 'add Video Learning'
                  : 'Edit Video Learning',
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
                  initialValue: widget.videoLearningId != null
                      ? widget.videoLearning!.title
                      : '',
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
                    'Description',
                    style: GoogleFonts.poppins(
                      fontSize: width * .009,
                      fontWeight: FontWeight.w600,
                      color: CusColors.subHeader.withOpacity(0.5),
                    ),
                  ),
                ),
                TextFormField(
                  initialValue: widget.videoLearningId != null
                      ? widget.videoLearning!.description
                          ?.replaceAll('\\n', '\n')
                      : '',
                  minLines: 4,
                  maxLines: null,
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
                  textInputAction: TextInputAction.newline,
                  decoration: editProfileDecoration.copyWith(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: getValueForScreenType<double>(
                          context: context,
                          mobile: 13,
                          tablet: 15,
                          desktop: 16,
                        ),
                        horizontal: 18),
                    hintText: 'Enter an description',
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
                      return 'Enter an description';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    description = val;
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
                  initialValue: widget.videoLearningId != null
                      ? widget.videoLearning!.price
                      : '',
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
                )
              ],
            ),
          ),
        ),
      ),
      actions: [
        if (widget.videoLearning != null)
          SizedBox(
            height: getValueForScreenType<double>(
              context: context,
              mobile: 26,
              tablet: 33,
              desktop: 38,
            ),
            child: ElevatedButton(
              onPressed: () => Get.rootDelegate.toNamed(
                  routeAdminLearnVideolearning,
                  parameters: {'id': widget.videoLearningId!}),
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
                    const Color.fromARGB(255, 255, 230, 0),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 255, 230, 0),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  )),
              child: Text(
                'Edit learn video',
                style: GoogleFonts.poppins(
                  fontSize: getValueForScreenType<double>(
                    context: context,
                    mobile: width * .018,
                    tablet: width * .015,
                    desktop: width * .01,
                  ),
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
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
                if (widget.videoLearning != null) {
                  await firestore.updateVideoLearningFewField(
                    videoLearningId: widget.videoLearningId,
                    title: title ?? widget.videoLearning!.title,
                    price: price ?? widget.videoLearning!.price,
                    description:
                        description ?? widget.videoLearning!.description,
                    image: image,
                  );
                } else {
                  final VideoLearning data = VideoLearning(
                    image: '',
                    title: title,
                    price: price,
                    benefits: [],
                    isDraft: true,
                    chapterListvideo: [
                      ChapterListVideo(chapter: '', subChapter: [])
                    ],
                    description: description,
                  );

                  await firestore.addVideoLearning(data);
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
              widget.videoLearning != null ? 'save' : 'save as draf',
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
                if (widget.videoLearning != null) {
                  await firestore.updateVideoLearningFewField(
                    videoLearningId: widget.videoLearningId,
                    title: title ?? widget.videoLearning!.title,
                    price: price ?? widget.videoLearning!.price,
                    description:
                        description ?? widget.videoLearning!.description,
                    image: image,
                  );
                } else {
                  final VideoLearning data = VideoLearning(
                    image: '',
                    title: title,
                    price: price,
                    benefits: [],
                    description: description,
                    chapterListvideo: [
                      ChapterListVideo(chapter: '', subChapter: [])
                    ],
                    isDraft: true,
                  );

                  final result = await firestore.addVideoLearning(data);
                  Get.rootDelegate.toNamed(routeAdminDetailVideoLearning,
                      parameters: {'id': result});
                }
                if (widget.videoLearningId != null) {
                  Get.rootDelegate.toNamed(routeAdminDetailVideoLearning,
                      parameters: {'id': widget.videoLearningId!});
                  ;
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
