import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/services/auth_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(actions: [
        TextButton.icon(
          onPressed: () async {
            await _auth.signOut();
          },
          icon: const Icon(
            Icons.person,
            color: Colors.black,
          ),
          label: const Text(
            'Logout',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ]),
      body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: ListView(children: [
            Container(
                // padding: EdgeInsets.symmetric(
                //     horizontal: width * .045, vertical: height * .018),
                color: CusColors.bg,
                alignment: Alignment.centerLeft,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 4000,
                        width: 400,
                        color: const Color(0xFFF6F7F9),
                        child: Column(children: [
                          Image.asset(
                            'assets/images/logo_dac.png',
                            width: width * .14,
                          ),
                        ]),
                      ),
                      Container(
                        width: 530,
                        height: 270,
                        margin: const EdgeInsets.all(30),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          image: DecorationImage(
                              image: AssetImage('assets/images/micomet.jpg'),
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 90,
                              width: double.infinity - 10,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 12,
                                      spreadRadius: 1,
                                      color: Colors.black.withOpacity(.3))
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 3),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Tips to learn Figma from Profesional',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: width * .013),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 30,
                                            height: 30,
                                            decoration: const BoxDecoration(
                                              color: Colors.grey,
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/suichan.jpg'),
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              'Admin - 23 August 2023',
                                              style: GoogleFonts.poppins(
                                                  fontSize: width * .008,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]),
                              ),
                            )
                          ],
                        ),
                      )
                    ]))
          ])),
    );
  }
}

// class BlurredContainer extends StatelessWidget {
//   final double width;
//   final double height;
//   final Widget child;

//   const BlurredContainer(
//       {super.key,
//       required this.width,
//       required this.height,
//       required this.child});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: width,
//       height: height,
//       decoration: const BoxDecoration(
//         color: Colors.transparent, // Set the container's color to transparent
//       ),
//       child: ClipRRect(
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaY: 12), // Adjust the blur intensity
//           child: Container(
//             color: Colors.black
//                 .withOpacity(.17), // Adjust the background color and opacity
//             child: child,
//           ),
//         ),
//       ),
//     );
//   }
// }
