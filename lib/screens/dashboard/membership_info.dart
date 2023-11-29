import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:get/get.dart";
import "package:google_fonts/google_fonts.dart";
import "package:project_tc/components/constants.dart";
import "package:project_tc/models/user.dart";
import "package:project_tc/routes/routes.dart";
import "package:project_tc/services/extension.dart";
import "package:responsive_builder/responsive_builder.dart";

class MembershipInfo extends StatefulWidget {
  final MembershipModel membershipData;
  const MembershipInfo({super.key, required this.membershipData});

  @override
  State<MembershipInfo> createState() => _MembershipInfoState();
}

class _MembershipInfoState extends State<MembershipInfo> {
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
                          onTap: () => Get.rootDelegate.offNamed(routeSettings),
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
                      'My Membership',
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
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.white,
                    border: Border.all(
                      color: const Color(0xFFCCCCCC),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 15,
                          bottom: getValueForScreenType<double>(
                            context: context,
                            mobile: 30,
                            tablet: 35,
                            desktop: 50,
                          ),
                        ),
                        child: Text(
                          'Information',
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
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Membership type',
                                style: GoogleFonts.poppins(
                                  fontSize: getValueForScreenType<double>(
                                    context: context,
                                    mobile: width * .020,
                                    tablet: width * .017,
                                    desktop: width * .012,
                                  ),
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF1F384C),
                                ),
                              ),
                              SvgPicture.asset(
                                'assets/svg/member_type.svg',
                                height: getValueForScreenType<double>(
                                  context: context,
                                  mobile: 100,
                                  tablet: 115,
                                  desktop: 130,
                                ),
                              ),
                              Text(
                                widget.membershipData.memberType,
                                style: GoogleFonts.poppins(
                                  fontSize: getValueForScreenType<double>(
                                    context: context,
                                    mobile: width * .021,
                                    tablet: width * .018,
                                    desktop: width * .013,
                                  ),
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF1F384C),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          Column(
                            children: [
                              Text(
                                'Join since',
                                style: GoogleFonts.poppins(
                                  fontSize: getValueForScreenType<double>(
                                    context: context,
                                    mobile: width * .020,
                                    tablet: width * .017,
                                    desktop: width * .012,
                                  ),
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF1F384C),
                                ),
                              ),
                              SvgPicture.asset(
                                'assets/svg/join_since.svg',
                                height: getValueForScreenType<double>(
                                  context: context,
                                  mobile: 100,
                                  tablet: 115,
                                  desktop: 130,
                                ),
                              ),
                              Text(
                                widget.membershipData.joinSince.formatDate(),
                                style: GoogleFonts.poppins(
                                  fontSize: getValueForScreenType<double>(
                                    context: context,
                                    mobile: width * .021,
                                    tablet: width * .018,
                                    desktop: width * .013,
                                  ),
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF1F384C),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30, bottom: 20),
                        height: getValueForScreenType<double>(
                          context: context,
                          mobile: 26,
                          tablet: 33,
                          desktop: 40,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF86B1F2),
                          borderRadius: BorderRadius.circular(64),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Get.rootDelegate.toNamed(routeMembershipUpgrade);
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
                            'Upgrade Membership',
                            style: GoogleFonts.mulish(
                              fontWeight: FontWeight.w500,
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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
