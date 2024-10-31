import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/components/loading.dart';
import 'package:project_tc/components/videoLearnings.dart';
import 'package:project_tc/models/learning.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/screens/learning/learning_video.dart';
import 'package:project_tc/services/firestore_service.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Produk extends StatefulWidget {
  final UserModel user;
  const Produk({Key? key, required this.user}) : super(key: key);

  @override
  State<Produk> createState() => _ProdukState();
}

class _ProdukState extends State<Produk> {
  List<Map> produks = [];
  List<Map> filteredProduks = [];
  bool initProduk = false;

  void filteredProduksByType(String criteria) {
    setState(() {
      filteredProduks = produks.where((produk) {
        if (criteria == 'All Produk') {
          return true;
        } else if (criteria == 'Video Learning') {
          return produk['produk'] is MyVideoLearning;
        } else if (criteria == 'E-Book') {
          return produk['produk'] is VideoLearning;
        }
        return false;
      }).toList();
    });
  }

  List<bool> isHovered = [false, false, false];
  List<bool> isSelected = [true, false, false];
  bool isHover = false;

  List<String> filterCriteria = [
    'All Produk',
    'Video Learning',
    'E-Book',
  ];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return StreamBuilder(
        stream: FirestoreService(uid: widget.user.uid)
            .videoLearningAndEBookStream(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active &&
              !initProduk) {
            initProduk = true;
            Future.delayed(const Duration(milliseconds: 300),
                () => filteredProduksByType('All Produk'));
          }
          if (snapshot.hasData) {
            final List<Map> dataMaps = snapshot.data!;
            final dataProduks = dataMaps.map((data) {
              return {
                'id': data['id'],
                'produk': data['videoLearning'] as LearningVideo ,
              };
            }).toList();
            produks = List.from(dataProduks);

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
                  Padding(
                    // kanan kiri atas
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
                          'Produk',
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
                            // tombol
                            scrollDirection: Axis.horizontal,
                            children: [
                              Row(
                                children: List.generate(filterCriteria.length,
                                    (index) {
                                  return MouseRegion(
                                    onEnter: (_) {
                                      setState(() {
                                        isHovered[index] = true;
                                      });
                                    },
                                    onExit: (_) {
                                      setState(() {
                                        isHovered[index] = false;
                                      });
                                    },
                                    child: AnimatedContainer(
                                      margin: const EdgeInsets.only(right: 10),
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
                                        borderRadius: BorderRadius.circular(64),
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
                                          filteredProduksByType(
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
                                            fontSize:
                                                getValueForScreenType<double>(
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
                          height: getValueForScreenType<double>(
                            context: context,
                            mobile: 20,
                            tablet: 40,
                            desktop: 40,
                          ),
                        ),
                        SizedBox(
                          height: filteredProduks.length / 5 > 1 &&
                                  filteredProduks.length / 5 < 2
                              ? height / 1.7
                              : filteredProduks.length / 5 >= 2
                                  ? height / 2.5 * (filteredProduks.length / 5)
                                  : height / 1.6,
                          child: filteredProduks.isEmpty
                              ? Center(
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
                                        "You don't have any produk, \n you can search for produk according to your needs",
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
                                ))
                              : ScrollConfiguration(
                                  behavior: ScrollConfiguration.of(context)
                                      .copyWith(scrollbars: false),
                                  child: MasonryGridView.count(
                                    physics: const ScrollPhysics(
                                        parent: BouncingScrollPhysics()),
                                    crossAxisSpacing: width * .02,
                                    mainAxisSpacing: 16.0,
                                    crossAxisCount: getValueForScreenType<int>(
                                      context: context,
                                      mobile: 2,
                                      tablet: 3,
                                      desktop: 5,
                                    ),
                                    itemCount: filteredProduks.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                          // return MyVideoLearning(
                                          //   videoLearning: filteredProduks[index]['videoLearning'],
                                          //   id: filteredProduks[index]['id'],
                                          //   isPaid: filteredProduks[index]['isPaid'],
                                          //   isAdmin: false,
                                          // );
                                      final produk = filteredProduks[index];
                                      // Assuming you have a way to determine if the  is a Bootcamp or Webinar
                                      if (produk['produk'] is MyVideoLearning) {
                                        return MyVideoLearning(
                                            id: produk['id'],
                                            videoLearning: produk['produk'], isAdmin: false,);
                                      } else {
                                        // Handle other types or default case
                                        return Container(); // Empty widget or error handling
                                      }
                                    },
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No produk available.'),
            );
          } else {
            return const Center(
              child: Text('An error occurred.'),
            );
          }
        });
  }
}