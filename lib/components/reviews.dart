import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/models/review.dart';

class Reviews extends StatelessWidget {
  final Review review;
  const Reviews({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width / 5.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11),
        boxShadow: const [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              offset: Offset(0, 11),
              blurRadius: 11)
        ],
        color: const Color.fromRGBO(255, 255, 255, 1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 23),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: width * .06,
                  height: width * .06,
                  margin: EdgeInsets.only(bottom: height * .02),
                  decoration: const BoxDecoration(
                    color: Color(0xFFD9D9D9),
                    shape: BoxShape.circle,
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.star,
                color: Color(0xFF5D5DFF),
              ),
              Padding(
                padding: EdgeInsets.only(left: width * .002),
                child: Text(review.rating!,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.manrope(
                      color: CusColors.header,
                      fontSize: width * .012,
                      fontWeight: FontWeight.w800,
                    )),
              ),
            ],
          ),
          SizedBox(height: height * .02),
          Text(
            review.name!,
            textAlign: TextAlign.left,
            style: GoogleFonts.manrope(
              color: const Color(0xFF646464),
              fontSize: width * .014,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: height * .02),
          Text(review.description!,
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                  color: const Color(0xFF8C8C8C),
                  fontSize: width * .01,
                  fontWeight: FontWeight.normal,
                  height: 1.5)),
        ],
      ),
    );
  }
}
