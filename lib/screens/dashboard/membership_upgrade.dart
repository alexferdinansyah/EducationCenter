import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/routes/routes.dart';
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
                          onTap: () =>
                              Get.rootDelegate.offNamed(routeMembershipInfo),
                          child: Icon(
                            Icons.arrow_back_rounded,
                            size: getValueForScreenType<double>(
                              context: context,
                              mobile: 18,
                              tablet: 22,
                              desktop: 24,
                            ),
                          )),
                    ),
                    Text(
                      'Membership Upgrade',
                      style: GoogleFonts.poppins(
                        fontSize: getValueForScreenType<double>(
                          context: context,
                          mobile: width * .021,
                          tablet: width * .019,
                          desktop: width * .014,
                        ),
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF1F384C),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: getValueForScreenType<double>(
                    context: context,
                    mobile: 30,
                    tablet: 35,
                    desktop: 50,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Choose Membership Type',
                          style: GoogleFonts.poppins(
                            fontSize: getValueForScreenType<double>(
                              context: context,
                              mobile: width * .021,
                              tablet: width * .018,
                              desktop: width * .013,
                            ),
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF1F384C),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 30),
                          child: Text(
                            'Upgrade your membership to gains more courses',
                            style: GoogleFonts.poppins(
                              fontSize: getValueForScreenType<double>(
                                context: context,
                                mobile: width * .019,
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
                                          height: getValueForScreenType<double>(
                                            context: context,
                                            mobile: 35,
                                            tablet: 40,
                                            desktop: 60,
                                          ),
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
                                                  fontSize:
                                                      getValueForScreenType<
                                                          double>(
                                                    context: context,
                                                    mobile: width * .018,
                                                    tablet: width * .015,
                                                    desktop: width * .01,
                                                  ),
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      const Color(0xFF6F6C90),
                                                ),
                                              ),
                                              Text(
                                                'Basic',
                                                style: GoogleFonts.poppins(
                                                  fontSize:
                                                      getValueForScreenType<
                                                          double>(
                                                    context: context,
                                                    mobile: width * .020,
                                                    tablet: width * .017,
                                                    desktop: width * .012,
                                                  ),
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
                                      child: SizedBox(
                                        width: getValueForScreenType<double>(
                                          context: context,
                                          mobile: width / 3.7,
                                          tablet: width / 5,
                                          desktop: width / 6,
                                        ),
                                        child: Text(
                                          'Welcome to our website, please enjoy your free content',
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                            fontSize:
                                                getValueForScreenType<double>(
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
                                        'Rp 0',
                                        style: GoogleFonts.poppins(
                                          fontSize:
                                              getValueForScreenType<double>(
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
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Text(
                                        "What's included",
                                        style: GoogleFonts.poppins(
                                          fontSize:
                                              getValueForScreenType<double>(
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
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 3),
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
                                          "First 3 videos free",
                                          style: GoogleFonts.poppins(
                                            fontSize:
                                                getValueForScreenType<double>(
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
                                          padding:
                                              const EdgeInsets.only(right: 3),
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
                                          "Lifetime courses",
                                          style: GoogleFonts.poppins(
                                            fontSize:
                                                getValueForScreenType<double>(
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
                                          padding:
                                              const EdgeInsets.only(right: 3),
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
                                          "Normal support",
                                          style: GoogleFonts.poppins(
                                            fontSize:
                                                getValueForScreenType<double>(
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
                                    SizedBox(
                                      height: getValueForScreenType<double>(
                                        context: context,
                                        mobile: 15,
                                        tablet: 20,
                                        desktop: 25,
                                      ),
                                    ),
                                    SizedBox(
                                      width: getValueForScreenType<double>(
                                        context: context,
                                        mobile: width / 3.7,
                                        tablet: width / 5,
                                        desktop: width / 6,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          widget.membershipData.memberType ==
                                                  'Basic'
                                              ? Text(
                                                  'Current Membership',
                                                  style: GoogleFonts.poppins(
                                                    fontSize:
                                                        getValueForScreenType<
                                                            double>(
                                                      context: context,
                                                      mobile: width * .018,
                                                      tablet: width * .015,
                                                      desktop: width * .01,
                                                    ),
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        const Color(0xFF4351FF),
                                                  ),
                                                )
                                              : Text(
                                                  'Already join pro member',
                                                  style: GoogleFonts.poppins(
                                                    fontSize:
                                                        getValueForScreenType<
                                                            double>(
                                                      context: context,
                                                      mobile: width * .018,
                                                      tablet: width * .015,
                                                      desktop: width * .01,
                                                    ),
                                                    fontWeight: FontWeight.w600,
                                                    color: CusColors.inactive,
                                                  ),
                                                )
                                        ],
                                      ),
                                    ),
                                  ]),
                            ),
                            SizedBox(
                              width: getValueForScreenType<double>(
                                context: context,
                                mobile: 20,
                                tablet: 30,
                                desktop: 40,
                              ),
                            ),
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
                                          height: getValueForScreenType<double>(
                                            context: context,
                                            mobile: 35,
                                            tablet: 40,
                                            desktop: 60,
                                          ),
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
                                                  fontSize:
                                                      getValueForScreenType<
                                                          double>(
                                                    context: context,
                                                    mobile: width * .018,
                                                    tablet: width * .015,
                                                    desktop: width * .01,
                                                  ),
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      const Color(0xFF6F6C90),
                                                ),
                                              ),
                                              Text(
                                                'Pro',
                                                style: GoogleFonts.poppins(
                                                  fontSize:
                                                      getValueForScreenType<
                                                          double>(
                                                    context: context,
                                                    mobile: width * .020,
                                                    tablet: width * .017,
                                                    desktop: width * .012,
                                                  ),
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
                                      child: SizedBox(
                                        width: getValueForScreenType<double>(
                                          context: context,
                                          mobile: width / 3.7,
                                          tablet: width / 5,
                                          desktop: width / 6,
                                        ),
                                        child: Text(
                                          'Join our pro member for more advantage',
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                            fontSize:
                                                getValueForScreenType<double>(
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
                                        'Rp 35,000',
                                        style: GoogleFonts.poppins(
                                          fontSize:
                                              getValueForScreenType<double>(
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
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Text(
                                        "What's included",
                                        style: GoogleFonts.poppins(
                                          fontSize:
                                              getValueForScreenType<double>(
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
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 3),
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
                                          "Paid tutorial",
                                          style: GoogleFonts.poppins(
                                            fontSize:
                                                getValueForScreenType<double>(
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
                                          padding:
                                              const EdgeInsets.only(right: 3),
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
                                          "Lifetime courses",
                                          style: GoogleFonts.poppins(
                                            fontSize:
                                                getValueForScreenType<double>(
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
                                          padding:
                                              const EdgeInsets.only(right: 3),
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
                                          "Pro support",
                                          style: GoogleFonts.poppins(
                                            fontSize:
                                                getValueForScreenType<double>(
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
                                          padding:
                                              const EdgeInsets.only(right: 3),
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
                                          "Plus two free videos",
                                          style: GoogleFonts.poppins(
                                            fontSize:
                                                getValueForScreenType<double>(
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
                                          padding:
                                              const EdgeInsets.only(right: 3),
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
                                          "Discount up to 10-20%",
                                          style: GoogleFonts.poppins(
                                            fontSize:
                                                getValueForScreenType<double>(
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
                                    SizedBox(
                                      height:
                                          widget.membershipData.memberType !=
                                                  'Basic'
                                              ? 25
                                              : 10,
                                    ),
                                    widget.membershipData.memberType != 'Basic'
                                        ? SizedBox(
                                            width:
                                                getValueForScreenType<double>(
                                              context: context,
                                              mobile: width / 3.7,
                                              tablet: width / 5,
                                              desktop: width / 6,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Current Membership',
                                                  style: GoogleFonts.poppins(
                                                    fontSize:
                                                        getValueForScreenType<
                                                            double>(
                                                      context: context,
                                                      mobile: width * .018,
                                                      tablet: width * .015,
                                                      desktop: width * .01,
                                                    ),
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        const Color(0xFF4351FF),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Container(
                                            width:
                                                getValueForScreenType<double>(
                                              context: context,
                                              mobile: width / 3.7,
                                              tablet: width / 5,
                                              desktop: width / 6,
                                            ),
                                            height:
                                                getValueForScreenType<double>(
                                              context: context,
                                              mobile: 26,
                                              tablet: 33,
                                              desktop: 40,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF4351FF),
                                              borderRadius:
                                                  BorderRadius.circular(64),
                                            ),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Get.rootDelegate.toNamed(
                                                    routeMembershipUpgradePayment);
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
                                                  fontSize:
                                                      getValueForScreenType<
                                                          double>(
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
