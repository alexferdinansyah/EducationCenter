import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/models/learning.dart';
import 'package:project_tc/routes/routes.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:transparent_image/transparent_image.dart';

class Videolearnings extends StatelessWidget {
  final VideoLearning videoLearning;
  final String id;
  const Videolearnings(
      {super.key, required this.videoLearning, required this.id});

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
        child: Column(
          children: [
            videoLearning.image != ''
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: videoLearning.image!,
                    ),
                  )
                : const Text('no image'),
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
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height * .006),
                    child: Text(
                      videoLearning.title!,
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
                          'Rp ${videoLearning.price!}',
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
                        videoLearning.discount != ''
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
                                      '${videoLearning.discount}% Off',
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
                        Get.rootDelegate.toNamed(
                          routeDetailVideoLearning,
                          parameters: {'id': id},
                        );
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
                              'View Video Learning',
                              style: GoogleFonts.mulish(
                                fontWeight: FontWeight.w600,
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
                          ]),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ListVideoLearnings extends StatelessWidget {
  final ListLearningVideo listLearningVideo;
  final int index;
  const ListVideoLearnings(
      {super.key, required this.listLearningVideo, required this.index});

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
            decoration: listLearningVideo.image != ''
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(height * .03),
                    border: Border.all(
                      color: const Color(0xFF2501FF),
                      width: 1,
                    ),
                    image: DecorationImage(
                      image: NetworkImage(listLearningVideo.image!),
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
                  listLearningVideo.title!,
                  style: GoogleFonts.mulish(
                    color: CusColors.text,
                    fontSize: width * .014,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  listLearningVideo.description!,
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
            listLearningVideo.price!,
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

class MyVideoLearning extends StatelessWidget {
  final String id;
  final VideoLearning videoLearning;
  final bool? isPaid;
  final bool isAdmin;
  final Function()? onPressed;
  final Function()? onDelete;

  const MyVideoLearning(
      {super.key,
      required this.id,
      required this.videoLearning,
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
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            videoLearning.image != ''
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: videoLearning.image!,
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
                  Padding(
                    padding: EdgeInsets.only(top: height * .006),
                    child: Text(
                      videoLearning.title!,
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
                                    routeLearnVideo,
                                    parameters: {'id': id},
                                  );
                                } else {
                                  Get.rootDelegate.toNamed(
                                    routeOfferLearnVideo,
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
                              isAdmin
                                  ? 'Edit video learning'
                                  : 'Learn video learning',
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
          ],
        ),
      ),
    );
  }
}
