import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/controllers/detail_controller.dart';
import 'package:project_tc/models/bootcamp.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/services/function.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailBootcamp extends StatefulWidget {
  const DetailBootcamp({super.key});

  @override
  State<DetailBootcamp> createState() => _DetailBootcampState();
}

class _DetailBootcampState extends State<DetailBootcamp> {
  String id = '';

  final DetailBootcampController controller =
      Get.put(DetailBootcampController());

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    var argument = Get.rootDelegate.parameters;
    id = argument['id']!;
    controller.fetchDocument(id);

    return Obx(() {
      final Bootcamp = controller.documentSnapshot.value;

      if (Bootcamp == null) {
        return const Center(child: Text('Loading'));
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
            child: ResponsiveBuilder(
              builder: (context, SizingInformation) {
              if (SizingInformation.deviceScreenType ==
                  DeviceScreenType.desktop) {
                return _defaultHeader(
                  width,
                  Bootcamp.category,
                  Bootcamp.title,
                  Bootcamp.date,
                  Bootcamp.time,
                  Bootcamp.place,
                  Bootcamp.speaker,
                  Bootcamp.description,
                  Bootcamp.image,
                  Bootcamp.link,
                );
              }
              if (SizingInformation.deviceScreenType ==
                  DeviceScreenType.tablet) {
                return _defaultHeader(
                  width,
                  Bootcamp.category,
                  Bootcamp.title,
                  Bootcamp.date,
                  Bootcamp.time,
                  Bootcamp.place,
                  Bootcamp.speaker,
                  Bootcamp.description,
                  Bootcamp.image,
                  Bootcamp.link,
                );
              }
              if (SizingInformation.deviceScreenType ==
                  DeviceScreenType.mobile) {
                return _headerMobile(
                  width,
                  Bootcamp.category,
                  Bootcamp.title,
                  Bootcamp.date,
                  Bootcamp.time,
                  Bootcamp.place,
                  Bootcamp.speaker,
                  Bootcamp.description,
                  Bootcamp.image,
                  Bootcamp.link,
                );
              }
              return Container();
            }),
          )
        ],
      );
    });
  }

  Widget _defaultHeader(width, category, title, date, time, place, speaker,
      descriptin, image, link) {
    return Row(
      children: [
        AnimateIfVisible(
          key: const Key('item 1'),
          builder: (
            BuildContext context,
            // ignore: non_constant_identifier_names
            Animation<double> Animation,
          ) =>
              FadeTransition(
            opacity: Tween<double>(
              begin: 0,
              end: 1,
            ).animate(Animation),
            child: SizedBox(
              width: width / 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category,
                    style: GoogleFonts.mulish(
                      color: CusColors.accentBlue,
                      fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .02,
                        tablet: width * .017,
                        desktop: width * .012,
                      ),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    child: Text(
                      title,
                      style: GoogleFonts.mulish(
                          color: CusColors.header,
                          fontSize: getValueForScreenType<double>(
                            context: context,
                            mobile: width * .04,
                            tablet: width * .029,
                            desktop: width * .028,
                          ),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    descriptin!.replaceAll('\\n', '\n'),
                    style: GoogleFonts.mulish(
                      color: CusColors.inactive,
                      fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .02,
                        tablet: width * .017,
                        desktop: width * .012,
                      ),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    '📌Catat tanggalnya📌',
                    style: GoogleFonts.mulish(
                      color: CusColors.inactive,
                      fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .02,
                        tablet: width * .017,
                        desktop: width * .012,
                      ),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    '🗓 : $date',
                    style: GoogleFonts.mulish(
                      color: CusColors.inactive,
                      fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .02,
                        tablet: width * .017,
                        desktop: width * .012,
                      ),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    '🕙 : $time',
                    style: GoogleFonts.mulish(
                      color: CusColors.inactive,
                      fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .02,
                        tablet: width * .017,
                        desktop: width * .012,
                      ),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    '📍 : $place',
                    style: GoogleFonts.mulish(
                      color: CusColors.inactive,
                      fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .02,
                        tablet: width * .017,
                        desktop: width * .012,
                      ),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    '🎤 : $speaker',
                    style: GoogleFonts.mulish(
                      color: CusColors.inactive,
                      fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .02,
                        tablet: width * .017,
                        desktop: width * .012,
                      ),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    '❗Daftarkan dirimu sekarang❗',
                    style: GoogleFonts.mulish(
                      color: CusColors.inactive,
                      fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .02,
                        tablet: width * .017,
                        desktop: width * .012,
                      ),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '📌 Link pendaftaran : ',
                        style: GoogleFonts.mulish(
                          color: CusColors.inactive,
                          fontSize: getValueForScreenType<double>(
                            context: context,
                            mobile: width * .02,
                            tablet: width * .017,
                            desktop: width * .012,
                          ),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          final Uri url = Uri.parse(link);
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          } else {
                            // Jika tidak bisa membuka URL
                            throw 'Could not launch $link';
                          }
                        },
                        child: Text(
                          '$link',
                          style: GoogleFonts.mulish(
                            color: CusColors.accentBlue,
                            fontSize: getValueForScreenType<double>(
                              context: context,
                              mobile: width * .02,
                              tablet: width * .017,
                              desktop: width * .012,
                            ),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    '📌 Kunjungi kami :',
                    style: GoogleFonts.mulish(
                      color: CusColors.inactive,
                      fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .02,
                        tablet: width * .017,
                        desktop: width * .012,
                      ),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '(Website)      : ',
                        style: GoogleFonts.mulish(
                          color: CusColors.inactive,
                          fontSize: getValueForScreenType<double>(
                            context: context,
                            mobile: width * .02,
                            tablet: width * .017,
                            desktop: width * .012,
                          ),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          final Uri params = Uri(
                              scheme: 'https',
                              host: '',
                              path: 'ec.dac-solution.com');
                          if (await canLaunchUrl(params)) {
                            await launchUrl(params,
                                mode: LaunchMode.inAppWebView);
                          } else {
                            print('error open whatsapp $params');
                          }
                        },
                        child: Text(
                          'ec.dac-solution.com',
                          style: GoogleFonts.mulish(
                            color: CusColors.accentBlue,
                            fontSize: getValueForScreenType<double>(
                              context: context,
                              mobile: width * .02,
                              tablet: width * .017,
                              desktop: width * .012,
                            ),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '(Instagram)   : ',
                        style: GoogleFonts.mulish(
                          color: CusColors.inactive,
                          fontSize: getValueForScreenType<double>(
                            context: context,
                            mobile: width * .02,
                            tablet: width * .017,
                            desktop: width * .012,
                          ),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      GestureDetector(
                        onTap: launchInstagram,
                        child: Text(
                          'digital.educationcenter',
                          style: GoogleFonts.mulish(
                            color: CusColors.accentBlue,
                            fontSize: getValueForScreenType<double>(
                              context: context,
                              mobile: width * .02,
                              tablet: width * .017,
                              desktop: width * .012,
                            ),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '(Tik Tok)        : ',
                        style: GoogleFonts.mulish(
                          color: CusColors.inactive,
                          fontSize: getValueForScreenType<double>(
                            context: context,
                            mobile: width * .02,
                            tablet: width * .017,
                            desktop: width * .012,
                          ),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      GestureDetector(
                        onTap: launchTikTok,
                        child: Text(
                          ' digital.educationcenter',
                          style: GoogleFonts.mulish(
                            color: CusColors.accentBlue,
                            fontSize: getValueForScreenType<double>(
                              context: context,
                              mobile: width * .02,
                              tablet: width * .017,
                              desktop: width * .012,
                            ),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '(WhatsApp) : ',
                        style: GoogleFonts.mulish(
                          color: CusColors.inactive,
                          fontSize: getValueForScreenType<double>(
                            context: context,
                            mobile: width * .02,
                            tablet: width * .017,
                            desktop: width * .012,
                          ),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          final Uri params = Uri(
                              scheme: 'https',
                              host: 'wa.me',
                              path: '+6285179943367');
                          if (await canLaunchUrl(params)) {
                            await launchUrl(params,
                                mode: LaunchMode.inAppWebView);
                          } else {
                            print('error open whatsapp $params');
                          }
                        },
                        child: Text(
                          '(+62) 85179943367',
                          style: GoogleFonts.mulish(
                            color: CusColors.accentBlue,
                            fontSize: getValueForScreenType<double>(
                              context: context,
                              mobile: width * .02,
                              tablet: width * .017,
                              desktop: width * .012,
                            ),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const Spacer(),
        AnimateIfVisible(
          key: const Key('item.2'),
          builder: (
            BuildContext context,
            Animation<double> animation,
          ) =>
              FadeTransition(
            opacity: Tween<double>(
              begin: 0,
              end: 1,
            ).animate(animation),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(image, width: width / 2.7)),
          ),
        )
      ],
    );
  }

  Widget _headerMobile(width, category, title, date, time, place, speaker,
      descriptin, image, link) {
    return Row();
  }
}
