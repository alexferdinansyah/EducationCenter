import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/components/footer.dart';
import 'package:project_tc/services/function.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  String? name;
  String? email;
  String? message;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Text(
                  'Contact Us',
                  style: GoogleFonts.poppins(
                    fontSize: getValueForScreenType<double>(
                      context: context,
                      mobile: width * .03,
                      tablet: width * .024,
                      desktop: width * .02,
                    ),
                    fontWeight: FontWeight.w700,
                    color: CusColors.text,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 30),
                child: Text(
                  'Any question or remarks? Just write us a message!',
                  style: GoogleFonts.poppins(
                    fontSize: getValueForScreenType<double>(
                      context: context,
                      mobile: width * .018,
                      tablet: width * .015,
                      desktop: width * .01,
                    ),
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF717171),
                  ),
                ),
              ),
              Container(
                width: width * .9,
                padding: EdgeInsets.all(
                  getValueForScreenType<double>(
                    context: context,
                    mobile: 20,
                    tablet: 20,
                    desktop: 30,
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.03),
                      blurRadius: 40,
                    )
                  ],
                  color: Colors.white,
                ),
                child: ResponsiveBuilder(
                  builder: (context, sizingInformation) {
                    // Check the sizing information here and return your UI
                    if (sizingInformation.deviceScreenType ==
                        DeviceScreenType.desktop) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _defaultContact(width, height, context),
                          const Spacer(),
                          _defaultForm(width, height, context)
                        ],
                      );
                    }
                    if (sizingInformation.deviceScreenType ==
                        DeviceScreenType.tablet) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _defaultContact(width, height, context),
                          const Spacer(),
                          _defaultForm(width, height, context)
                        ],
                      );
                    }
                    if (sizingInformation.deviceScreenType ==
                        DeviceScreenType.mobile) {
                      return Column(
                        children: [
                          _defaultContact(width, height, context),
                          _defaultForm(width, height, context)
                        ],
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      const SizedBox(
        height: 60,
      ),
      const Footer()
    ]);
  }

  Widget _defaultContact(width, height, context) {
    return Container(
      width: getValueForScreenType<double>(
        context: context,
        mobile: width / 1.5,
        tablet: width * .35,
        desktop: width * .35,
      ),
      padding: EdgeInsets.symmetric(
          horizontal: getValueForScreenType<double>(
            context: context,
            mobile: 15,
            tablet: 15,
            desktop: 30,
          ),
          vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFCCCCCC),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: getValueForScreenType<CrossAxisAlignment>(
          context: context,
          mobile: CrossAxisAlignment.center,
          tablet: CrossAxisAlignment.start,
          desktop: CrossAxisAlignment.start,
        ),
        children: [
          Text(
            'Contact Information',
            style: GoogleFonts.poppins(
              fontSize: getValueForScreenType<double>(
                context: context,
                mobile: width * .027,
                tablet: width * .021,
                desktop: width * .017,
              ),
              fontWeight: FontWeight.w600,
              color: CusColors.text,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Say something to start a live chat!',
            style: GoogleFonts.poppins(
              fontSize: getValueForScreenType<double>(
                context: context,
                mobile: width * .018,
                tablet: width * .015,
                desktop: width * .01,
              ),
              fontWeight: FontWeight.w400,
              color: CusColors.secondaryText,
            ),
          ),
          SizedBox(
            height: getValueForScreenType<double>(
              context: context,
              mobile: 20,
              tablet: 30,
              desktop: 50,
            ),
          ),
          Row(
            mainAxisAlignment: getValueForScreenType<MainAxisAlignment>(
              context: context,
              mobile: MainAxisAlignment.center,
              tablet: MainAxisAlignment.start,
              desktop: MainAxisAlignment.start,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.phone,
                  color: const Color(0xFF0081FE),
                  size: getValueForScreenType<double>(
                    context: context,
                    mobile: 15,
                    tablet: 20,
                    desktop: 25,
                  ),
                ),
              ),
              Text(
                '+62-21-7721-0358',
                style: GoogleFonts.assistant(
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF0A142F),
                  fontSize: getValueForScreenType<double>(
                    context: context,
                    mobile: width * .018,
                    tablet: width * .015,
                    desktop: width * .01,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: getValueForScreenType<double>(
                context: context,
                mobile: 10,
                tablet: 15,
                desktop: 25,
              ),
            ),
            child: Row(
              mainAxisAlignment: getValueForScreenType<MainAxisAlignment>(
                context: context,
                mobile: MainAxisAlignment.center,
                tablet: MainAxisAlignment.start,
                desktop: MainAxisAlignment.start,
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.mail,
                    color: const Color(0xFF0081FE),
                    size: getValueForScreenType<double>(
                      context: context,
                      mobile: 15,
                      tablet: 20,
                      desktop: 25,
                    ),
                  ),
                ),
                Text(
                  'info@dac-solution.com',
                  style: GoogleFonts.assistant(
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF0A142F),
                    fontSize: getValueForScreenType<double>(
                      context: context,
                      mobile: width * .018,
                      tablet: width * .015,
                      desktop: width * .01,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: getValueForScreenType<MainAxisAlignment>(
              context: context,
              mobile: MainAxisAlignment.center,
              tablet: MainAxisAlignment.start,
              desktop: MainAxisAlignment.start,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.location_on,
                  color: const Color(0xFF0081FE),
                  size: getValueForScreenType<double>(
                    context: context,
                    mobile: 15,
                    tablet: 20,
                    desktop: 25,
                  ),
                ),
              ),
              SizedBox(
                width: getValueForScreenType<double>(
                  context: context,
                  mobile: width * .34,
                  tablet: width * .23,
                  desktop: width * .24,
                ),
                child: Text(
                  'Jl. Karet Hijau no.52 Beji Timur,Depok - Jawa Barat 16421',
                  style: GoogleFonts.assistant(
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF0A142F),
                    fontSize: getValueForScreenType<double>(
                      context: context,
                      mobile: width * .018,
                      tablet: width * .015,
                      desktop: width * .01,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: getValueForScreenType<double>(
              context: context,
              mobile: 20,
              tablet: 40,
              desktop: 70,
            ),
          ),
          Row(
            mainAxisAlignment: getValueForScreenType<MainAxisAlignment>(
              context: context,
              mobile: MainAxisAlignment.center,
              tablet: MainAxisAlignment.start,
              desktop: MainAxisAlignment.start,
            ),
            children: [
              SvgPicture.asset(
                'assets/svg/facebook.svg',
                height: getValueForScreenType<double>(
                  context: context,
                  mobile: 15,
                  tablet: 20,
                  desktop: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: GestureDetector(
                  onTap: launchInstagram,
                  child: SvgPicture.asset(
                    'assets/svg/Instagram.svg',
                    height: getValueForScreenType<double>(
                      context: context,
                      mobile: 15,
                      tablet: 20,
                      desktop: 20,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                  onTap: launchWhatsapp,
                  child: SvgPicture.asset(
                    'assets/svg/whatsapp.svg',
                    height: getValueForScreenType<double>(
                      context: context,
                      mobile: 15,
                      tablet: 20,
                      desktop: 20,
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _defaultForm(width, height, context) {
    return Container(
      width: getValueForScreenType<double>(
        context: context,
        mobile: width / 1.5,
        tablet: width * .44,
        desktop: width * .48,
      ),
      padding: EdgeInsets.symmetric(
          horizontal: getValueForScreenType<double>(
            context: context,
            mobile: 10,
            tablet: 20,
            desktop: 30,
          ),
          vertical: 20),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextFormField(
              cursorColor: const Color(0xFF8D8D8D),
              style: GoogleFonts.poppins(
                fontSize: getValueForScreenType<double>(
                  context: context,
                  mobile: width * .019,
                  tablet: width * .016,
                  desktop: width * .011,
                ),
                fontWeight: FontWeight.w500,
                color: CusColors.subHeader,
              ),
              onChanged: (value) {
                name = value;
              },
              validator: (val) => val!.isEmpty ? 'Enter an name' : null,
              decoration: InputDecoration(
                label: Text(
                  'Name',
                  style: GoogleFonts.poppins(
                      fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .02,
                        tablet: width * .017,
                        desktop: width * .012,
                      ),
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF8D8D8D),
                      height: .01),
                ),
                hintText: 'Write your name',
                hintStyle: GoogleFonts.poppins(
                  fontSize: getValueForScreenType<double>(
                    context: context,
                    mobile: width * .019,
                    tablet: width * .016,
                    desktop: width * .011,
                  ),
                  fontWeight: FontWeight.w400,
                  color: CusColors.subHeader.withOpacity(.5),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF8D8D8D),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: TextFormField(
                cursorColor: const Color(0xFF8D8D8D),
                style: GoogleFonts.poppins(
                  fontSize: getValueForScreenType<double>(
                    context: context,
                    mobile: width * .019,
                    tablet: width * .016,
                    desktop: width * .011,
                  ),
                  fontWeight: FontWeight.w500,
                  color: CusColors.subHeader,
                ),
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                  label: Text(
                    'Email',
                    style: GoogleFonts.poppins(
                        fontSize: getValueForScreenType<double>(
                          context: context,
                          mobile: width * .02,
                          tablet: width * .017,
                          desktop: width * .012,
                        ),
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF8D8D8D),
                        height: .01),
                  ),
                  hintText: 'Write your email',
                  hintStyle: GoogleFonts.poppins(
                    fontSize: getValueForScreenType<double>(
                      context: context,
                      mobile: width * .019,
                      tablet: width * .016,
                      desktop: width * .011,
                    ),
                    fontWeight: FontWeight.w400,
                    color: CusColors.subHeader.withOpacity(.5),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF8D8D8D),
                    ),
                  ),
                ),
              ),
            ),
            TextFormField(
              cursorColor: const Color(0xFF8D8D8D),
              style: GoogleFonts.poppins(
                fontSize: getValueForScreenType<double>(
                  context: context,
                  mobile: width * .019,
                  tablet: width * .016,
                  desktop: width * .011,
                ),
                fontWeight: FontWeight.w500,
                color: CusColors.subHeader,
              ),
              onChanged: (value) {
                message = value;
              },
              validator: (val) => val!.isEmpty ? 'Enter an message' : null,
              onFieldSubmitted: (value) {
                launchEmailSubmission(name, value);
              },
              decoration: InputDecoration(
                label: Text(
                  'Message',
                  style: GoogleFonts.poppins(
                      fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .02,
                        tablet: width * .017,
                        desktop: width * .012,
                      ),
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF8D8D8D),
                      height: .01),
                ),
                hintText: 'Write your message',
                hintStyle: GoogleFonts.poppins(
                  fontSize: getValueForScreenType<double>(
                    context: context,
                    mobile: width * .019,
                    tablet: width * .016,
                    desktop: width * .011,
                  ),
                  fontWeight: FontWeight.w400,
                  color: CusColors.subHeader.withOpacity(.5),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF8D8D8D),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 40),
              height: getValueForScreenType<double>(
                context: context,
                mobile: 28,
                tablet: 35,
                desktop: 45,
              ),
              decoration: BoxDecoration(
                  color: const Color(0xFF00C8FF),
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(.25),
                        spreadRadius: 0,
                        blurRadius: 20,
                        offset: const Offset(0, 4))
                  ]),
              child: ElevatedButton(
                onPressed: () {
                  launchEmailSubmission(name, message);
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2))),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                    shadowColor: MaterialStateProperty.all(Colors.transparent)),
                child: Text(
                  'Send Message',
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
      ),
    );
  }

  void launchEmailSubmission(subject, body) async {
    final Uri params = Uri(
        scheme: 'mailto',
        path: 'support@dac-solution.com',
        queryParameters: {'subject': subject, 'body': body});
    if (await canLaunchUrl(params)) {
      await launchUrl(params);
    } else {
      print('error open mail $params');
    }
  }
}
