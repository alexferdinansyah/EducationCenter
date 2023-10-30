import "package:flutter/material.dart";
import "package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart";
import "package:google_fonts/google_fonts.dart";
import "package:project_tc/components/constants.dart";
import "package:project_tc/components/loading.dart";
import "package:project_tc/models/article.dart";
import "package:project_tc/services/firestore_service.dart";
import 'package:project_tc/services/extension.dart';

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
            final dataArticle = dataMaps.map((data) {
              return {
                'article': data['article'] as Article,
                'id': data['id'],
              };
            }).toList();

            articles = List.from(dataArticle);

            return Container(
              width: width * .83,
              height: height - 60,
              color: CusColors.bg,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 35),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 56,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                            color: Colors.white,
                            border: Border.all(
                              color: const Color(0xFFCCCCCC),
                              width: 1,
                            ),
                          ),
                          child: Row(children: [
                            Text(
                              'UI/UX',
                              style: GoogleFonts.poppins(
                                  fontSize: width * .01,
                                  fontWeight: FontWeight.w400,
                                  color: CusColors.secondaryText),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Front-end developer',
                              style: GoogleFonts.poppins(
                                  fontSize: width * .01,
                                  fontWeight: FontWeight.w400,
                                  color: CusColors.secondaryText),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Back-end developer',
                              style: GoogleFonts.poppins(
                                  fontSize: width * .01,
                                  fontWeight: FontWeight.w400,
                                  color: CusColors.secondaryText),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Database',
                              style: GoogleFonts.poppins(
                                  fontSize: width * .01,
                                  fontWeight: FontWeight.w400,
                                  color: CusColors.secondaryText),
                            ),
                          ]),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: height - 100,
                          child: GridView.custom(
                            gridDelegate: SliverQuiltedGridDelegate(
                              crossAxisCount: 4,
                              // mainAxisSpacing: 4,
                              // crossAxisSpacing: 4,
                              repeatPattern: QuiltedGridRepeatPattern.inverted,
                              pattern: [
                                const QuiltedGridTile(1, 2),
                                const QuiltedGridTile(1, 1),
                                const QuiltedGridTile(1, 1),
                                const QuiltedGridTile(1, 1),
                                const QuiltedGridTile(1, 1),
                              ],
                            ),
                            childrenDelegate: SliverChildBuilderDelegate(
                              childCount: articles.length,
                              (context, index) {
                                // Calculate the color based on the repeating pattern
                                bool isFullscreen =
                                    index % 10 == 0 || (index - 9) % 10 == 0
                                        ? true
                                        : false;

                                return Newsflashes(
                                  article: articles[index]['article'],
                                  id: articles[index]['id'],
                                  isFullscreen: isFullscreen,
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
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No courses available.'),
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
    return isFullscreen
        ? Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                  height: 90,
                  width: double.infinity - 10,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 12,
                          spreadRadius: 1,
                          color: Colors.black.withOpacity(.3))
                    ],
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
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
                                fontSize: width * .013),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 30,
                                height: 30,
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
                                      fontSize: width * .008,
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
          )
        : Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                  height: 130,
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
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
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
                              fontSize: width * .011,
                              height: 1.2),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/suichan.jpg'),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'Admin - ${article.date?.formatDate()}',
                                style: GoogleFonts.poppins(
                                    fontSize: width * .008,
                                    color: CusColors.title),
                              ),
                            ),
                          ],
                        ),
                      ]),
                ),
              ],
            ),
          );
  }
}
