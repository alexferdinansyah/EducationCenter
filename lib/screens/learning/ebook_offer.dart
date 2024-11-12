import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class EbookOffer extends StatelessWidget {
  final String price;
  final bool? isPaid;
  final String id;
  const EbookOffer({super.key, required this.price, this.isPaid, required this.id});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final user = Provider.of<UserModel?>(context);

    return Scaffold(
        body: ListView(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'E-Book',
                  style: GoogleFonts.poppins(
                    fontSize: getValueForScreenType(
                      context: context,
                      mobile: width * .022,
                      tablet: width * .02,
                      desktop: width * .015,
                    ),
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff1f384c),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 30),
                  child: Text(
                    'something',
                    style: GoogleFonts.poppins(
                      fontSize: getValueForScreenType(
                        context: context,
                        mobile: width * .018,
                        tablet: width * .016,
                        desktop: width * .011,
                      ),
                      fontWeight: FontWeight.w400,
                      color: CusColors.sidebarInactive,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: getValueForScreenType<double>(
                          context: context,
                          mobile: 15,
                          tablet: 20,
                          desktop: 25,
                        ),
                        vertical: getValueForScreenType<double>(
                          context: context,
                          mobile: 20,
                          tablet: 25,
                          desktop: 30,
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0xFF14142B).withOpacity(.08),
                              offset: const Offset(0, 2),
                              blurRadius: 12)
                        ],
                        color: Colors.white,
                        border: Border.all(
                          color: const Color(0xFFEFF0F6),
                          width: 1,
                        ),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/pro_plan.svg',
                                  height: getValueForScreenType<double>(
                                    context: context,
                                    mobile: 35,
                                    tablet: 40,
                                    desktop: 60,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    'Plus',
                                    style: GoogleFonts.poppins(
                                      fontSize: getValueForScreenType<double>(
                                        context: context,
                                        mobile: width * .020,
                                        tablet: width * .017,
                                        desktop: width * .012,
                                      ),
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF170F49),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: SizedBox(
                                width: getValueForScreenType<double>(
                                  context: context,
                                  mobile: width / 3.7,
                                  tablet: width / 5,
                                  desktop: width / 6,
                                ),
                                child: Text(
                                  'Unlock many benefits that can be obtained in the e-book',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontSize: getValueForScreenType<double>(
                                      context: context,
                                      mobile: width * .018,
                                      tablet: width * .015,
                                      desktop: width * .01,
                                    ),
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF6F6C90),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: getValueForScreenType<double>(
                                    context: context,
                                    mobile: 10,
                                    tablet: 13,
                                    desktop: 15,
                                  ),
                                  bottom: getValueForScreenType<double>(
                                    context: context,
                                    mobile: 12,
                                    tablet: 15,
                                    desktop: 20,
                                  )),
                              child: Text(
                                "Rp $price",
                                style: GoogleFonts.poppins(
                                  fontSize: getValueForScreenType<double>(
                                    context: context,
                                    mobile: width * .028,
                                    tablet: width * .025,
                                    desktop: width * .02,
                                  ),
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF170F49),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                "What's included",
                                style: GoogleFonts.poppins(
                                  fontSize: getValueForScreenType<double>(
                                    context: context,
                                    mobile: width * .017,
                                    tablet: width * .014,
                                    desktop: width * .009,
                                  ),
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF170F49),
                                ),
                              ),
                            ),
                            // Row(
                            //   children: [
                            //     Padding(
                            //       padding: const EdgeInsets.only(right: 3),
                            //       child: Icon(
                            //         Icons.check_circle,
                            //         color: const Color(0xFF4351FF),
                            //         size: getValueForScreenType<double>(
                            //           context: context,
                            //           mobile: 18,
                            //           tablet: 20,
                            //           desktop: 24,
                            //         ),
                            //       ),
                            //     ),
                            //     // Text(
                            //     //   "Unlock all video",
                            //     //   style: GoogleFonts.poppins(
                            //     //     fontSize: getValueForScreenType<double>(
                            //     //       context: context,
                            //     //       mobile: width * .017,
                            //     //       tablet: width * .014,
                            //     //       desktop: width * .009,
                            //     //     ),
                            //     //     fontWeight: FontWeight.w500,
                            //     //     color: const Color(0xFF170F49),
                            //     //   ),
                            //     // ),
                            //   ],
                            // ),
                            SizedBox(
                              height: getValueForScreenType<double>(
                                context: context,
                                mobile: 4,
                                tablet: 5,
                                desktop: 8,
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 3),
                                  child: Icon(
                                    Icons.check_circle,
                                    color: const Color(0xFF4351FF),
                                    size: getValueForScreenType<double>(
                                      context: context,
                                      mobile: 18,
                                      tablet: 20,
                                      desktop: 24,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Lifetime ebook",
                                  style: GoogleFonts.poppins(
                                    fontSize: getValueForScreenType<double>(
                                      context: context,
                                      mobile: width * .017,
                                      tablet: width * .014,
                                      desktop: width * .009,
                                    ),
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF170F49),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: getValueForScreenType<double>(
                                context: context,
                                mobile: 4,
                                tablet: 5,
                                desktop: 8,
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 3),
                                  child: Icon(
                                    Icons.check_circle,
                                    color: const Color(0xFF4351FF),
                                    size: getValueForScreenType<double>(
                                      context: context,
                                      mobile: 18,
                                      tablet: 20,
                                      desktop: 24,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Get certificate ",
                                  style: GoogleFonts.poppins(
                                    fontSize: getValueForScreenType<double>(
                                      context: context,
                                      mobile: width * .017,
                                      tablet: width * .014,
                                      desktop: width * .009,
                                    ),
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF170F49),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: getValueForScreenType<double>(
                                context: context,
                                mobile: 15,
                                tablet: 20,
                                desktop: 25,
                              ),
                            ),
                            Container(
                              width: getValueForScreenType<double>(
                                context: context,
                                mobile: width / 3.7,
                                tablet: width / 5,
                                desktop: width / 6,
                              ),
                              height: getValueForScreenType<double>(
                                context: context,
                                mobile: 28,
                                tablet: 35,
                                desktop: 45,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF4351FF),
                                borderRadius: BorderRadius.circular(64),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  // Get.rootDelegate.toNamed(routeLearnEBook,
                                  
                                  Get.rootDelegate.toNamed(routeBuyEbook,
                                      parameters: {'id': id});
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
                                child: Text(
                                  'Start Learning & benefits',
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
                          ]),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      )
    ]));
  }
}