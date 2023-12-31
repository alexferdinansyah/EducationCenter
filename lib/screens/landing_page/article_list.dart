import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/animation/animation_function.dart';
import 'package:project_tc/components/articles.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/components/footer.dart';
import 'package:project_tc/components/static/article_data.dart';

class ArticleList extends StatelessWidget {
  const ArticleList({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: width / 1.6,
                height: height * .62 * articles.length + 150,
                child: LiveList(
                  showItemInterval: const Duration(milliseconds: 150),
                  showItemDuration: const Duration(milliseconds: 350),
                  scrollDirection: Axis.vertical,
                  itemCount: articles.length,
                  itemBuilder: animationBuilder(
                    (index) => ArticleLists(
                      article: articles[index],
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Container(
                width: width / 4.5,
                height: 500,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                margin: const EdgeInsets.symmetric(vertical: 20),
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
                      const CusSearchBar(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          'Categories',
                          style: GoogleFonts.mulish(
                              color: CusColors.title,
                              fontSize: width * .014,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              'UI/UX',
                              style: GoogleFonts.mulish(
                                color: CusColors.secondaryText,
                                fontSize: width * .011,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              'Front-end developer',
                              style: GoogleFonts.mulish(
                                color: CusColors.secondaryText,
                                fontSize: width * .011,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              'Back-end developer',
                              style: GoogleFonts.mulish(
                                color: CusColors.secondaryText,
                                fontSize: width * .011,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              'Database',
                              style: GoogleFonts.mulish(
                                color: CusColors.secondaryText,
                                fontSize: width * .011,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      )
                    ]),
              ),
            ],
          ),
        ),
        const Footer()
      ],
    );
  }
}
