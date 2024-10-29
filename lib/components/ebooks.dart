import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/models/ebook.dart';
import 'package:project_tc/screens/landing_page/EBook.dart';
import 'package:project_tc/services/extension.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:transparent_image/transparent_image.dart';

class Ebooks extends StatelessWidget {
  final EbookModel ebook;
  final String id;
  const Ebooks({super.key, required this.ebook, required this.id});

  @override
  Widget build(BuildContext context) {
    double width =MediaQuery.of(context).size.width;
    return Container(
      width: width /4.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFCCCCCC),
          width: 1,
        ),
      ),
      child: Padding(padding: EdgeInsets.symmetric(
        vertical: getValueForScreenType(context: context, mobile: 15, tablet: 15, desktop: 20),
        horizontal: getValueForScreenType(context: context, mobile: 15, tablet: 15, desktop: 20),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(
              getValueForScreenType<double>(
                context: context, 
                mobile: 20, 
                tablet: 15, 
                desktop: 20,
              ),
              0,
              getValueForScreenType<double>(
                context: context, 
                mobile: 15,
                tablet: 15,
                desktop: 20,
                
                ),
                10),
    height: getValueForScreenType<double>(
      context: context,
       mobile: 20,
       tablet: 24,
       desktop: 28,
       
       ),
       decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.transparent,
        border: Border.all(
          color: const Color(0xFF2501FF),
                width: 1,
        ),
       ),
       child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            ebook.ebookCategory!,
            textAlign: TextAlign.center,
            style: GoogleFonts.mulish(
              color: const Color(0xFF2501FF),
                    fontSize: getValueForScreenType<double>(
                      context: context,
                      mobile: width * .024,
                      tablet: width * .014,
                      desktop: width * .011,
                    ),
                    fontWeight: FontWeight.bold,
            ),

          )
        ],
       ),

                ),

                ebook.image!=''? 
               ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: ebook.image!,
                  ),
                )
                :const Text('No Image'),
                Padding(padding: 
                const EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      ebook.title!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.mulish(
                        color: CusColors.title,
                        fontSize: getValueForScreenType<double>(
                          context: context,
                          mobile: width * .029,
                          tablet: width * .015,
                          desktop: width * .013,
                        ),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ),
                    Text(
                      ebook.description!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: GoogleFonts.mulish(
                        color: CusColors.inactive,
                      fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .023,
                        tablet: width * .013,
                        desktop: width * .01,
                      ),
                      fontWeight: FontWeight.w300,
                      height: 1.5
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(
                      top: getValueForScreenType(context: context, mobile: 10,
                      tablet: 15,
                      desktop: 20,
                      ),
                    ),
                     child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        // Get.rootDelegate.toNamed(route,
                        //     parameters: {'id': id});
                      },
                      child: Text(
                        'Read more...',
                        style: GoogleFonts.mulish(
                            color: const Color(0xFF86B1F2),
                            fontSize: getValueForScreenType<double>(
                              context: context,
                              mobile: width * .023,
                              tablet: width * .013,
                              desktop: width * .01,
                            ),
                            fontWeight: FontWeight.w300,
                            height: 1.5),
                      ),
                    ),
                  ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: const BoxDecoration(
                         color: Color(0xFFCCCCCC),
                      ),
                    ),
                   Text(
                  ebook.date!.formatDate(),
                  style: GoogleFonts.mulish(
                      color: const Color(0xFF828282),
                      fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .023,
                        tablet: width * .013,
                        desktop: width * .01,
                      ),
                      fontWeight: FontWeight.normal,
                      height: 1.5),
                ),
                  ],
                ),
                )
        ],
      ),
      ),
    );
  }
}


class AdminEbooks extends StatelessWidget {
  final EbookModel ebook;
  final String id;
  final Function()? onPressed;
  final Function()? onDelete;

  const AdminEbooks({super.key, required this.ebook, required this.id,
  this.onPressed,
  this.onDelete});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
    width: width / 4.5,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      color: Colors.white,
      border: Border.all(
        color:  const Color(0xFFCCCCCC),
          width: 1,
      ),
    ),
    child: Padding(padding: EdgeInsets.symmetric(
      vertical: getValueForScreenType(context: context, mobile: 15,
      tablet: 15,
      desktop: 20,
      ),
    ),
      child: Column(children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(
                getValueForScreenType<double>(
                  context: context,
                  mobile: 15,
                  tablet: 15,
                  desktop: 20,
                ),
                0,
                getValueForScreenType<double>(
                  context: context,
                  mobile: 15,
                  tablet: 15,
                  desktop: 20,
                ),
                10),
            height: getValueForScreenType<double>(
              context: context,
              mobile: 20,
              tablet: 24,
              desktop: 28,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.transparent,
              border: Border.all(
                color: const Color(0xFF2501FF),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  ebook.ebookCategory!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.mulish(
                    color: const Color(0xFF2501FF),
                    fontSize: getValueForScreenType<double>(
                      context: context,
                      mobile: width * .024,
                      tablet: width * .014,
                      desktop: width * .011,
                    ),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ebook.image != ''
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: ebook.image!,
                  ),
                )
              : const Text('No Image'),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    ebook.title!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.mulish(
                        color: CusColors.title,
                        fontSize: getValueForScreenType<double>(
                          context: context,
                          mobile: width * .029,
                          tablet: width * .015,
                          desktop: width * .013,
                        ),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  ebook.description!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: GoogleFonts.mulish(
                      color: CusColors.inactive,
                      fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .023,
                        tablet: width * .013,
                        desktop: width * .01,
                      ),
                      fontWeight: FontWeight.w300,
                      height: 1.5),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    ebook.date!.formatDate(),
                    style: GoogleFonts.mulish(
                        color: const Color(0xFF828282),
                        fontSize: getValueForScreenType<double>(
                          context: context,
                          mobile: width * .023,
                          tablet: width * .013,
                          desktop: width * .01,
                        ),
                        fontWeight: FontWeight.normal,
                        height: 1.5),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 1,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  decoration: const BoxDecoration(
                    color: Color(0xFFCCCCCC),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF86B1F2),
                          borderRadius: BorderRadius.circular(64),
                        ),
                        height: getValueForScreenType<double>(
                          context: context,
                          mobile: 26,
                          tablet: 33,
                          desktop: 38,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            onPressed!();
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                            shadowColor:
                                MaterialStateProperty.all(Colors.transparent),
                          ),
                          child: Text(
                            'Edit article',
                            style: GoogleFonts.mulish(
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontSize: getValueForScreenType<double>(
                                context: context,
                                mobile: width * .018,
                                tablet: width * .015,
                                desktop: width * .01,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: () {
                        onDelete!();
                      },
                      child: Icon(
                        IconlyLight.delete,
                        color: const Color(0xFF86B1F2),
                        size: getValueForScreenType<double>(
                          context: context,
                          mobile: 22,
                          tablet: 24,
                          desktop: 28,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ]),
    ),
    );
  }
}

// class EbookLists extends StatefulWidget {
//   final EbookModel ebook;
//   final String id;
//   const EbookLists({super.key, required this.ebook, required this.id});

//   @override
//   State<EbookLists> createState() => _EbookListsState();
// }

// class _EbookListsState extends State<EbookLists> {
//   bool _hovering = false;
//   @override
//   Widget build(BuildContext context) {
//   double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     return
//   }
// }