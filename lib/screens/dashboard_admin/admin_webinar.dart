import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/components/custom_alert.dart';
import 'package:project_tc/components/loading.dart';
import 'package:project_tc/components/webinars.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/models/webinar.dart';
import 'package:project_tc/routes/routes.dart';
import 'package:project_tc/screens/dashboard_admin/create_webinar.dart';
import 'package:project_tc/services/firestore_service.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';

class AdminWebinar extends StatefulWidget {
  const AdminWebinar({super.key});

  @override
  State<AdminWebinar> createState() => _AdminWebinarState();
}

class _AdminWebinarState extends State<AdminWebinar> {
  List<Map> webinars = [];
  bool initWebinar = false;

  void filterWebinars(String criteria) {
    setState(() {
      webinars = webinars.where((webinar) {
        if (criteria == 'All webinar') {
          return true;
        } else if (criteria == 'Draft') {
          return webinar['webinar'].isDraft == true;
        }
        return false;
      }).toList();
    });
  }

  void updateInitWebinar(bool newValue) {
    setState(() {
      initWebinar = newValue;
    });
  }

  List<bool> isHovered = [false, false];
  List<bool> isSelected = [true, false];

  // Define the list of criteria and button labels
  List<String> filterCriteria = [
    'All Webinars',
    'Draft',
  ];
  @override
  Widget build(BuildContext context) {
    
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final user = Provider.of<UserModel>(context);
    final FirestoreService fireStore = FirestoreService(uid: user!.uid);

    return StreamBuilder(
        stream: fireStore.allWebinar,
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active &&
              !initWebinar) {
            initWebinar = true;
            Future.delayed(const Duration(milliseconds: 300),
                () => filterWebinars('All Webinar'));
          }
          if (snapshot.hasData) {
            final List<Map> dataMaps = snapshot.data!;
            final dataWebinars = dataMaps.map((data) {
              return {
                'id': data['id'],
                'webinar': data['webinar'] as Webinar,
              };
            }).toList();

            webinars = List.from(dataWebinars);

            return Container(
              width: getValueForScreenType<double>(
                context: context,
                mobile: width * .86,
                tablet: width * .79,
                desktop: width * .83,
              ),
              height: getValueForScreenType<double>(
                context: context,
                mobile: height - 40,
                tablet: height - 50,
                desktop: height - 60,
              ),
              color: CusColors.bg,
              child: ListView(
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getValueForScreenType<double>(
                            context: context,
                            mobile: 20,
                            tablet: 30,
                            desktop: 40,
                          ),
                          vertical: getValueForScreenType<double>(
                            context: context,
                            mobile: 20,
                            tablet: 30,
                            desktop: 35,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'webinars',
                              style: GoogleFonts.poppins(
                                fontSize: getValueForScreenType<double>(
                                  context: context,
                                  mobile: width * .022,
                                  tablet: width * .019,
                                  desktop: width * .014,
                                ),
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF1F384C),
                              ),
                            ),
                            SizedBox(
                              height: getValueForScreenType<double>(
                                context: context,
                                mobile: 20,
                                tablet: 25,
                                desktop: 40,
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: getValueForScreenType<double>(
                                context: context,
                                mobile: 38,
                                tablet: 45,
                                desktop: 50,
                              ),
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Row(
                                    children: List.generate(
                                        filterCriteria.length, (index) {
                                      return MouseRegion(
                                        onEnter: (_) {
                                          // Set the hover state
                                          setState(() {
                                            isHovered[index] = true;
                                          });
                                        },
                                        onExit: (_) {
                                          // Reset the hover state
                                          setState(() {
                                            isHovered[index] = false;
                                          });
                                        },
                                        child: AnimatedContainer(
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                          duration:
                                              const Duration(milliseconds: 300),
                                          height: getValueForScreenType<double>(
                                            context: context,
                                            mobile: 28,
                                            tablet: 35,
                                            desktop: 40,
                                          ),
                                          width: getValueForScreenType<double>(
                                            context: context,
                                            mobile: width * .2,
                                            tablet: width * .15,
                                            desktop: width * .1,
                                          ),
                                          decoration: BoxDecoration(
                                            color: isSelected[index]
                                                ? CusColors.accentBlue
                                                : isHovered[index]
                                                    ? CusColors.accentBlue
                                                    : Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(64),
                                            border: Border.all(
                                              color: CusColors.accentBlue,
                                              width: 1,
                                            ),
                                          ),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                for (int i = 0;
                                                    i < isSelected.length;
                                                    i++) {
                                                  isSelected[i] = (i == index);
                                                }
                                              });
                                              filterWebinars(
                                                  filterCriteria[index]);
                                            },
                                            style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
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
                                              filterCriteria[index],
                                              style: GoogleFonts.mulish(
                                                fontWeight: FontWeight.w700,
                                                color: isSelected[index]
                                                    ? Colors.white
                                                    : isHovered[index]
                                                        ? Colors.white
                                                        : CusColors.accentBlue,
                                                fontSize: getValueForScreenType<
                                                    double>(
                                                  context: context,
                                                  mobile: width * .018,
                                                  tablet: width * .015,
                                                  desktop: width * .01,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ),



                            
                            SizedBox(
                              height: webinars.length / 5 > 1 &&
                                      webinars.length / 5 < 2
                                  ? height / 3.3 * 2
                                  : webinars.length / 5 >= 2
                                      ? height /
                                          2.5 *
                                          (webinars.length / 5)
                                      : height / 1.6,
                              child: webinars.isEmpty
                                  ? 
                                  Center(
                                      child: Column(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svg/course_none.svg',
                                          height: getValueForScreenType<double>(
                                            context: context,
                                            mobile: height / 3,
                                            tablet: height / 2.7,
                                            desktop: height / 2.3,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15),
                                          child: Text(
                                            "There's no webinar in here, click button below to create webinar",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                              fontSize:
                                                  getValueForScreenType<double>(
                                                context: context,
                                                mobile: width * .021,
                                                tablet: width * .018,
                                                desktop: width * .013,
                                              ),
                                              color: const Color(0xFF1F384C),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    )
                            
                                   : ScrollConfiguration(
                                      behavior: ScrollConfiguration.of(context)
                                          .copyWith(scrollbars: false),
                                      child: MasonryGridView.count(
                                        physics: const ScrollPhysics(
                                            parent: BouncingScrollPhysics()),
                                        crossAxisSpacing: width * .02,
                                        mainAxisSpacing: 16.0,
                                        crossAxisCount:
                                            getValueForScreenType<int>(
                                          context: context,
                                          mobile: 2,
                                          tablet: 3,
                                          desktop: 4,
                                        ),
                                        itemCount: webinars.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return AdminWebinars(
                                            webinar: webinars[index]
                                                ['webinar'],
                                            isAdmin: true,
                                            id: webinars[index]['id'],
                                            onPressed: () async {
                                              final result = await showDialog(
                                                context: context,
                                                builder: (_) {
                                                  return CreateWebinar(
                                                    webinar:
                                                        webinars[index]
                                                            ['webinar'],
                                                    webinarId:
                                                        webinars[index]
                                                            ['id'],
                                                  );
                                                },
                                              );

                                              if (result != null) {
                                                setState(() {
                                                  initWebinar = result;
                                                });
                                              }
                                            },
                                            onDelete: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (_) {
                                                    return CustomAlert(
                                                      cancelButton: true,
                                                      title: 'Warning',
                                                      message:
                                                          'Are you sure want to delete this?',
                                                      animatedIcon:
                                                          'assets/animations/alert.json',
                                                      onPressed: () async {
                                                        Get.back();
                                                        final result = await fireStore
                                                            .deleteWebinar(
                                                                webinars[
                                                                        index]
                                                                    ['id']);
                                                        if (result ==
                                                            'Success delete webinar') {
                                                          if (context.mounted) {
                                                            showDialog(
                                                              context: context,
                                                              builder: (_) {
                                                                return CustomAlert(
                                                                  onPressed:
                                                                      () => Get
                                                                          .back(),
                                                                  title:
                                                                      'Success',
                                                                  message:
                                                                      result,
                                                                  animatedIcon:
                                                                      'assets/animations/check.json',
                                                                );
                                                              },
                                                            );
                                                            setState(() {
                                                              initWebinar =
                                                                  false;
                                                            });
                                                          }
                                                        } else {
                                                          if (context.mounted) {
                                                            showDialog(
                                                              context: context,
                                                              builder: (_) {
                                                                return CustomAlert(
                                                                  onPressed:
                                                                      () => Get
                                                                          .back(),
                                                                  title:
                                                                      'Failed',
                                                                  message:
                                                                      result,
                                                                  animatedIcon:
                                                                      'assets/animations/failed.json',
                                                                );
                                                              },
                                                            );
                                                          }
                                                        }
                                                      },
                                                    );
                                                  });
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ),





                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 30,
                        right: 30,
                        child: FloatingActionButton(
                          onPressed: () async {
                            final result = await showDialog(
                              context: context,
                              builder: (_) {
                                return const CreateWebinar();
                              },
                            );
                            if (result != null) {
                              setState(() {
                                initWebinar = result;
                              });
                            }
                          },
                          backgroundColor: CusColors.accentBlue,
                          child: const Icon(Icons.add),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No webinar available.'),
            );
          } else {
            return const Center(
              child: Text('kok iso.'),
            );
          }
        });
  }
}
