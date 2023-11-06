import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/components/static/help_data.dart';
import 'package:project_tc/services/function.dart';

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
                  'Help',
                  style: GoogleFonts.poppins(
                    fontSize: width * .014,
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
                          fontSize: width * .011,
                          color: CusColors.text),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                const HelpList(),
                const SizedBox(
                  height: 100,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contact Us',
                      style: GoogleFonts.poppins(
                        fontSize: width * .015,
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
                              height: 30,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Chat us',
                              style: GoogleFonts.poppins(
                                color: CusColors.subHeader,
                                fontSize: width * .01,
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
                          const Icon(
                            IconlyLight.call,
                            size: 30,
                            color: Color(0xFF0081FE),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            '+62-21-7721-0358',
                            style: GoogleFonts.poppins(
                              color: CusColors.subHeader,
                              fontSize: width * .01,
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
                            const Icon(
                              IconlyLight.message,
                              size: 30,
                              color: Color(0xFF0081FE),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Email us',
                              style: GoogleFonts.poppins(
                                color: CusColors.subHeader,
                                fontSize: width * .01,
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
                  padding: const EdgeInsets.symmetric(vertical: 15),
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
                                fontSize: width * .011,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          expandStates[index]!
                              ? const Icon(Icons.keyboard_arrow_up)
                              : const Icon(Icons.keyboard_arrow_down)
                        ],
                      ),
                      if (expandStates[index]!)
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            helps[index].answer!,
                            style: GoogleFonts.poppins(
                              color: CusColors.subHeader,
                              fontSize: width * .01,
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
