import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/models/ebook.dart';
import 'package:project_tc/routes/routes.dart';
import 'package:project_tc/screens/landing_page/EBook_page.dart';
import 'package:project_tc/services/extension.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:transparent_image/transparent_image.dart';

class Ebooks extends StatelessWidget {
  final EbookModel ebook;
  final String id;
  const Ebooks({super.key, required this.ebook, required this.id});

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
        padding: EdgeInsets.symmetric(
          vertical: getValueForScreenType(
              context: context, mobile: 15, tablet: 15, desktop: 20),
          horizontal: getValueForScreenType(
              context: context, mobile: 15, tablet: 15, desktop: 20),
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
                        height: 1.5),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: getValueForScreenType(
                        context: context,
                        mobile: 10,
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
  final bool? isPaid;
  final bool isAdmin;
  final Function()? onPressed;
  final Function()? onDelete;

  const AdminEbooks(
      {super.key,
      required this.ebook,
      required this.id,
      required this.isAdmin,
        this.isPaid,
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
          color: const Color(0xFFCCCCCC),
          width: 1,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: getValueForScreenType(
            context: context,
            mobile: 15,
            tablet: 15,
            desktop: 20,
          ),
          horizontal: getValueForScreenType<double>(
            context: context,
            mobile: 15,
            tablet: 15,
            desktop: 20,
          ),
        ),
        child: Column(children: [
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
                            'Edit ebook',
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
                    if (isAdmin)
                      GestureDetector(
                        onTap: () {
                          if (isAdmin == true) {
                            onDelete!();
                          }
                        },
                        child: Icon(
                          isAdmin ? IconlyLight.delete : IconlyLight.chat,
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

class EbookLists extends StatefulWidget {
  final EbookModel ebook;
  final String id;
  const EbookLists({super.key, required this.ebook, required this.id});

  @override
  State<EbookLists> createState() => _EbookListsState();
}

class _EbookListsState extends State<EbookLists> {
  bool _hovering = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MouseRegion(
      onEnter: (_) => _hovered(),
      onExit: (_) => _hovered(),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onVerticalDragUpdate: (_) {},
        onTap: () {
          Get.rootDelegate.toNamed(routeAdminDetailEbook, parameters: {'id': widget.id});
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: width / 2,
          padding: EdgeInsets.symmetric(
            horizontal: getValueForScreenType<double>(
                context: context, mobile: 15, desktop: 20, tablet: 20),
            vertical: getValueForScreenType<double>(
                context: context, mobile: 15, tablet: 20, desktop: 20),
          ),
          margin: EdgeInsets.symmetric(
            vertical: getValueForScreenType(
                context: context, mobile: 15, tablet: 15, desktop: 20),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
            border: Border.all(
              color: const Color(0xFFCCCCCC),
              width: 1,
            ),
            boxShadow: [
              _hovering
                  ? BoxShadow(
                      color: const Color(0xFFCCCCCC).withOpacity(.3),
                      offset: const Offset(6, 6),
                      blurRadius: 8)
                  : const BoxShadow(
                      color: Colors.transparent,
                      offset: Offset(0, 0),
                      blurRadius: 0)
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.ebook.image != ''
                  ? IgnorePointer(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: height * .03),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: widget.ebook.image!,
                            height: height * .32,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                    )
                  : const Text('No Image'),
              Text(
                widget.ebook.title!,
                style: GoogleFonts.mulish(
                    color: CusColors.title,
                    fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .032,
                        tablet: width * .018,
                        desktop: width * .016),
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: height * .01),
                child: Text(
                  widget.ebook.description!.replaceAll('\\n', '\n'),
                  maxLines: 2,
                  style: GoogleFonts.mulish(
                      color: CusColors.inactive,
                      fontSize: getValueForScreenType(
                          context: context,
                          mobile: width * .023,
                          tablet: width * .013,
                          desktop: width * .01),
                      fontWeight: FontWeight.w300,
                      height: 1.5),
                ),
              ),
              Container(
                width: double.infinity,
                height: 1,
                margin: EdgeInsets.symmetric(vertical: height * .013),
                decoration: const BoxDecoration(
                  color: Color(0xFFCCCCCC),
                ),
              ),
              Text(
                widget.ebook.date!.formatDate(),
                maxLines: 1,
                style: GoogleFonts.mulish(
                  color: CusColors.inactive,
                  fontSize: getValueForScreenType(
                    context: context,
                    mobile: width * .023,
                    tablet: width * .013,
                    desktop: width * .01,
                  ),
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _hovered() {
    setState(() {
      _hovering = !_hovering;
    });
  }
}
