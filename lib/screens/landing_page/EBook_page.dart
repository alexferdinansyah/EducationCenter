import 'dart:math';

import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/animation/animation_function.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/components/ebooks.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 30),
              width: width * 0.8,
              child: Image.asset('assets/images/SLIDE 7.png'),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
            top: getValueForScreenType<double>(
              context: context,
              mobile: 10,
              tablet: 50,
              desktop: 100,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder(
                stream: FirestoreService.withoutUID().allEbook,
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    final List<Map> dataMaps = snapshot.data!;

                    final List<Map> ebook = dataMaps
                        .where((ebookData) {
                          final dynamic data = ebookData['ebook'];
                          return data is EbookModel;
                        })
                        .where(
                            (ebookData) => ebookData['ebook'].isDraft == false)
                        .where((ebookData) =>
                            ebookData['ebook'].title.toLowerCase())
                        .map((ebookData) {
                          final EbookModel ebook = ebookData['ebook'];
                          final String id = ebookData['id'];
                          return {'ebook': ebook, 'id': id};
                        })
                        .toList();

                    // final List<Map> ebook = dataMaps.where((ebookMap) {
                    //   final dynamic data = ebookMap['ebook'];
                    //   return data is EbookModel?;
                    // }).map((ebookMap) {
                    //   final EbookModel ebook = ebookMap['ebook'];
                    //   final String id = ebookMap['id'];
                    //   return {'ebook': ebook, 'id': id};
                    // }).toList();

                    return SizedBox(
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
                          desktop: height * .64 * ebook.length + 150,
                        ),
                        child: ebook.isNotEmpty
                            ? LiveList(
                                showItemInterval:
                                    const Duration(milliseconds: 150),
                                showItemDuration:
                                    const Duration(milliseconds: 350),
                                scrollDirection: Axis.vertical,
                                itemCount: ebook.length,
                                itemBuilder: animationBuilder(
                                  (index) => EbookLists(
                                      ebook: ebook[index]['article'],
                                      id: ebook[index]['id']),
                                ),
                              )
                            : Center(
                                child: Text(
                                  'Not Found',
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
                              ));
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('No video learning available.'),
                    );
                  } else {
                    return const Center(
                      child: Text('kok iso.'),
                    );
                  }
                },
              )
            ],
          ),
        )
      ],
    );
  }
}
