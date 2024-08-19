import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/article_form_modal.dart';
import 'package:project_tc/components/articles.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/components/custom_alert.dart';
import 'package:project_tc/components/loading.dart';
import 'package:project_tc/models/article.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/services/firestore_service.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AdminArticle extends StatefulWidget {
  const AdminArticle({super.key});

  @override
  State<AdminArticle> createState() => _AdminArticleState();
}

class _AdminArticleState extends State<AdminArticle> {
  List<Map> articles = [];
  List<Map> filteredArticles = [];
  bool initArticle = false;

  void filterArticles(String criteria) {
    setState(() {
      filteredArticles = articles.where((article) {
        if (criteria == 'All Articles') {
          return true;
        } else if (criteria == 'Draft') {
          return article['article'].isDraft == true;
        }
        return false;
      }).toList();
    });
  }

  void updateInitArticle(bool newValue) {
    setState(() {
      initArticle = newValue;
    });
  }

  List<bool> isHovered = [false, false];
  List<bool> isSelected = [true, false];

  // Define the list of criteria and button labels
  List<String> filterCriteria = [
    'All Articles',
    'Draft',
  ];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final user = Provider.of<UserModel?>(context);
    final FirestoreService fireStore = FirestoreService(uid: user!.uid);

    return StreamBuilder(
        stream: fireStore.allArticle,
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active &&
              !initArticle) {
            initArticle = true;
            Future.delayed(const Duration(milliseconds: 300),
                () => filterArticles('All Articles'));
          }
          if (snapshot.hasData) {
            final List<Map> dataMaps = snapshot.data!;
            final dataArticles = dataMaps.map((data) {
              return {
                'id': data['id'],
                'article': data['article'] as Article,
              };
            }).toList();

            articles = List.from(dataArticles);

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
                  Stack(
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
                              'Articles',
                              style: GoogleFonts.poppins(
                                fontSize: getValueForScreenType<double>(
                                  context: context,
                                  mobile: width * .022,
                                  tablet: width * .019,
                                  desktop: width * .014,
                                ),
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF1F384C),
                              ),
                            ),
                            SizedBox(
                              height: getValueForScreenType<double>(
                                context: context,
                                mobile: 20,
                                tablet: 25,
                                desktop: 40,
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: getValueForScreenType<double>(
                                context: context,
                                mobile: 38,
                                tablet: 45,
                                desktop: 50,
                              ),
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Row(
                                    children: List.generate(
                                        filterCriteria.length, (index) {
                                      return MouseRegion(
                                        onEnter: (_) {
                                          // Set the hover state
                                          setState(() {
                                            isHovered[index] = true;
                                          });
                                        },
                                        onExit: (_) {
                                          // Reset the hover state
                                          setState(() {
                                            isHovered[index] = false;
                                          });
                                        },
                                        child: AnimatedContainer(
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                          duration:
                                              const Duration(milliseconds: 300),
                                          height: getValueForScreenType<double>(
                                            context: context,
                                            mobile: 28,
                                            tablet: 35,
                                            desktop: 40,
                                          ),
                                          width: getValueForScreenType<double>(
                                            context: context,
                                            mobile: width * .2,
                                            tablet: width * .15,
                                            desktop: width * .1,
                                          ),
                                          decoration: BoxDecoration(
                                            color: isSelected[index]
                                                ? CusColors.accentBlue
                                                : isHovered[index]
                                                    ? CusColors.accentBlue
                                                    : Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(64),
                                            border: Border.all(
                                              color: CusColors.accentBlue,
                                              width: 1,
                                            ),
                                          ),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                for (int i = 0;
                                                    i < isSelected.length;
                                                    i++) {
                                                  isSelected[i] = (i == index);
                                                }
                                              });
                                              filterArticles(
                                                  filterCriteria[index]);
                                            },
                                            style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.transparent),
                                              shadowColor:
                                                  MaterialStateProperty.all(
                                                      Colors.transparent),
                                            ),
                                            child: Text(
                                              filterCriteria[index],
                                              style: GoogleFonts.mulish(
                                                fontWeight: FontWeight.w700,
                                                color: isSelected[index]
                                                    ? Colors.white
                                                    : isHovered[index]
                                                        ? Colors.white
                                                        : CusColors.accentBlue,
                                                fontSize: getValueForScreenType<
                                                    double>(
                                                  context: context,
                                                  mobile: width * .018,
                                                  tablet: width * .015,
                                                  desktop: width * .01,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: getValueForScreenType<double>(
                                context: context,
                                mobile: 20,
                                tablet: 40,
                                desktop: 50,
                              ),
                            ),
                            SizedBox(
                              height: filteredArticles.length / 5 > 1 &&
                                      filteredArticles.length / 5 < 2
                                  ? height / 3.3 * 2
                                  : filteredArticles.length / 5 >= 2
                                      ? height /
                                          2.5 *
                                          (filteredArticles.length / 5)
                                      : height / 1.6,
                              child: filteredArticles.isEmpty
                                  ? Center(
                                      // Show a message when data is null
                                      child: Column(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svg/course_none.svg',
                                          height: getValueForScreenType<double>(
                                            context: context,
                                            mobile: height / 3,
                                            tablet: height / 2.7,
                                            desktop: height / 2.3,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15),
                                          child: Text(
                                            "There's no article in here, click button below to create article",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                              fontSize:
                                                  getValueForScreenType<double>(
                                                context: context,
                                                mobile: width * .021,
                                                tablet: width * .018,
                                                desktop: width * .013,
                                              ),
                                              color: const Color(0xFF1F384C),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ))
                                  : ScrollConfiguration(
                                      behavior: ScrollConfiguration.of(context)
                                          .copyWith(scrollbars: false),
                                      child: MasonryGridView.count(
                                        physics: const ScrollPhysics(
                                            parent: BouncingScrollPhysics()),
                                        crossAxisSpacing: width *
                                            .02, // Adjust spacing between items horizontally
                                        mainAxisSpacing:
                                            16.0, // Adjust spacing between rows vertically
                                        crossAxisCount:
                                            getValueForScreenType<int>(
                                          context: context,
                                          mobile: 2,
                                          tablet: 3,
                                          desktop: 4,
                                        ),
                                        itemCount: filteredArticles.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return AdminArticles(
                                            article: filteredArticles[index]
                                                ['article'],
                                            id: filteredArticles[index]['id'],
                                            onPressed: () async {
                                              final result = await showDialog(
                                                context: context,
                                                builder: (_) {
                                                  return ArticleFormModal(
                                                    article:
                                                        filteredArticles[index]
                                                            ['article'],
                                                    articleId:
                                                        filteredArticles[index]
                                                            ['id'],
                                                  );
                                                },
                                              );

                                              if (result != null) {
                                                setState(() {
                                                  initArticle = result;
                                                });
                                              }
                                            },
                                            onDelete: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (_) {
                                                    return CustomAlert(
                                                      cancelButton: true,
                                                      title: 'Warning',
                                                      message:
                                                          'Are you sure want to delete this?',
                                                      animatedIcon:
                                                          'assets/animations/alert.json',
                                                      onPressed: () async {
                                                        Get.back();
                                                        final result = await fireStore
                                                            .deleteArticle(
                                                                filteredArticles[
                                                                        index]
                                                                    ['id']);
                                                        if (result ==
                                                            'Success delete article') {
                                                          if (context.mounted) {
                                                            showDialog(
                                                              context: context,
                                                              builder: (_) {
                                                                return CustomAlert(
                                                                  onPressed:
                                                                      () => Get
                                                                          .back(),
                                                                  title:
                                                                      'Success',
                                                                  message:
                                                                      result,
                                                                  animatedIcon:
                                                                      'assets/animations/check.json',
                                                                );
                                                              },
                                                            );
                                                            setState(() {
                                                              initArticle =
                                                                  false;
                                                            });
                                                          }
                                                        } else {
                                                          if (context.mounted) {
                                                            showDialog(
                                                              context: context,
                                                              builder: (_) {
                                                                return CustomAlert(
                                                                  onPressed:
                                                                      () => Get
                                                                          .back(),
                                                                  title:
                                                                      'Failed',
                                                                  message:
                                                                      result,
                                                                  animatedIcon:
                                                                      'assets/animations/failed.json',
                                                                );
                                                              },
                                                            );
                                                          }
                                                        }
                                                      },
                                                    );
                                                  });
                                            },
                                          );
                                        },
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 30,
                        right: 30,
                        child: FloatingActionButton(
                          onPressed: () async {
                            final result = await showDialog(
                              context: context,
                              builder: (_) {
                                return const ArticleFormModal();
                              },
                            );
                            if (result != null) {
                              setState(() {
                                initArticle = result;
                              });
                            }
                          },
                          backgroundColor: CusColors.accentBlue,
                          child: const Icon(Icons.add),
                        ),
                      ),
                    ],
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
