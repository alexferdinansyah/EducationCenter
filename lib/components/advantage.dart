import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/constants.dart';

class AdvantageModel {
  String? svg;
  String? title;

  AdvantageModel({required this.svg, required this.title});
}

List<AdvantageModel> advantage1 = [
  AdvantageModel(
    svg: 'assets/svg/access_content.svg',
    title: 'ACCESS CONTENT \n EVERYWHERE',
  ),
  AdvantageModel(
    svg: 'assets/svg/multiple_device.svg',
    title: 'SUPPORT MULTIPLE \n DEVICE',
  ),
  AdvantageModel(
    svg: 'assets/svg/study_case.svg',
    title: 'STUDY CASE & \n PROJECT',
  ),
];

List<AdvantageModel> advantage2 = [
  AdvantageModel(
    svg: 'assets/svg/certificate.svg',
    title: 'EARN \n CERTIFICATE',
  ),
  AdvantageModel(
    svg: 'assets/svg/affordable.svg',
    title: 'AFFORDABLE \n COURSE',
  ),
  AdvantageModel(
    svg: 'assets/svg/instructor.svg',
    title: 'EXPERIENCE \n INSTRUCTOR',
  ),
];

class Advantage extends StatelessWidget {
  final AdvantageModel advantage;
  const Advantage({super.key, required this.advantage});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.symmetric(vertical: height * .05),
      width: width / 7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFFE5E9F6).withOpacity(0.4),
              offset: const Offset(5, 20),
              blurRadius: 10)
        ],
        color: const Color(0xFFF6F7F9),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SvgPicture.asset(
          advantage.svg!,
          width: width * .04,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            advantage.title!,
            textAlign: TextAlign.center,
            style: GoogleFonts.mulish(
                color: CusColors.header,
                fontSize: width * .011,
                fontWeight: FontWeight.bold,
                height: 2),
          ),
        ),
      ]),
    );
  }
}
