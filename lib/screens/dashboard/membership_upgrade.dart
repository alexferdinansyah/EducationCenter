import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/routes/routes.dart';
import 'package:project_tc/screens/dashboard/dashboard_app.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MembershipUpgrade extends StatefulWidget {
  final MembershipModel membershipData;
  const MembershipUpgrade({super.key, required this.membershipData});

  @override
  State<MembershipUpgrade> createState() => _MembershipUpgradeState();
}

class _MembershipUpgradeState extends State<MembershipUpgrade> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: getValueForScreenType<double>(
        context: context,
        mobile: width * .86,
        tablet: width * .79,
        desktop: width * .83,
      ),
      height: getValueForScreenType<double>(
        context: context,
        mobile: height - 40,
        tablet: height - 50,
        desktop: height - 60,
      ),
      color: CusColors.bg,
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getValueForScreenType<double>(
                context: context,
                mobile: 20,
                tablet: 30,
                desktop: 40,
              ),
              vertical: getValueForScreenType<double>(
                context: context,
                mobile: 20,
                tablet: 30,
                desktop: 35,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: GestureDetector(
                          onTap: () => Get.off(
                              DashboardApp(selected: 'Membership'),
                              routeName: routeMembershipInfo),
                          child: const Icon(Icons.arrow_back_rounded)),
                    ),
                    Text(
                      'Membership Upgrade',
                      style: GoogleFonts.poppins(
                        fontSize: width * .014,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF1F384C),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Choose Membership Type',
                          style: GoogleFonts.poppins(
                            fontSize: width * .013,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF1F384C),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 30),
                          child: Text(
                            'Upgrade your membership to gains more courses',
                            style: GoogleFonts.poppins(
                              fontSize: width * .011,
                              fontWeight: FontWeight.w400,
                              color: CusColors.sidebarInactive,
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: width / 5,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 30),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                      color: const Color(0xFF14142B)
                                          .withOpacity(.08),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svg/basic_plan.svg',
                                          height: 60,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'For Starter',
                                                style: GoogleFonts.poppins(
                                                  fontSize: width * .01,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      const Color(0xFF6F6C90),
                                                ),
                                              ),
                                              Text(
                                                'Basic',
                                                style: GoogleFonts.poppins(
                                                  fontSize: width * .012,
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      const Color(0xFF170F49),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Text(
                                        'Welcome to our website, please enjoy your free content',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                          fontSize: width * .01,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF6F6C90),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, bottom: 20),
                                      child: Text(
                                        'Rp 0',
                                        style: GoogleFonts.poppins(
                                          fontSize: width * .02,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF170F49),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Text(
                                        "What's included",
                                        style: GoogleFonts.poppins(
                                          fontSize: width * .009,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF170F49),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.check_circle,
                                          color: Color(0xFF4351FF),
                                        ),
                                        Text(
                                          "First 3 videos free",
                                          style: GoogleFonts.poppins(
                                            fontSize: width * .009,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF170F49),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.check_circle,
                                          color: Color(0xFF4351FF),
                                        ),
                                        Text(
                                          "Lifetime courses",
                                          style: GoogleFonts.poppins(
                                            fontSize: width * .009,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF170F49),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.check_circle,
                                          color: Color(0xFF4351FF),
                                        ),
                                        Text(
                                          "Normal support",
                                          style: GoogleFonts.poppins(
                                            fontSize: width * .009,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF170F49),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        widget.membershipData.memberType ==
                                                'Basic'
                                            ? Text(
                                                'Current Membership',
                                                style: GoogleFonts.poppins(
                                                  fontSize: width * .01,
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      const Color(0xFF4351FF),
                                                ),
                                              )
                                            : Text(
                                                'Already join pro member',
                                                style: GoogleFonts.poppins(
                                                  fontSize: width * .01,
                                                  fontWeight: FontWeight.w600,
                                                  color: CusColors.inactive,
                                                ),
                                              )
                                      ],
                                    ),
                                  ]),
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            Container(
                              width: width / 5,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 30),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                      color: const Color(0xFF14142B)
                                          .withOpacity(.08),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svg/pro_plan.svg',
                                          height: 60,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'For Serious',
                                                style: GoogleFonts.poppins(
                                                  fontSize: width * .01,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      const Color(0xFF6F6C90),
                                                ),
                                              ),
                                              Text(
                                                'Pro',
                                                style: GoogleFonts.poppins(
                                                  fontSize: width * .012,
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      const Color(0xFF170F49),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Text(
                                        'Join our pro member for more advantage',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                          fontSize: width * .01,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF6F6C90),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, bottom: 20),
                                      child: Text(
                                        'Rp 35,000',
                                        style: GoogleFonts.poppins(
                                          fontSize: width * .02,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF170F49),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Text(
                                        "What's included",
                                        style: GoogleFonts.poppins(
                                          fontSize: width * .009,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF170F49),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.check_circle,
                                          color: Color(0xFF4351FF),
                                        ),
                                        Text(
                                          "Paid tutorial",
                                          style: GoogleFonts.poppins(
                                            fontSize: width * .009,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF170F49),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.check_circle,
                                          color: Color(0xFF4351FF),
                                        ),
                                        Text(
                                          "Lifetime courses",
                                          style: GoogleFonts.poppins(
                                            fontSize: width * .009,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF170F49),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.check_circle,
                                          color: Color(0xFF4351FF),
                                        ),
                                        Text(
                                          "Pro support",
                                          style: GoogleFonts.poppins(
                                            fontSize: width * .009,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF170F49),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.check_circle,
                                          color: Color(0xFF4351FF),
                                        ),
                                        Text(
                                          "Plus two free videos",
                                          style: GoogleFonts.poppins(
                                            fontSize: width * .009,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF170F49),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.check_circle,
                                          color: Color(0xFF4351FF),
                                        ),
                                        Text(
                                          "Discount up to 10-20%",
                                          style: GoogleFonts.poppins(
                                            fontSize: width * .009,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF170F49),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    SizedBox(
                                      height:
                                          widget.membershipData.memberType !=
                                                  'Basic'
                                              ? 25
                                              : 10,
                                    ),
                                    widget.membershipData.memberType != 'Basic'
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Current Membership',
                                                style: GoogleFonts.poppins(
                                                  fontSize: width * .01,
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      const Color(0xFF4351FF),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF4351FF),
                                              borderRadius:
                                                  BorderRadius.circular(64),
                                            ),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Get.to(
                                                    () => DashboardApp(
                                                          selected:
                                                              'Membership-Payment',
                                                          optionalSelected:
                                                              'Settings',
                                                        ),
                                                    routeName:
                                                        'membership-upgrade-payment');
                                              },
                                              style: ButtonStyle(
                                                shape:
                                                    MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                                padding: MaterialStateProperty
                                                    .all<EdgeInsetsGeometry>(
                                                  EdgeInsets.symmetric(
                                                    vertical: height * 0.015,
                                                  ),
                                                ),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.transparent),
                                                shadowColor:
                                                    MaterialStateProperty.all(
                                                        Colors.transparent),
                                              ),
                                              child: Text(
                                                'Get started',
                                                style: GoogleFonts.mulish(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                  fontSize: width * 0.01,
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
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
