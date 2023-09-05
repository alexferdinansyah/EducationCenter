import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/models/article.dart';

class Articles extends StatelessWidget {
  final Article article;
  const Articles({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width / 4.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFCCCCCC),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            height: 28,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.transparent,
              border: Border.all(
                color: const Color(0xFF2501FF),
                width: 1,
              ),
            ),
            child: Text(
              'UI/UX',
              textAlign: TextAlign.center,
              style: GoogleFonts.mulish(
                  color: const Color(0xFF2501FF),
                  fontSize: width * .011,
                  fontWeight: FontWeight.bold,
                  height: 1.5),
            ),
          ),
          Container(
            width: double.infinity,
            height: 172,
            decoration: article.image != ''
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: const Color(0xFFD9D9D9),
                    image: DecorationImage(
                      image: AssetImage(article.image!),
                      fit: BoxFit.cover, // Adjust the fit as needed
                    ),
                  )
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: const Color(0xFFD9D9D9),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    article.title!,
                    style: GoogleFonts.mulish(
                        color: CusColors.title,
                        fontSize: width * .013,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  article.description!,
                  style: GoogleFonts.mulish(
                      color: CusColors.inactive,
                      fontSize: width * .01,
                      fontWeight: FontWeight.w300,
                      height: 1.5),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Read more...',
                    style: GoogleFonts.mulish(
                        color: const Color(0xFF86B1F2),
                        fontSize: width * .01,
                        fontWeight: FontWeight.w300,
                        height: 1.5),
                  ),
                ),
                Container(
                    width: double.infinity,
                    height: 1,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: const BoxDecoration(
                      color: Color(0xFFCCCCCC),
                    )),
                Text(
                  article.date!,
                  style: GoogleFonts.mulish(
                      color: const Color(0xFF828282),
                      fontSize: width * .01,
                      fontWeight: FontWeight.normal,
                      height: 1.5),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
