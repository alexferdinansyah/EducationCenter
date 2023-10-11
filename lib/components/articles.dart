import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/models/article.dart';
import 'package:project_tc/routes/routes.dart';

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
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            height: 28,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.transparent,
              border: Border.all(
                color: const Color(0xFF2501FF),
                width: 1,
              ),
            ),
            child: Text(
              article.category!,
              textAlign: TextAlign.center,
              style: GoogleFonts.mulish(
                  color: const Color(0xFF2501FF),
                  fontSize: width * .011,
                  fontWeight: FontWeight.bold,
                  height: 1.5),
            ),
          ),
          Container(
            width: double.infinity,
            height: 172,
            decoration: article.image != ''
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: const Color(0xFFD9D9D9),
                    image: DecorationImage(
                      image: AssetImage(article.image!),
                      fit: BoxFit.cover, // Adjust the fit as needed
                    ),
                  )
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: const Color(0xFFD9D9D9),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    article.title!,
                    style: GoogleFonts.mulish(
                        color: CusColors.title,
                        fontSize: width * .013,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  article.description!,
                  maxLines: 2,
                  style: GoogleFonts.mulish(
                      color: CusColors.inactive,
                      fontSize: width * .01,
                      fontWeight: FontWeight.w300,
                      height: 1.5),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
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
                            fontSize: width * .01,
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
                  article.date!,
                  style: GoogleFonts.mulish(
                      color: const Color(0xFF828282),
                      fontSize: width * .01,
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          margin: const EdgeInsets.symmetric(vertical: 20),
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
                    image: AssetImage(widget.article.image!),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter),
              ),
            ),
            Text(
              widget.article.title!,
              style: GoogleFonts.mulish(
                  color: CusColors.title,
                  fontSize: width * .016,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: height * .01),
              child: Text(
                widget.article.description!,
                maxLines: 2,
                style: GoogleFonts.mulish(
                    color: CusColors.inactive,
                    fontSize: width * .01,
                    fontWeight: FontWeight.w300,
                    height: 1.5),
              ),
            ),
            Container(
              width: width * .1,
              margin: const EdgeInsets.only(right: 20),
              height: 25,
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
                children: [
                  Text(
                    widget.article.category!,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.mulish(
                      color: const Color(0xFF2501FF),
                      fontSize: width * .011,
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
              widget.article.date!,
              maxLines: 1,
              style: GoogleFonts.mulish(
                color: CusColors.inactive,
                fontSize: width * .01,
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
