import "package:flutter/material.dart";
import "package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart";
import "package:get/get.dart";
import "package:google_fonts/google_fonts.dart";
import "package:project_tc/components/constants.dart";
import "package:project_tc/components/loading.dart";
import "package:project_tc/models/article.dart";
import "package:project_tc/routes/routes.dart";
import "package:project_tc/services/firestore_service.dart";
import 'package:project_tc/services/extension.dart';
import "package:responsive_builder/responsive_builder.dart";

class Newsflash extends StatefulWidget {
  const Newsflash({super.key});

  @override
  State<Newsflash> createState() => _NewsflashState();
}

class _NewsflashState extends State<Newsflash> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return StreamBuilder(
        stream: FirestoreService.withoutUID().allArticle,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Map> articles = [];
            final List<Map> dataMaps = snapshot.data!;
            final dataArticle = dataMaps
                .where((articleData) => articleData['article'].isDraft == false)
                .map((data) {
              return {
                'article': data['article'] as Article,
                'id': data['id'],
              };
            }).toList();

            articles = List.from(dataArticle);

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
                        Container(
                          width: double.infinity,
                          height: getValueForScreenType<double>(
                            context: context,
                            mobile: 35,
                            tablet: 40,
                            desktop: 56,
                          ),
                          margin: EdgeInsets.only(
                            bottom: getValueForScreenType<double>(
                              context: context,
                              mobile: 10,
                              tablet: 15,
                              desktop: 20,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                            color: Colors.white,
                            border: Border.all(
                              color: const Color(0xFFCCCCCC),
                              width: 1,
                            ),
                          ),
                          child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'UI/UX',
                                      style: GoogleFonts.poppins(
                                          fontSize:
                                              getValueForScreenType<double>(
                                            context: context,
                                            mobile: width * .018,
                                            tablet: width * .015,
                                            desktop: width * .01,
                                          ),
                                          fontWeight: FontWeight.w400,
                                          color: CusColors.secondaryText),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      'Front-end developer',
                                      style: GoogleFonts.poppins(
                                          fontSize:
                                              getValueForScreenType<double>(
                                            context: context,
                                            mobile: width * .018,
                                            tablet: width * .015,
                                            desktop: width * .01,
                                          ),
                                          fontWeight: FontWeight.w400,
                                          color: CusColors.secondaryText),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      'Back-end developer',
                                      style: GoogleFonts.poppins(
                                          fontSize:
                                              getValueForScreenType<double>(
                                            context: context,
                                            mobile: width * .018,
                                            tablet: width * .015,
                                            desktop: width * .01,
                                          ),
                                          fontWeight: FontWeight.w400,
                                          color: CusColors.secondaryText),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      'Database',
                                      style: GoogleFonts.poppins(
                                          fontSize:
                                              getValueForScreenType<double>(
                                            context: context,
                                            mobile: width * .018,
                                            tablet: width * .015,
                                            desktop: width * .01,
                                          ),
                                          fontWeight: FontWeight.w400,
                                          color: CusColors.secondaryText),
                                    ),
                                  ],
                                )
                              ]),
                        ),
                        SizedBox(
                          height: height - 100,
                          width: double.infinity,
                          child: ScrollConfiguration(
                            behavior: ScrollConfiguration.of(context)
                                .copyWith(scrollbars: false),
                            child: StaggeredGrid.count(
                              crossAxisCount: getValueForScreenType<int>(
                                context: context,
                                mobile: 2,
                                tablet: 3,
                                desktop: 4,
                              ),
                              children: articles.asMap().entries.map((entry) {
                                final index = entry.key;
                                final article = entry.value;

                                bool isFullscreen =
                                    index % 10 == 0 || (index - 9) % 10 == 0
                                        ? true
                                        : false;

                                return StaggeredGridTile.fit(
                                  crossAxisCellCount: isFullscreen ? 2 : 1,
                                  child: Newsflashes(
                                    isFullscreen: isFullscreen,
                                    article: article['article'],
                                    id: article['id'],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No articles available.'),
            );
          } else {
            return const Center(
              child: Text('kok iso.'),
            );
          }
        });
  }
}

class Newsflashes extends StatelessWidget {
  final Article article;
  final String id;
  final bool isFullscreen;

  const Newsflashes(
      {super.key,
      required this.isFullscreen,
      required this.article,
      required this.id});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return isFullscreen
        ? GestureDetector(
            onTap: () {
              Get.rootDelegate
                  .toNamed(routeDetailArticle, parameters: {'id': id});
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: getValueForScreenType<double>(
                  context: context,
                  mobile: 5,
                  tablet: 10,
                  desktop: 10,
                ),
                vertical: getValueForScreenType<double>(
                  context: context,
                  mobile: 10,
                  tablet: 15,
                  desktop: 2,
                ),
              ),
              height: getValueForScreenType<double>(
                context: context,
                mobile: height / 4.3,
                tablet: height / 3.3,
                desktop: height / 3,
              ),
              decoration: article.image != ""
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: NetworkImage(article.image!),
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter),
                    )
                  : BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: CusColors.inactive),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: double.infinity - 10,
                    padding: const EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 12,
                            spreadRadius: 1,
                            color: Colors.black.withOpacity(.3))
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 3),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              article.title!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: getValueForScreenType<double>(
                                  context: context,
                                  mobile: width * .021,
                                  tablet: width * .018,
                                  desktop: width * .013,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: getValueForScreenType<double>(
                                    context: context,
                                    mobile: 22,
                                    tablet: 25,
                                    desktop: 30,
                                  ),
                                  height: getValueForScreenType<double>(
                                    context: context,
                                    mobile: 22,
                                    tablet: 25,
                                    desktop: 30,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/suichan.jpg'),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    'Admin - ${article.date?.formatDate()}',
                                    style: GoogleFonts.poppins(
                                        fontSize: getValueForScreenType<double>(
                                          context: context,
                                          mobile: width * .016,
                                          tablet: width * .013,
                                          desktop: width * .008,
                                        ),
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    ),
                  )
                ],
              ),
            ),
          )
        : GestureDetector(
            onTap: () {
              Get.rootDelegate
                  .toNamed(routeDetailArticle, parameters: {'id': id});
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: getValueForScreenType<double>(
                  context: context,
                  mobile: 5,
                  tablet: 10,
                  desktop: 10,
                ),
                vertical: getValueForScreenType<double>(
                  context: context,
                  mobile: 10,
                  tablet: 15,
                  desktop: 2,
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color(0xFFCCCCCC),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: getValueForScreenType<double>(
                      context: context,
                      mobile: 80,
                      tablet: 100,
                      desktop: 130,
                    ),
                    decoration: article.image != ''
                        ? BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            image: DecorationImage(
                                image: NetworkImage(article.image!),
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter),
                          )
                        : BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: CusColors.inactive),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 1, vertical: 13),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            article.title!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                                color: CusColors.title,
                                fontWeight: FontWeight.w600,
                                fontSize: getValueForScreenType<double>(
                                  context: context,
                                  mobile: width * .019,
                                  tablet: width * .016,
                                  desktop: width * .01,
                                ),
                                height: 1.2),
                          ),
                          SizedBox(
                            height: height * .018,
                          ),
                          Row(
                            children: [
                              Container(
                                width: getValueForScreenType<double>(
                                  context: context,
                                  mobile: 22,
                                  tablet: 25,
                                  desktop: 30,
                                ),
                                height: getValueForScreenType<double>(
                                  context: context,
                                  mobile: 22,
                                  tablet: 25,
                                  desktop: 30,
                                ),
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/suichan.jpg'),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  'Admin - ${article.date?.formatDate()}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: GoogleFonts.poppins(
                                      fontSize: getValueForScreenType<double>(
                                        context: context,
                                        mobile: width * .016,
                                        tablet: width * .013,
                                        desktop: width * .008,
                                      ),
                                      color: CusColors.title),
                                ),
                              ),
                            ],
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          );
  }
}
