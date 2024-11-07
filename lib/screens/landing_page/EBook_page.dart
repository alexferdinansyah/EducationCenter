import 'dart:math';

import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/animation/animation_function.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/components/ebooks.dart';
import 'package:project_tc/components/footer.dart';
import 'package:project_tc/models/ebook.dart';
import 'package:project_tc/services/firestore_service.dart';
import 'package:responsive_builder/responsive_builder.dart';

class EbookPage extends StatefulWidget {
  const EbookPage({super.key});

  @override
  State<EbookPage> createState() => _EbookPageState();
}

class _EbookPageState extends State<EbookPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 30),
            width: width * 0.8,
            child: Image.asset('assets/images/SLIDE 7.png'),
          ),
        ],
      ),
      Padding(
        padding: EdgeInsets.only(
          top: getValueForScreenType<double>(
            context: context,
            mobile: 40,
            tablet: 70,
            desktop: 100,
          ),
          bottom: getValueForScreenType<double>(
            context: context,
            mobile: 40,
            tablet: 70,
            desktop: 100,
          ),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          StreamBuilder<List<Map>>(
            stream: FirestoreService.withoutUID().allEbook,
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                final List<Map> dataMaps = snapshot.data!;
                final List<Map> ebook = dataMaps.where((ebookMap) {
                  final dynamic data = ebookMap['ebook'];
                  return data is EbookModel; // Corrected condition
                }).map((ebookMap) {
                  final EbookModel ebook = ebookMap['ebook'];
                  final String id = ebookMap['id'];
                  return {'ebook': ebook, 'id': id};
                }).toList();

                return Column(children: [
                  Text(
                    'Available E-book',
                    style: GoogleFonts.mulish(
                      color: CusColors.header,
                      fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .028,
                        tablet: width * .022,
                        desktop: width * .018,
                      ),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: getValueForScreenType<double>(
                        context: context,
                        mobile: 10,
                        tablet: 20,
                        desktop: 26,
                      ),
                      bottom: getValueForScreenType<double>(
                        context: context,
                        mobile: 40,
                        tablet: 50,
                        desktop: 70,
                      ),
                    ),
                    width: width * .05,
                    height: 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromRGBO(0, 0, 0, 1),
                    ),
                  ),
                  SizedBox(
                    width: getValueForScreenType<double>(
                      context: context,
                      mobile: width / 1.3,
                      tablet: width / 1.6,
                      desktop: width / 1.6,
                    ),
                    height: getValueForScreenType<double>(
                      context: context,
                      mobile: height * .64 * ebook.length,
                      tablet: height * .64 * ebook.length + 150,
                      desktop: height * .20 * ebook.length + 150,
                    ),
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(scrollbars: false),
                      child: MasonryGridView.count(
                        physics: const ScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        crossAxisSpacing: width * .02, // Adjust spacing
                        mainAxisSpacing: 16.0, // Adjust spacing
                        crossAxisCount: getValueForScreenType<int>(
                          context: context,
                          mobile: 1,
                          tablet: 2,
                          desktop: 3,
                        ),
                        itemCount: ebook.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Ebooks(
                            ebook: ebook[index]['ebook'],
                            id: ebook[index]['id'],
                          );
                        },
                      ),
                    ),
                  ),
                ]);
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('No ebook available.'),
                );
              } else {
                return const Center(
                  child: Text('kok iso.'),
                );
              }
            },
          ),
        ]),
      ),
      const Footer(),
    ]);
  }
}
