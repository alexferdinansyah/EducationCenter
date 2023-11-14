import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/components/custom_list.dart';
import 'package:project_tc/components/footer.dart';
import 'package:project_tc/controllers/detail_controller.dart';
import 'package:project_tc/models/article.dart';
import 'package:project_tc/services/extension.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:transparent_image/transparent_image.dart';

class DetailArticle extends StatefulWidget {
  const DetailArticle({super.key});

  @override
  State<DetailArticle> createState() => _DetailArticleState();
}

class _DetailArticleState extends State<DetailArticle> {
  String id = '';

  final DetailArticleController controller = Get.put(DetailArticleController());

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var argument = Get.parameters;
    id = argument['id']!;
    controller.fetchDocument(id);

    return Obx(() {
      final article = controller.documentSnapshot.value;

      if (article == null) {
        return const Center(child: Text('Loading...'));
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: getValueForScreenType<double>(
                context: context,
                mobile: 25,
                tablet: 40,
                desktop: 100,
              ),
              bottom: getValueForScreenType<double>(
                context: context,
                mobile: 5,
                tablet: 10,
                desktop: 20,
              ),
            ),
            child: Text(
              article.title!,
              style: GoogleFonts.mulish(
                  color: CusColors.header,
                  fontSize: getValueForScreenType<double>(
                    context: context,
                    mobile: width * .035,
                    tablet: width * .024,
                    desktop: width * .023,
                  ),
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            'Created by Admin - ${article.date?.formatDate()}',
            style: GoogleFonts.mulish(
              color: CusColors.inactive,
              fontSize: getValueForScreenType<double>(
                context: context,
                mobile: width * .019,
                tablet: width * .016,
                desktop: width * .011,
              ),
              fontWeight: FontWeight.w300,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            width: double.infinity,
            height: 1,
            color: CusColors.accentBlue,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: article.image!,
                height: getValueForScreenType<double>(
                  context: context,
                  mobile: height / 3.7,
                  tablet: height / 2.7,
                  desktop: height / 1.6,
                ),
              ),
            ),
          ),
          Text(
            article.description!.replaceAll('\\n', '\n'),
            style: GoogleFonts.mulish(
              color: CusColors.inactive,
              fontSize: getValueForScreenType<double>(
                context: context,
                mobile: width * .02,
                tablet: width * .017,
                desktop: width * .012,
              ),
              fontWeight: FontWeight.w300,
              height: 1.5,
            ),
          ),
          Column(
            children: article.articleContent!
                .map((article) => ArticleContentWidget(
                      articleContent: article,
                    ))
                .toList(),
          ),
          SizedBox(
            height: getValueForScreenType<double>(
              context: context,
              mobile: 25,
              tablet: 40,
              desktop: 100,
            ),
          ),
          const Footer(),
        ],
      );
    });
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
          padding: EdgeInsets.only(
            top: getValueForScreenType<double>(
              context: context,
              mobile: 15,
              tablet: 20,
              desktop: 40,
            ),
            bottom: getValueForScreenType<double>(
              context: context,
              mobile: 8,
              tablet: 10,
              desktop: 20,
            ),
          ),
          child: Text(
            articleContent.subTitle!,
            style: GoogleFonts.mulish(
                color: CusColors.header,
                fontSize: getValueForScreenType<double>(
                  context: context,
                  mobile: width * .024,
                  tablet: width * .021,
                  desktop: width * .016,
                ),
                fontWeight: FontWeight.bold),
          ),
        ),
        if (articleContent.image != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: articleContent.image!,
              height: getValueForScreenType<double>(
                context: context,
                mobile: height / 4.6,
                tablet: height / 3.6,
                desktop: height / 2.5,
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            articleContent.subTitleDescription!.replaceAll('\\n', '\n'),
            style: GoogleFonts.mulish(
                color: CusColors.inactive,
                fontSize: getValueForScreenType<double>(
                  context: context,
                  mobile: width * .02,
                  tablet: width * .017,
                  desktop: width * .012,
                ),
                fontWeight: FontWeight.w300,
                height: 1.5),
          ),
        ),
        if (articleContent.bulletList != [])
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: width,
            child: BulletList(
              articleContent.bulletList!,
              border: false,
              textColor: CusColors.inactive,
              fontWeight: FontWeight.w300,
              fontSize: getValueForScreenType<double>(
                context: context,
                mobile: width * .02,
                tablet: width * .017,
                desktop: width * .012,
              ),
            ),
          ),
        if (articleContent.textUnderList != '')
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              articleContent.textUnderList!.replaceAll('\\n', '\n'),
              style: GoogleFonts.mulish(
                  color: CusColors.inactive,
                  fontSize: getValueForScreenType<double>(
                    context: context,
                    mobile: width * .02,
                    tablet: width * .017,
                    desktop: width * .012,
                  ),
                  fontWeight: FontWeight.w300,
                  height: 1.5),
            ),
          ),
      ],
    );
  }
}
