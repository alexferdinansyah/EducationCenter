import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/components/coupon_redeem.dart';
import 'package:project_tc/components/reset_password.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/routes/routes.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Settings extends StatefulWidget {
  final UserModel user;
  const Settings({super.key, required this.user});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
                SizedBox(
                  height: height - 300,
                  width: double.infinity,
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context)
                        .copyWith(scrollbars: false),
                    child: MasonryGridView.count(
                      physics:
                          const ScrollPhysics(parent: BouncingScrollPhysics()),
                      crossAxisSpacing: width *
                          .02, // Adjust spacing between items horizontally
                      mainAxisSpacing:
                          16.0, // Adjust spacing between rows vertically
                      crossAxisCount: getValueForScreenType<int>(
                        context: context,
                        mobile: 2,
                        tablet: 3,
                        desktop: 4,
                      ),
                      itemCount: widget.user.verifiedEmail ? 4 : 5,
                      itemBuilder: (BuildContext context, int index) {
                        return SettingList(
                          setting: settingLists[index],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Setting {
  final String title;
  final String image;
  final String desc;
  final String buttonText;
  final Function onTap;

  Setting({
    required this.title,
    required this.image,
    required this.desc,
    required this.buttonText,
    required this.onTap,
  });
}

List<Setting> settingLists = [
  Setting(
    title: 'My Profile',
    image: 'assets/svg/Profile.svg',
    desc: 'Edit your profile',
    buttonText: 'Edit Profile',
    onTap: () {
      Get.rootDelegate.toNamed(routeEditProfile);
    },
  ),
  Setting(
    title: 'Membership',
    image: 'assets/svg/Wallet.svg',
    desc: 'See your membership status',
    buttonText: 'See Now',
    onTap: () {
      Get.rootDelegate.toNamed(routeMembershipInfo);
    },
  ),
  Setting(
    title: 'Reset Password',
    image: 'assets/svg/Password.svg',
    desc: 'Change your password',
    buttonText: 'Send Now',
    onTap: () {
      showDialog(
        context: Get.context!,
        builder: (_) {
          return const ResetPasswordDialog();
        },
      );
    },
  ),
  Setting(
    title: 'Redeem Code',
    image: 'assets/svg/Ticket.svg',
    desc: 'Redeem code to get reward',
    buttonText: 'Redeem Now',
    onTap: () {
      showDialog(
        context: Get.context!,
        builder: (_) {
          return const CouponRedeem(
            isProductCoupon: true,
          );
        },
      );
    },
  ),
  Setting(
    title: 'Verify Account',
    image: 'assets/svg/Message.svg',
    desc: 'Verify your account for benefits',
    buttonText: 'Verify Now',
    onTap: () {
      Get.rootDelegate.toNamed(routeConfirmEmail);
    },
  ),
];

class SettingList extends StatelessWidget {
  final Setting setting;
  const SettingList({super.key, required this.setting});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: width * .18,
      padding: EdgeInsets.fromLTRB(
          getValueForScreenType<double>(
            context: context,
            mobile: 15,
            tablet: 20,
            desktop: 25,
          ),
          getValueForScreenType<double>(
            context: context,
            mobile: 10,
            tablet: 15,
            desktop: 20,
          ),
          getValueForScreenType<double>(
            context: context,
            mobile: 15,
            tablet: 20,
            desktop: 25,
          ),
          10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          getValueForScreenType<double>(
            context: context,
            mobile: 16,
            tablet: 20,
            desktop: 25,
          ),
        ),
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFCCCCCC),
          width: 1,
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SvgPicture.asset(
          setting.image,
          height: getValueForScreenType<double>(
            context: context,
            mobile: 42,
            tablet: 50,
            desktop: 64,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: getValueForScreenType<double>(
              context: context,
              mobile: 8,
              tablet: 10,
              desktop: 15,
            ),
            bottom: getValueForScreenType<double>(
              context: context,
              mobile: 6,
              tablet: 8,
              desktop: 10,
            ),
          ),
          child: Text(
            setting.title,
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
        ),
        Text(
          setting.desc,
          style: GoogleFonts.poppins(
            fontSize: getValueForScreenType<double>(
              context: context,
              mobile: width * .017,
              tablet: width * .014,
              desktop: width * .009,
            ),
            fontWeight: FontWeight.w400,
            color: const Color(0xFF7d848c),
          ),
        ),
        Container(
            width: double.infinity,
            height: 1,
            margin: EdgeInsets.symmetric(vertical: height * .012),
            decoration: const BoxDecoration(
              color: Color(0xFFCCCCCC),
            )),
        Container(
          width: double.infinity,
          height: getValueForScreenType<double>(
            context: context,
            mobile: 26,
            tablet: 33,
            desktop: 38,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF86B1F2),
            borderRadius: BorderRadius.circular(64),
          ),
          child: ElevatedButton(
            onPressed: () {
              setting.onTap();
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              shadowColor: MaterialStateProperty.all(Colors.transparent),
            ),
            child: Text(
              setting.buttonText,
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
      ]),
    );
  }
}
