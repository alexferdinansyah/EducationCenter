import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/components/navigation_bar/navigation_bar.dart';

class DetailBundleCourse extends StatefulWidget {
  const DetailBundleCourse({super.key});

  @override
  State<DetailBundleCourse> createState() => _DetailBundleCourseState();
}

class _DetailBundleCourseState extends State<DetailBundleCourse> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: ListView(children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: width * .045, vertical: height * .018),
                alignment: Alignment.centerLeft,
                child: AnimateIfVisibleWrapper(
                  showItemInterval: const Duration(milliseconds: 150),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CusNavigationBar(),
                        Padding(
                          padding: const EdgeInsets.only(top: 100, bottom: 200),
                          child: Row(
                            children: [
                              AnimateIfVisible(
                                reAnimateOnVisibility: true,
                                key: const Key('item.1'),
                                builder: (
                                  BuildContext context,
                                  Animation<double> animation,
                                ) =>
                                    FadeTransition(
                                  opacity: Tween<double>(
                                    begin: 0,
                                    end: 1,
                                  ).animate(animation),
                                  child: SizedBox(
                                    width: width / 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Junior web developer',
                                          style: GoogleFonts.mulish(
                                              color: CusColors.header,
                                              fontSize: width * .028,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 30),
                                          child: Text(
                                            'DAC provides progressive, and affordable courses, accessible on website, designed to empower individuals to enhance their skills.',
                                            style: GoogleFonts.mulish(
                                                color: CusColors.inactive,
                                                fontSize: width * .012,
                                                fontWeight: FontWeight.w300,
                                                height: 1.5),
                                          ),
                                        ),
                                        Container(
                                          width: width * .09,
                                          decoration: BoxDecoration(
                                              color: const Color(0xFF00C8FF),
                                              borderRadius:
                                                  BorderRadius.circular(80),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(.25),
                                                    spreadRadius: 0,
                                                    blurRadius: 20,
                                                    offset: const Offset(0, 4))
                                              ]),
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                              padding: MaterialStateProperty
                                                  .all<EdgeInsetsGeometry>(
                                                EdgeInsets.symmetric(
                                                  vertical: height * 0.025,
                                                ),
                                              ),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.transparent),
                                              shadowColor:
                                                  MaterialStateProperty.all(
                                                      Colors.transparent),
                                            ),
                                            child: Text(
                                              'Start now',
                                              style: GoogleFonts.mulish(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                                fontSize: width * 0.01,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              AnimateIfVisible(
                                reAnimateOnVisibility: true,
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
                                        child: Container(
                                            width: 519,
                                            height: 365,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(26),
                                              color: const Color.fromRGBO(
                                                  217, 217, 217, 1),
                                            ))),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ])));
  }
}
