import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/components/custom_list.dart';
import 'package:project_tc/components/footer.dart';
import 'package:project_tc/controllers/detail_controller.dart';
import 'package:project_tc/models/ebook.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/routes/routes.dart';
import 'package:project_tc/screens/auth/confirm_email.dart';
import 'package:project_tc/screens/auth/login/sign_in_responsive.dart';
import 'package:project_tc/screens/learning/ebook_offer.dart';
import 'package:project_tc/services/extension.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:transparent_image/transparent_image.dart';

class LearningEbook extends StatefulWidget {
  const LearningEbook({super.key});

  @override
  State<LearningEbook> createState() => _LearningEbookState();
}

class _LearningEbookState extends State<LearningEbook> {
  String id = '';
  List<String> learnEBookTitle = [];

  bool? isVerify;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    if (FirebaseAuth.instance.currentUser != null) {
      setState(() {
        isVerify = FirebaseAuth.instance.currentUser!.emailVerified;
      });
    }
  }

  final DetailEBookController controller = Get.put(DetailEBookController());

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final user = Provider.of<UserModel?>(context);

    checkEmailVerified() async {
      await FirebaseAuth.instance.currentUser?.reload();

      setState(() {
        isVerify = FirebaseAuth.instance.currentUser!.emailVerified;
      });

      if (isVerify!) {
        timer?.cancel();
      }
    }

    var parameter = Get.rootDelegate.parameters;
    var route = Get.rootDelegate.currentConfiguration!.location!;

    id = parameter['id']!;
    if (user == null) {
      return const ResponsiveSignIn();
    }
    if (isVerify == false) {
      timer = Timer(const Duration(seconds: 2), () => checkEmailVerified());
      return const ConfirmEmail();
    }
    controller.fetchDocument(id);

    return Obx(() {
      final ebook = controller.documentSnapshot.value;

      if (ebook == null) {
        return const Center(child: Text('Loading...'));
      }
      // final List<EbookContent> learnebook = data['learn_ebook'].toList();

      // learnEBookTitle = List.from(learnebook.map((learn) => learn.subTitle));

      if (route.contains('/learn-ebook/offers')) {
        return EbookOffer(
          price: '',
          id: id,
        );
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
              ebook.title!,
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
            'Created by Admin - ${ebook.date?.formatDate()}',
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
                image: ebook.image!,
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
            ebook.description!.replaceAll('\\n', '\n'),
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
            children: ebook.ebookContent!
                .map((ebook) => EbookContentWidget(
                      ebookContent: ebook,
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
          // const Footer(),
        ],
      );
    });
    // return Obx(() {
    //   final data = controller.documentSnapshot.value;

    //   if (data == null) {
    //     return Center(
    //         child: Text(
    //       'Loading...',
    //       style: GoogleFonts.poppins(
    //           fontSize: 20,
    //           color: Colors.black,
    //           decoration: TextDecoration.none),
    //     ));
    //   }
    //   if (route.contains('/learn-ebook/offers')) {
    //     return EbookOffer(
    //       price: data['price'],
    //       isPaid: data['isPaid'],
    //       id: id,
    //     );
    //   }

    //   if (data['isPaid'] == null) {
    //     return Scaffold(
    //       body: ListView(
    //         children: [
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               SizedBox(
    //                 height: height,
    //                 child: Column(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     Text(
    //                       'You Dont Have This ebook, please go back',
    //                       style: GoogleFonts.poppins(
    //                         fontSize: getValueForScreenType<double>(
    //                           context: context,
    //                           mobile: width * .022,
    //                           tablet: width * .02,
    //                           desktop: width * .015,
    //                         ),
    //                         fontWeight: FontWeight.w700,
    //                         color: const Color(0xFF1F384C),
    //                       ),
    //                     ),
    //                     Container(
    //                       height: getValueForScreenType<double>(
    //                         context: context,
    //                         mobile: 26,
    //                         tablet: 33,
    //                         desktop: 40,
    //                       ),
    //                       margin: const EdgeInsets.only(top: 20),
    //                       decoration: BoxDecoration(
    //                           color: const Color(0xFF00C8FF),
    //                           borderRadius: BorderRadius.circular(80),
    //                           boxShadow: [
    //                             BoxShadow(
    //                                 color: Colors.black.withOpacity(.25),
    //                                 spreadRadius: 0,
    //                                 blurRadius: 20,
    //                                 offset: const Offset(0, 4))
    //                           ]),
    //                       child: ElevatedButton(
    //                         onPressed: () {
    //                           Get.rootDelegate.toNamed(routeHome);
    //                         },
    //                         style: ButtonStyle(
    //                           shape: MaterialStateProperty.all<
    //                               RoundedRectangleBorder>(
    //                             RoundedRectangleBorder(
    //                               borderRadius: BorderRadius.circular(8),
    //                             ),
    //                           ),
    //                           padding:
    //                               MaterialStateProperty.all<EdgeInsetsGeometry>(
    //                             EdgeInsets.symmetric(
    //                               horizontal: width * .015,
    //                             ),
    //                           ),
    //                           backgroundColor:
    //                               MaterialStateProperty.all(Colors.transparent),
    //                           shadowColor:
    //                               MaterialStateProperty.all(Colors.transparent),
    //                         ),
    //                         child: Text(
    //                           'Back',
    //                           style: GoogleFonts.mulish(
    //                             fontWeight: FontWeight.w700,
    //                             color: Colors.white,
    //                             fontSize: getValueForScreenType<double>(
    //                               context: context,
    //                               mobile: width * .019,
    //                               tablet: width * .016,
    //                               desktop: width * .011,
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ],
    //       ),
    //     );
    //   }

    // });
  }
}

class EbookContentWidget extends StatelessWidget {
  final EbookContent ebookContent;
  const EbookContentWidget({super.key, required this.ebookContent});

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
            ebookContent.subTitle!,
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
        if (ebookContent.image != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: ebookContent.image!,
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
            ebookContent.subTitleDescription!.replaceAll('\\n', '\n'),
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
        if (ebookContent.bulletList != [])
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: width,
            child: BulletList(
              ebookContent.bulletList!,
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
        if (ebookContent.textUnderList != '')
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              ebookContent.textUnderList!.replaceAll('\\n', '\n'),
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
