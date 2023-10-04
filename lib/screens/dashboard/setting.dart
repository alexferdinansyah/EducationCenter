import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/screens/dashboard/dashboard_app.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
                  'Settings',
                  style: GoogleFonts.poppins(
                    fontSize: width * .014,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1F384C),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Container(
                      width: width * .18,
                      padding: const EdgeInsets.fromLTRB(25, 20, 25, 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white,
                        border: Border.all(
                          color: const Color(0xFFCCCCCC),
                          width: 1,
                        ),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset('assets/svg/Profile.svg'),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 15, bottom: 10),
                              child: Text(
                                'My Profile',
                                style: GoogleFonts.poppins(
                                  fontSize: width * .014,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF1F384C),
                                ),
                              ),
                            ),
                            Text(
                              'Edit your profile',
                              style: GoogleFonts.poppins(
                                fontSize: width * .009,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF7d848c),
                              ),
                            ),
                            Container(
                                width: double.infinity,
                                height: 1,
                                margin: EdgeInsets.symmetric(
                                    vertical: height * .012),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFCCCCCC),
                                )),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xFF86B1F2),
                                borderRadius: BorderRadius.circular(64),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.to(
                                      () => DashboardApp(
                                            selected: 'Edit-Profile',
                                            optionalSelected: 'Settings',
                                          ),
                                      routeName: 'edit-profile',
                                      popGesture: true);
                                },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry>(
                                    EdgeInsets.symmetric(
                                      vertical: height * 0.022,
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  shadowColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                ),
                                child: Text(
                                  'Edit Profile',
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
                    Container(
                      width: width * .18,
                      padding: const EdgeInsets.fromLTRB(25, 20, 25, 10),
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white,
                        border: Border.all(
                          color: const Color(0xFFCCCCCC),
                          width: 1,
                        ),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset('assets/svg/Wallet.svg'),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 15, bottom: 10),
                              child: Text(
                                'Membership',
                                style: GoogleFonts.poppins(
                                  fontSize: width * .014,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF1F384C),
                                ),
                              ),
                            ),
                            Text(
                              'See your membership status',
                              style: GoogleFonts.poppins(
                                fontSize: width * .009,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF7d848c),
                              ),
                            ),
                            Container(
                                width: double.infinity,
                                height: 1,
                                margin: EdgeInsets.symmetric(
                                    vertical: height * .012),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFCCCCCC),
                                )),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xFF86B1F2),
                                borderRadius: BorderRadius.circular(64),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.to(
                                      () => DashboardApp(
                                            selected: 'Membership',
                                            optionalSelected: 'Settings',
                                          ),
                                      routeName: 'membership-info');
                                },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry>(
                                    EdgeInsets.symmetric(
                                      vertical: height * 0.022,
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  shadowColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                ),
                                child: Text(
                                  'See Now',
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
                    Container(
                      width: width * .18,
                      padding: const EdgeInsets.fromLTRB(25, 20, 25, 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white,
                        border: Border.all(
                          color: const Color(0xFFCCCCCC),
                          width: 1,
                        ),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset('assets/svg/Password.svg'),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 15, bottom: 10),
                              child: Text(
                                'Reset Password',
                                style: GoogleFonts.poppins(
                                  fontSize: width * .014,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF1F384C),
                                ),
                              ),
                            ),
                            Text(
                              'Change your password',
                              style: GoogleFonts.poppins(
                                fontSize: width * .009,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF7d848c),
                              ),
                            ),
                            Container(
                                width: double.infinity,
                                height: 1,
                                margin: EdgeInsets.symmetric(
                                    vertical: height * .012),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFCCCCCC),
                                )),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xFF86B1F2),
                                borderRadius: BorderRadius.circular(64),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  // Get.to(() => DashboardApp(
                                  //       selected: 'Edit-Profile',
                                  //       optionalSelected: 'Settings',
                                  //     ));
                                },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry>(
                                    EdgeInsets.symmetric(
                                      vertical: height * 0.022,
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  shadowColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                ),
                                child: Text(
                                  'Send Now',
                                  style: GoogleFonts.mulish(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: width * 0.01,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    )
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