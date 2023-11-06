import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/animation/animation_function.dart';
import 'package:project_tc/components/articles.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/components/footer.dart';
import 'package:project_tc/models/article.dart';
import 'package:project_tc/services/firestore_service.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ArticleList extends StatelessWidget {
  const ArticleList({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: getValueForScreenType<double>(
              context: context,
              mobile: 10,
              tablet: 50,
              desktop: 100,
            ),
          ),
          child: ResponsiveBuilder(
            builder: (context, sizingInformation) {
              // Check the sizing information here and return your UI
              if (sizingInformation.deviceScreenType ==
                  DeviceScreenType.desktop) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _articleList(width, height, context),
                    const Spacer(),
                    _defaultCategory(width, context)
                  ],
                );
              }
              if (sizingInformation.deviceScreenType ==
                  DeviceScreenType.tablet) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _articleList(width, height, context),
                    const Spacer(),
                    _defaultCategory(width, context)
                  ],
                );
              }
              if (sizingInformation.deviceScreenType ==
                  DeviceScreenType.mobile) {
                return Column(
                  children: [
                    Container(
                      width: width / 1.3,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
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
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 20,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Text(
                                      'UI/UX',
                                      style: GoogleFonts.mulish(
                                        color: CusColors.secondaryText,
                                        fontSize: width * .024,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Text(
                                      'Front-end developer',
                                      style: GoogleFonts.mulish(
                                        color: CusColors.secondaryText,
                                        fontSize: width * .024,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Text(
                                      'Back-end developer',
                                      style: GoogleFonts.mulish(
                                        color: CusColors.secondaryText,
                                        fontSize: width * .024,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Text(
                                      'Database',
                                      style: GoogleFonts.mulish(
                                        color: CusColors.secondaryText,
                                        fontSize: width * .024,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ]),
                    ),
                    _articleList(width, height, context)
                  ],
                );
              }
              return Container();
            },
          ),
        ),
        const Footer()
      ],
    );
  }

  Widget _articleList(width, height, context) {
    return StreamBuilder(
      stream: FirestoreService.withoutUID().allArticle,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          final List<Map> dataMaps = snapshot.data!;

          final List<Map> articles = dataMaps.where((articleData) {
            final dynamic data = articleData['article'];
            return data is Article;
          }).map((articleData) {
            final Article article = articleData['article'];
            final String id = articleData['id'];
            return {'article': article, 'id': id};
          }).toList();
          return SizedBox(
            width: getValueForScreenType<double>(
              context: context,
              mobile: width / 1.3,
              tablet: width / 1.6,
              desktop: width / 1.6,
            ),
            height: getValueForScreenType<double>(
              context: context,
              mobile: height * .64 * articles.length,
              tablet: height * .64 * articles.length + 150,
              desktop: height * .64 * articles.length + 150,
            ),
            child: LiveList(
              showItemInterval: const Duration(milliseconds: 150),
              showItemDuration: const Duration(milliseconds: 350),
              scrollDirection: Axis.vertical,
              itemCount: articles.length,
              itemBuilder: animationBuilder(
                (index) => ArticleLists(
                    article: articles[index]['article'],
                    id: articles[index]['id']),
              ),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No courses available.'),
          );
        } else {
          return const Center(
            child: Text('kok iso.'),
          );
        }
      },
    );
  }

  Widget _defaultCategory(width, context) {
    return Container(
      width: width / 4.5,
      height: 500,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFCCCCCC),
          width: 1,
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const CusSearchBar(),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: getValueForScreenType<double>(
              context: context,
              mobile: 10,
              tablet: 15,
              desktop: 20,
            ),
          ),
          child: Text(
            'Categories',
            style: GoogleFonts.mulish(
                color: CusColors.title,
                fontSize: getValueForScreenType<double>(
                  context: context,
                  mobile: width * .027,
                  tablet: width * .017,
                  desktop: width * .014,
                ),
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
                  fontSize: getValueForScreenType<double>(
                    context: context,
                    mobile: width * .024,
                    tablet: width * .014,
                    desktop: width * .011,
                  ),
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
                  fontSize: getValueForScreenType<double>(
                    context: context,
                    mobile: width * .024,
                    tablet: width * .014,
                    desktop: width * .011,
                  ),
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
                  fontSize: getValueForScreenType<double>(
                    context: context,
                    mobile: width * .024,
                    tablet: width * .014,
                    desktop: width * .011,
                  ),
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
                  fontSize: getValueForScreenType<double>(
                    context: context,
                    mobile: width * .024,
                    tablet: width * .014,
                    desktop: width * .011,
                  ),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        )
      ]),
    );
  }
}
