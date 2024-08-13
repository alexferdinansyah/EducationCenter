import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/components/static/help_data.dart';
import 'package:project_tc/services/function.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
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
                  'Help',
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
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Frequently Asked Questions',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: getValueForScreenType<double>(
                            context: context,
                            mobile: width * .019,
                            tablet: width * .016,
                            desktop: width * .011,
                          ),
                          color: CusColors.text),
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
                const HelpList(),
                SizedBox(
                  height: getValueForScreenType<double>(
                    context: context,
                    mobile: 40,
                    tablet: 70,
                    desktop: 100,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contact Us',
                      style: GoogleFonts.poppins(
                        fontSize: getValueForScreenType<double>(
                          context: context,
                          mobile: width * .023,
                          tablet: width * .02,
                          desktop: width * .015,
                        ),
                        fontWeight: FontWeight.w400,
                        color: CusColors.text,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.symmetric(
                          horizontal: BorderSide(
                              color: Colors.black.withOpacity(.2), width: .5),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: launchWhatsapp,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/svg/whatsapp.svg',
                              height: getValueForScreenType<double>(
                                context: context,
                                mobile: 20,
                                tablet: 25,
                                desktop: 30,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Chat us',
                              style: GoogleFonts.poppins(
                                color: CusColors.subHeader,
                                fontSize: getValueForScreenType<double>(
                                  context: context,
                                  mobile: width * .018,
                                  tablet: width * .015,
                                  desktop: width * .01,
                                ),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.symmetric(
                          horizontal: BorderSide(
                              color: Colors.black.withOpacity(.2), width: .5),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            IconlyLight.call,
                            size: getValueForScreenType<double>(
                              context: context,
                              mobile: 20,
                              tablet: 25,
                              desktop: 30,
                            ),
                            color: const Color(0xFF0081FE),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            '+62-21-7721-0358',
                            style: GoogleFonts.poppins(
                              color: CusColors.subHeader,
                              fontSize: getValueForScreenType<double>(
                                context: context,
                                mobile: width * .018,
                                tablet: width * .015,
                                desktop: width * .01,
                              ),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.symmetric(
                          horizontal: BorderSide(
                              color: Colors.black.withOpacity(.2), width: .5),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: launchEmail,
                        child: Row(
                          children: [
                            Icon(
                              IconlyLight.message,
                              size: getValueForScreenType<double>(
                                context: context,
                                mobile: 20,
                                tablet: 25,
                                desktop: 30,
                              ),
                              color: const Color(0xFF0081FE),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Email us',
                              style: GoogleFonts.poppins(
                                color: CusColors.subHeader,
                                fontSize: getValueForScreenType<double>(
                                  context: context,
                                  mobile: width * .018,
                                  tablet: width * .015,
                                  desktop: width * .01,
                                ),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
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

class HelpList extends StatefulWidget {
  const HelpList({super.key});

  @override
  State<HelpList> createState() => _HelpListState();
}

class _HelpListState extends State<HelpList> {
  Map<int, bool> expandStates = {};
  @override
  void initState() {
    super.initState();

    // Initialize expandStates with default values for all indices
    for (int i = 0; i < helps.length; i++) {
      expandStates[i] = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: List.generate(
          helps.length,
          (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  // Toggle the expand state for this item
                  expandStates[index] = !expandStates[index]!;
                });
              },
              child: AnimatedSize(
                duration: const Duration(microseconds: 1),
                curve: Curves.ease,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: getValueForScreenType<double>(
                      context: context,
                      mobile: 8,
                      tablet: 10,
                      desktop: 25,
                    ),
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(
                          color: Colors.black.withOpacity(.2), width: .5),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              helps[index].question!,
                              textAlign: TextAlign.left,
                              softWrap: true,
                              style: GoogleFonts.poppins(
                                color: CusColors.title,
                                fontSize: getValueForScreenType<double>(
                                  context: context,
                                  mobile: width * .019,
                                  tablet: width * .016,
                                  desktop: width * .011,
                                ),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          expandStates[index]!
                              ? Icon(
                                  Icons.keyboard_arrow_up,
                                  size: getValueForScreenType<double>(
                                    context: context,
                                    mobile: 18,
                                    tablet: 22,
                                    desktop: 24,
                                  ),
                                )
                              : Icon(
                                  Icons.keyboard_arrow_down,
                                  size: getValueForScreenType<double>(
                                    context: context,
                                    mobile: 18,
                                    tablet: 22,
                                    desktop: 24,
                                  ),
                                ),
                        ],
                      ),
                      if (expandStates[index]!)
                        Padding(
                          padding: EdgeInsets.only(
                            top: getValueForScreenType<double>(
                              context: context,
                              mobile: 10,
                              tablet: 15,
                              desktop: 20,
                            ),
                          ),
                          child: Text(
                            helps[index].answer!,
                            style: GoogleFonts.poppins(
                              color: CusColors.subHeader,
                              fontSize: getValueForScreenType<double>(
                                context: context,
                                mobile: width * .018,
                                tablet: width * .015,
                                desktop: width * .01,
                              ),
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
