import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:get/get.dart";
import "package:google_fonts/google_fonts.dart";
import "package:project_tc/components/constants.dart";
import "package:project_tc/models/user.dart";
import "package:project_tc/screens/dashboard/dashboard_app.dart";
import "package:project_tc/services/extension.dart";

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
      width: width * .83,
      height: height - 60,
      color: CusColors.bg,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Membership',
                  style: GoogleFonts.poppins(
                    fontSize: width * .014,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1F384C),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  width: double.infinity,
                  height: height / 2,
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
                        padding: const EdgeInsets.only(top: 15, bottom: 50),
                        child: Text(
                          'Information',
                          style: GoogleFonts.poppins(
                            fontSize: width * .013,
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
                                  fontSize: width * .012,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF1F384C),
                                ),
                              ),
                              SvgPicture.asset('assets/svg/member_type.svg'),
                              Text(
                                widget.membershipData.memberType,
                                style: GoogleFonts.poppins(
                                  fontSize: width * .013,
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
                                  fontSize: width * .012,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF1F384C),
                                ),
                              ),
                              SvgPicture.asset('assets/svg/join_since.svg'),
                              Text(
                                widget.membershipData.joinSince.formatDate(),
                                style: GoogleFonts.poppins(
                                  fontSize: width * .013,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF1F384C),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        decoration: BoxDecoration(
                          color: const Color(0xFF86B1F2),
                          borderRadius: BorderRadius.circular(64),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(
                                () => DashboardApp(
                                      selected: 'Membership-Upgrade',
                                      optionalSelected: 'Settings',
                                    ),
                                routeName: 'membership-upgrade');
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.symmetric(
                                  vertical: height * 0.025,
                                  horizontal: width * .02),
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
                              fontSize: width * 0.01,
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
