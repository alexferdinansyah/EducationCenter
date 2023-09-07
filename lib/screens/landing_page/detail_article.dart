import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/components/footer.dart';
import 'package:project_tc/models/article.dart';

class DetailArticle extends StatelessWidget {
  final Article article;
  const DetailArticle({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 100, bottom: 20),
          child: Text(
            article.title!,
            style: GoogleFonts.mulish(
                color: CusColors.header,
                fontSize: width * .023,
                fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          'Created by Admin - ${article.date}',
          style: GoogleFonts.mulish(
            color: CusColors.inactive,
            fontSize: width * .011,
            fontWeight: FontWeight.w300,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          width: double.infinity,
          height: 1,
          color: CusColors.accentBlue,
        ),
        Container(
          width: double.infinity,
          height: height / 1.6,
          margin: const EdgeInsets.only(top: 30, bottom: 30),
          decoration: article.image! != ''
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
        Text(
          article.description!,
          style: GoogleFonts.mulish(
              color: CusColors.inactive,
              fontSize: width * .012,
              fontWeight: FontWeight.w300,
              height: 1.5),
        ),
        Column(
          children: article.articleContent!
              .map((article) => ArticleContentWidget(
                    articleContent: article,
                  ))
              .toList(),
        ),
        const SizedBox(
          height: 100,
        ),
        const Footer(),
      ],
    );
  }
}

class ArticleContentWidget extends StatelessWidget {
  final ArticleContent articleContent;
  const ArticleContentWidget({super.key, required this.articleContent});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40, bottom: 20),
          child: Text(
            articleContent.subTitle!,
            style: GoogleFonts.mulish(
                color: CusColors.header,
                fontSize: width * .016,
                fontWeight: FontWeight.bold),
          ),
        ),
        if (articleContent.image != null)
          Container(
            margin: const EdgeInsets.only(left: 25, bottom: 20),
            width: width / 3,
            height: height / 2.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: const Color(0xFFD9D9D9),
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            articleContent.subTitleDescription!,
            style: GoogleFonts.mulish(
                color: CusColors.inactive,
                fontSize: width * .012,
                fontWeight: FontWeight.w300,
                height: 1.5),
          ),
        ),
      ],
    );
  }
}
