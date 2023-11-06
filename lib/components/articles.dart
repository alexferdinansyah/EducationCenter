import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/models/article.dart';
import 'package:project_tc/routes/routes.dart';
import 'package:project_tc/services/extension.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Articles extends StatelessWidget {
  final Article article;
  final String id;
  const Articles({super.key, required this.article, required this.id});

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
          vertical: getValueForScreenType<double>(
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
                  article.category!,
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
          article.image != ''
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(article.image!, width: double.infinity))
              : const Text('No Image'),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    article.title!,
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
                  article.description!,
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
                    top: getValueForScreenType<double>(
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
                        Get.toNamed(routeDetailArticle, parameters: {'id': id});
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
                    )),
                Text(
                  article.date!.formatDate(),
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
        ]),
      ),
    );
  }
}

class ArticleLists extends StatefulWidget {
  final Article article;
  final String id;
  const ArticleLists({super.key, required this.article, required this.id});

  @override
  State<ArticleLists> createState() => _ArticleListsState();
}

class _ArticleListsState extends State<ArticleLists> {
  bool _hovering = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MouseRegion(
      onEnter: (_) => _hovered(),
      onExit: (_) => _hovered(),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(routeDetailArticle, parameters: {'id': widget.id});
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: width / 2,
          padding: EdgeInsets.symmetric(
            horizontal: getValueForScreenType<double>(
              context: context,
              mobile: 15,
              tablet: 20,
              desktop: 20,
            ),
            vertical: getValueForScreenType<double>(
              context: context,
              mobile: 15,
              tablet: 20,
              desktop: 20,
            ),
          ),
          margin: EdgeInsets.symmetric(
            vertical: getValueForScreenType<double>(
              context: context,
              mobile: 15,
              tablet: 15,
              desktop: 20,
            ),
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              width: double.infinity,
              height: height * .32,
              margin: EdgeInsets.only(bottom: height * .03),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                image: DecorationImage(
                    image: NetworkImage(widget.article.image!),
                    fit: BoxFit.cover,
                    alignment: Alignment.center),
              ),
            ),
            Text(
              widget.article.title!,
              style: GoogleFonts.mulish(
                  color: CusColors.title,
                  fontSize: getValueForScreenType<double>(
                    context: context,
                    mobile: width * .032,
                    tablet: width * .018,
                    desktop: width * .016,
                  ),
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: height * .01),
              child: Text(
                widget.article.description!,
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
            ),
            Container(
              margin: const EdgeInsets.only(right: 20),
              height: getValueForScreenType<double>(
                context: context,
                mobile: 20,
                tablet: 25,
                desktop: 30,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.transparent,
                border: Border.all(
                  color: const Color(0xFF2501FF),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.article.category!,
                    style: GoogleFonts.mulish(
                      color: const Color(0xFF2501FF),
                      fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .023,
                        tablet: width * .013,
                        desktop: width * .01,
                      ),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
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
              widget.article.date!.formatDate(),
              maxLines: 1,
              style: GoogleFonts.mulish(
                color: CusColors.inactive,
                fontSize: getValueForScreenType<double>(
                  context: context,
                  mobile: width * .023,
                  tablet: width * .013,
                  desktop: width * .01,
                ),
                fontWeight: FontWeight.w400,
              ),
            ),
          ]),
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
