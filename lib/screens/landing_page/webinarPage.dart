import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/components/footer.dart';
import 'package:project_tc/components/webinars.dart';
import 'package:project_tc/models/webinar.dart';
import 'package:project_tc/services/firestore_service.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Webinarpage extends StatelessWidget {
  const Webinarpage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
            margin: const EdgeInsets.only(top: 30),
            width: width * 0.8,
            child: Image.asset('assets/images/SLIDE 5.png'))
      ]),
      Padding(
        padding: EdgeInsets.only(
          top: getValueForScreenType<double>(
            context: context,
            mobile: 40,
            tablet: 70,
            desktop: 100,
          ),
          bottom: getValueForScreenType<double>(
            context: context,
            mobile: 40,
            tablet: 70,
            desktop: 100,
          ),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          StreamBuilder(
              stream: FirestoreService.withoutUID().allWebinar,
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  final List<Map> dataMaps = snapshot.data!;
                  final List<Map> webinar = dataMaps.where((webinarMap) {
                    final dynamic data = webinarMap['webinar'];
                    return data is Webinar?;
                  }).map((webinarMap) {
                    final Webinar webinar = webinarMap['webinar'];
                    final String id = webinarMap['id'];
                    return {'webinar': webinar, 'id': id};
                  }).toList();
                  return Column(children: [
                    Text(
                      'Available webinar',
                      style: GoogleFonts.mulish(
                          color: CusColors.header,
                          fontSize: getValueForScreenType<double>(
                            context: context,
                            mobile: width * .028,
                            tablet: width * .022,
                            desktop: width * .018,
                          ),
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                        margin: EdgeInsets.only(
                            top: getValueForScreenType<double>(
                              context: context,
                              mobile: 10,
                              tablet: 20,
                              desktop: 26,
                            ),
                            bottom: getValueForScreenType<double>(
                              context: context,
                              mobile: 40,
                              tablet: 50,
                              desktop: 70,
                            )),
                        width: width * .05,
                        height: 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color.fromRGBO(0, 0, 0, 1),
                        )),
                    SizedBox(
                      height: getValueForScreenType<double>(
                        context: context,
                        mobile: height / 3.3 * webinar.length,
                        tablet: (height / 2.8) * (webinar.length / 2),
                        desktop: (height / 1.5) * (webinar.length / 3),
                      ),
                      width: getValueForScreenType<double>(
                        context: context,
                        mobile: width / 2,
                        tablet: width / 1.8,
                        desktop: width / 1.7,
                      ),
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context)
                            .copyWith(scrollbars: false),
                        child: MasonryGridView.count(
                          physics: const ScrollPhysics(
                              parent: BouncingScrollPhysics()),
                          crossAxisSpacing: width *
                              .02, // Adjust spacing between items horizontally
                          mainAxisSpacing:
                              16.0, // Adjust spacing between rows vertically
                          crossAxisCount: getValueForScreenType<int>(
                            context: context,
                            mobile: 1,
                            tablet: 2,
                            desktop: 3,
                          ),
                          itemCount: webinar.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Webinars(
                                webinar: webinar[index]['webinar'],
                                id: webinar[index]['id']);
                          },
                        ),
                      ),
                    ),
                  ]);
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No webinar available.'),
                  );
                } else {
                  return const Center(
                    child: Text('kok iso.'),
                  );
                }
              })
        ]),
      ),
      const Footer()
    ]);
  }
}