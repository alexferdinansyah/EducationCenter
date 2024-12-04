import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/services/function.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      // Check the sizing information here and return your UI
      if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
        return _defaultFooter(width, context);
      }
      if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
        return _defaultFooter(width, context);
      }
      if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
        return const FooterMobile();
      }
      return _defaultFooter(width, context);
    });
  }

  Widget _defaultFooter(width, context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 30),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(
              bottom: getValueForScreenType<double>(
                context: context,
                mobile: 15,
                tablet: 25,
                desktop: 20,
              ),
            ),
            height: 2,
            decoration: const BoxDecoration(
              color: Color(0xFF0081FE),
            ),
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Image.asset(
                            'assets/images/logo dec.png',
                            width: getValueForScreenType<double>(
                              context: context,
                              mobile: width * .24,
                              tablet: width * .22,
                              desktop: width * .14,
                            ),
                          ),
                          Image.asset(
                            'assets/images/3_prev_ui.png',
                            width: getValueForScreenType<double>(
                              context: context,
                              mobile: width * .24,
                              tablet: width * .22,
                              desktop: width * .14,
                            ),
                          ),
                        ]),
                        SizedBox(
                            width: getValueForScreenType<double>(
                              context: context,
                              mobile: width * .023,
                              tablet: width * .340,
                              desktop: width * .380,
                            ),
                            child: Text(
                                "DEC(Digital Education Center) adalah platform pembelajaran yang berfokus pada pengembangan program pendidikan berbasis pemrograman. DEC berkomitmen untuk menyajikan pengalaman pembelajaran interaktif, mendalam, dan relevan bagi para pelajar yang ingin meningkatkan keterampilan dan pengetahuan mereka di bidang pemrograman.",
                                style: TextStyle(height: 2),)),
                        Container(
                          margin: const EdgeInsets.only(
                            top: 50,
                            bottom: 50,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      right: getValueForScreenType<double>(
                                        context: context,
                                        mobile: 0,
                                        tablet: 2,
                                        desktop: 10,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.location_on,
                                      color: const Color(0xFF0081FE),
                                      size: getValueForScreenType<double>(
                                        context: context,
                                        mobile: 20,
                                        tablet: 22,
                                        desktop: 25,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Jl. Karet Hijau no.52 Beji Timur. Depok - Jawa Barat 16421',
                                    style: GoogleFonts.assistant(
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF0A142F),
                                      fontSize: getValueForScreenType<double>(
                                        context: context,
                                        mobile: width * .023,
                                        tablet: width * .012,
                                        desktop: width * .01,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 15, bottom: 35),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.phone,
                                      color: const Color(0xFF0081FE),
                                      size: getValueForScreenType<double>(
                                        context: context,
                                        mobile: 15,
                                        tablet: 20,
                                        desktop: 25,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 10, right: width * .05),
                                      child: Text(
                                        '+6285179943367',
                                        style: GoogleFonts.assistant(
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFF0A142F),
                                          fontSize:
                                              getValueForScreenType<double>(
                                            context: context,
                                            mobile: width * .023,
                                            tablet: width * .013,
                                            desktop: width * .01,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.mail,
                                        color: const Color(0xFF0081FE),
                                        size: getValueForScreenType<double>(
                                          context: context,
                                          mobile: 15,
                                          tablet: 20,
                                          desktop: 25,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'info@dac-solution.com',
                                      style: GoogleFonts.assistant(
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF0A142F),
                                        fontSize: getValueForScreenType<double>(
                                          context: context,
                                          mobile: width * .023,
                                          tablet: width * .013,
                                          desktop: width * .01,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 20),
                                child: Row(
                                  children: [
                                    Text(
                                      'Social Media',
                                      style: GoogleFonts.assistant(
                                        fontWeight: FontWeight.w500,
                                        color: CusColors.inactive,
                                        fontSize: getValueForScreenType<double>(
                                          context: context,
                                          mobile: width * .023,
                                          tablet: width * .013,
                                          desktop: width * .01,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: getValueForScreenType<double>(
                                          context: context,
                                          mobile: 20,
                                          tablet: 30,
                                          desktop: 40,
                                        ),
                                      ),
                                      child: SvgPicture.asset(
                                        'assets/svg/facebook.svg',
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: GestureDetector(
                                          onTap: launchInstagram,
                                          child: SvgPicture.asset(
                                              'assets/svg/Instagram.svg')),
                                    ),
                                    GestureDetector(
                                        onTap: launchWhatsapp,
                                        child: SvgPicture.asset(
                                          'assets/svg/whatsapp.svg',
                                          width: 22,
                                          height: 22,
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8, left: 15),
                                      child: GestureDetector(
                                          onTap: launchYoutube,
                                          child: Image.asset(
                                              'assets/images/youtube.png')),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 6, left: 15),
                                      child: GestureDetector(
                                          onTap: launchTikTok,
                                          child: Image.asset(
                                            'assets/images/tik-tok.png',
                                            width: 18,
                                            height: 18,
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 6, left: 15),
                                      child: GestureDetector(
                                          onTap: launchLinkIn,
                                          child: Image.asset(
                                            'assets/images/linkedin.png',
                                            width: 20,
                                            height: 20,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
                //  Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 100),
                  child: SafeArea(
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: getValueForScreenType<double>(
                              context: context,
                              mobile: 15,
                              tablet: 2,
                              desktop: 25,
                            ),
                          ),
                          const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Dec',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 15),
                                Text('Tentang'),
                                SizedBox(height: 15),
                                Text('karir')
                              ]),
                          SizedBox(
                            width: getValueForScreenType<double>(
                              context: context,
                              mobile: 15,
                              tablet: 20,
                              desktop: 80,
                            ),
                          ),
                          const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Program',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 15),
                                Text('Course'),
                                SizedBox(height: 15),
                                Text('Mini BootCamp'),
                                SizedBox(height: 15),
                                Text('webinar'),
                                SizedBox(height: 15),
                                Text('review cv'),
                              ]),
                          SizedBox(
                            width: getValueForScreenType<double>(
                              context: context,
                              mobile: 15,
                              tablet: 20,
                              desktop: 80,
                            ),
                          ),
                          const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Produk',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                                        SizedBox(height: 15,),
                                        Text('E-Book'),
                            
                              ]),
                          SizedBox(
                            width: getValueForScreenType<double>(
                              context: context,
                              mobile: 15,
                              tablet: 20,
                              desktop: 80,
                            ),
                          ),
                          const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Lainnya',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 15),
                                Text('FAQ'),
                                Text('Article'),
                              ]),
                        ]),
                  ),
                ),
                const Spacer(),
                // Container(
                //   margin: EdgeInsets.only(top: 100),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Row(
                //         children: [
                //           Padding(
                //             padding: const EdgeInsets.only(right: 10),
                //             child: Icon(
                //               Icons.location_on,
                //               color: const Color(0xFF0081FE),
                //               size: getValueForScreenType<double>(
                //                 context: context,
                //                 mobile: 20,
                //                 tablet: 20,
                //                 desktop: 25,
                //               ),
                //             ),
                //           ),
                //           Text(
                //             'Jl. Karet Hijau no.52 Beji Timur. Depok - Jawa Barat 16421',
                //             style: GoogleFonts.assistant(
                //               fontWeight: FontWeight.w500,
                //               color: const Color(0xFF0A142F),
                //               fontSize: getValueForScreenType<double>(
                //                 context: context,
                //                 mobile: width * .023,
                //                 tablet: width * .013,
                //                 desktop: width * .01,
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.only(top: 15, bottom: 35),
                //         child: Row(
                //           children: [
                //             Icon(
                //               Icons.phone,
                //               color: const Color(0xFF0081FE),
                //               size: getValueForScreenType<double>(
                //                 context: context,
                //                 mobile: 15,
                //                 tablet: 20,
                //                 desktop: 25,
                //               ),
                //             ),
                //             Padding(
                //               padding:
                //                   EdgeInsets.only(left: 10, right: width * .05),
                //               child: Text(
                //                 '+62-21-7721-0358',
                //                 style: GoogleFonts.assistant(
                //                   fontWeight: FontWeight.w500,
                //                   color: const Color(0xFF0A142F),
                //                   fontSize: getValueForScreenType<double>(
                //                     context: context,
                //                     mobile: width * .023,
                //                     tablet: width * .013,
                //                     desktop: width * .01,
                //                   ),
                //                 ),
                //               ),
                //             ),
                //             Padding(
                //               padding: const EdgeInsets.only(right: 10),
                //               child: Icon(
                //                 Icons.mail,
                //                 color: const Color(0xFF0081FE),
                //                 size: getValueForScreenType<double>(
                //                   context: context,
                //                   mobile: 15,
                //                   tablet: 20,
                //                   desktop: 25,
                //                 ),
                //               ),
                //             ),
                //             Text(
                //               'info@dac-solution.com',
                //               style: GoogleFonts.assistant(
                //                 fontWeight: FontWeight.w500,
                //                 color: const Color(0xFF0A142F),
                //                 fontSize: getValueForScreenType<double>(
                //                   context: context,
                //                   mobile: width * .023,
                //                   tablet: width * .013,
                //                   desktop: width * .01,
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //       Row(
                //         children: [
                //           Text(
                //             'Social Media',
                //             style: GoogleFonts.assistant(
                //               fontWeight: FontWeight.w500,
                //               color: CusColors.inactive,
                //               fontSize: getValueForScreenType<double>(
                //                 context: context,
                //                 mobile: width * .023,
                //                 tablet: width * .013,
                //                 desktop: width * .01,
                //               ),
                //             ),
                //           ),
                //           Padding(
                //             padding: EdgeInsets.only(
                //               left: getValueForScreenType<double>(
                //                 context: context,
                //                 mobile: 20,
                //                 tablet: 30,
                //                 desktop: 40,
                //               ),
                //             ),
                //             child: SvgPicture.asset(
                //               'assets/svg/facebook.svg',
                //             ),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.symmetric(horizontal: 15),
                //             child: GestureDetector(
                //                 onTap: launchInstagram,
                //                 child: SvgPicture.asset(
                //                     'assets/svg/Instagram.svg')),
                //           ),
                //           GestureDetector(
                //               onTap: launchWhatsapp,
                //               child:
                //                   SvgPicture.asset('assets/svg/whatsapp.svg')),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
            const Text('Metode Pembayaran'),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SingleChildScrollView(
                scrollDirection:
                    Axis.horizontal, // Enables horizontal scrolling
                child: Row(children: [
                  Container(
                    margin: EdgeInsets.only(top: 5, left: 5),
                    width: 120,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: ClipRRect(
                      child: Image.asset(
                        'assets/banks/Logo_BCA.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, left: 5),
                    width: 120,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: ClipRRect(
                      child: Image.asset(
                        'assets/banks/Logo_BNI.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, left: 5),
                    width: 120,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: ClipRRect(
                      child: Image.asset(
                        'assets/banks/Logo_BRI.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, left: 5),
                    width: 120,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: ClipRRect(
                      child: Image.asset(
                        'assets/banks/Logo_BSI.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, left: 5),
                    width: 120,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: ClipRRect(
                      child: Image.asset(
                        'assets/banks/Logo_BTN.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, left: 5),
                    width: 120,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: ClipRRect(
                      child: Image.asset(
                        'assets/banks/Logo_mandiri.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, left: 5),
                    width: 120,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: ClipRRect(
                      child: Image.asset(
                        'assets/banks/Logo_permata.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            const Text('E-Money'),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5, left: 5),
                  width: 120,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.grey, width: 1)),
                  child: ClipRRect(
                    // borderRadius: BorderRadius.circular(15.0),
                    child: Image.asset(
                      'assets/banks/Logo_Dana.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, left: 5),
                  width: 120,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.grey, width: 1)),
                  child: ClipRRect(
                    // borderRadius: BorderRadius.circular(15.0),
                    child: Image.asset(
                      'assets/banks/Logo_Gopay.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, left: 5),
                  width: 120,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.grey, width: 1)),
                  child: ClipRRect(
                    // borderRadius: BorderRadius.circular(15.0),
                    child: Image.asset(
                      'assets/banks/Logo_Ovo.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            )
          ]),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(
              top: getValueForScreenType<double>(
                context: context,
                mobile: 20,
                tablet: 50,
                desktop: 80,
              ),
              bottom: getValueForScreenType<double>(
                context: context,
                mobile: 5,
                tablet: 15,
                desktop: 25,
              ),
            ),
            height: 2,
            decoration: BoxDecoration(
              color: const Color(0xFF0081FE).withOpacity(0.2),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '© Copyright PT DAC Solution Informatika',
                style: GoogleFonts.assistant(
                  fontWeight: FontWeight.w500,
                  color: CusColors.inactive,
                  fontSize: getValueForScreenType<double>(
                    context: context,
                    mobile: width * .023,
                    tablet: width * .013,
                    desktop: width * .01,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FooterMobile extends StatelessWidget {
  const FooterMobile({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(top: 100, bottom: 30),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 10),
            height: 2,
            decoration: const BoxDecoration(
              color: Color(0xFF0081FE),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/Logo DAC-Informatika.png',
                width: width * .27,
              ),
              Image.asset(
                'assets/images/3_prev_ui.png',
                width: width * .27,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: getValueForScreenType<double>(
                          context: context,
                          mobile: width * .315,
                          tablet: width * .340,
                          desktop: width * .380,
                        ),
                        child: Text(
                          "DEC(Digital Education Center) adalah platform pembelajaran yang berfokus pada pengembangan program pendidikan berbasis pemrograman. DEC berkomitmen untuk menyajikan pengalaman pembelajaran interaktif, mendalam, dan relevan bagi para pelajar yang ingin meningkatkan keterampilan dan pengetahuan mereka di bidang pemrograman.",
                          style: GoogleFonts.assistant(
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF0A142F),
                            fontSize: width * 0.023,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: getValueForScreenType<double>(
                          context: context,
                          mobile: 15,
                          tablet: 35,
                          desktop: 80,
                        ),
                      ),
                      SafeArea(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: getValueForScreenType<double>(
                                  context: context,
                                  mobile: 15,
                                  tablet: 20,
                                  desktop: 25,
                                ),
                              ),
                              Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start, // Tambahkan ini agar Row rata ke atas
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment
                                          .start, // Pastikan elemen di dalam Column juga rata ke atas
                                      children: [
                                        Text(
                                          'Dec',
                                          style: GoogleFonts.assistant(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF0A142F),
                                            fontSize: width * 0.023,
                                          ),
                                        ),
                                        SizedBox(height: 15),
                                        Text(
                                          'Tentang',
                                          style: GoogleFonts.assistant(
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF0A142F),
                                            fontSize: width * 0.023,
                                          ),
                                        ),
                                        SizedBox(height: 15),
                                        Text(
                                          'karir',
                                          style: GoogleFonts.assistant(
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF0A142F),
                                            fontSize: width * 0.023,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: getValueForScreenType<double>(
                                        context: context,
                                        mobile: 48,
                                        tablet: 35,
                                        desktop: 80,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment
                                          .start, // Menyelaraskan elemen Column ke atas
                                      children: [
                                        Text(
                                          'Produk',
                                          style: GoogleFonts.assistant(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF0A142F),
                                            fontSize: width * 0.023,
                                          ),
                                        ),
                                        SizedBox(height: 15),
                                        Text(
                                          'Video Learning',
                                          style: GoogleFonts.assistant(
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF0A142F),
                                            fontSize: width * 0.023,
                                          ),
                                        ),
                                        SizedBox(height: 15),
                                        Text(
                                          'e-book',
                                          style: GoogleFonts.assistant(
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF0A142F),
                                            fontSize: width * 0.023,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: getValueForScreenType<double>(
                                  context: context,
                                  mobile: 15,
                                  tablet: 35,
                                  desktop: 80,
                                ),
                              ),
                              Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start, // Menyelaraskan semua elemen Row ke atas
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment
                                          .start, // Tambahkan ini juga untuk Column kedua
                                      children: [
                                        Text(
                                          'Program',
                                          style: GoogleFonts.assistant(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF0A142F),
                                            fontSize: width * 0.023,
                                          ),
                                        ),
                                        SizedBox(height: 15),
                                        Text(
                                          'Course',
                                          style: GoogleFonts.assistant(
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF0A142F),
                                            fontSize: width * 0.023,
                                          ),
                                        ),
                                        SizedBox(height: 15),
                                        Text(
                                          'Mini BootCamp',
                                          style: GoogleFonts.assistant(
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF0A142F),
                                            fontSize: width * 0.023,
                                          ),
                                        ),
                                        SizedBox(height: 15),
                                        Text(
                                          'webinar',
                                          style: GoogleFonts.assistant(
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF0A142F),
                                            fontSize: width * 0.023,
                                          ),
                                        ),
                                        SizedBox(height: 15),
                                        Text(
                                          'review cv',
                                          style: GoogleFonts.assistant(
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF0A142F),
                                            fontSize: width * 0.023,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: getValueForScreenType<double>(
                                        context: context,
                                        mobile: 12,
                                        tablet: 35,
                                        desktop: 80,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment
                                          .start, // Menyelaraskan elemen Column ke atas
                                      children: [
                                        Text(
                                          'Lainnya',
                                          style: GoogleFonts.assistant(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF0A142F),
                                            fontSize: width * 0.023,
                                          ),
                                        ),
                                        SizedBox(height: 15),
                                        Text(
                                          'FAQ',
                                          style: GoogleFonts.assistant(
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF0A142F),
                                            fontSize: width * 0.023,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ]),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getValueForScreenType<double>(
                      context: context,
                      mobile: 15,
                      tablet: 35,
                      desktop: 80,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.location_on,
                              color: Color(0xFF0081FE),
                              size: 20,
                            ),
                          ),
                          Text(
                            'Jl. Karet Hijau no.52 Beji Timur,Depok - Jawa Barat 16421',
                            style: GoogleFonts.assistant(
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF0A142F),
                              fontSize: width * 0.023,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 12),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.phone,
                              color: Color(0xFF0081FE),
                              size: 20,
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 10, right: width * .05),
                              child: Text(
                                '+62-21-7721-0358',
                                style: GoogleFonts.assistant(
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF0A142F),
                                  fontSize: width * 0.023,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 18),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.mail,
                                color: Color(0xFF0081FE),
                                size: 20,
                              ),
                            ),
                            Text(
                              'info@dac-solution.com',
                              style: GoogleFonts.assistant(
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF0A142F),
                                fontSize: width * 0.023,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Social Media',
                        style: GoogleFonts.assistant(
                          fontWeight: FontWeight.w500,
                          color: CusColors.inactive,
                          fontSize: width * 0.023,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: SvgPicture.asset('assets/svg/facebook.svg'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: GestureDetector(
                            onTap: launchInstagram,
                            child:
                                SvgPicture.asset('assets/svg/Instagram.svg')),
                      ),
                      GestureDetector(
                          onTap: launchWhatsapp,
                          child: SvgPicture.asset('assets/svg/whatsapp.svg')),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, left: 15),
                        child: GestureDetector(
                            onTap: launchYoutube,
                            child: Image.asset('assets/images/youtube.png')),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6, left: 15),
                        child: GestureDetector(
                            onTap: launchTikTok,
                            child: Image.asset(
                              'assets/images/tik-tok.png',
                              width: 18,
                              height: 18,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6, left: 15),
                        child: GestureDetector(
                            onTap: launchLinkIn,
                            child: Image.asset(
                              'assets/images/linkedin.png',
                              width: 20,
                              height: 20,
                            )),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: getValueForScreenType<double>(
              context: context,
              mobile: 15,
              tablet: 35,
              desktop: 80,
            ),
          ),
          Text(
            'Metode Pembayaran',
            style: GoogleFonts.assistant(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0A142F),
              fontSize: width * 0.023,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Enables horizontal scrolling
              child: Row(children: [
                Container(
                  margin: EdgeInsets.only(top: 5, left: 5),
                  width: 120,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: ClipRRect(
                    child: Image.asset(
                      'assets/banks/Logo_BCA.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, left: 5),
                  width: 120,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: ClipRRect(
                    child: Image.asset(
                      'assets/banks/Logo_BNI.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, left: 5),
                  width: 120,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: ClipRRect(
                    child: Image.asset(
                      'assets/banks/Logo_BRI.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, left: 5),
                  width: 120,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: ClipRRect(
                    child: Image.asset(
                      'assets/banks/Logo_BSI.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, left: 5),
                  width: 120,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: ClipRRect(
                    child: Image.asset(
                      'assets/banks/Logo_BTN.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, left: 5),
                  width: 120,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: ClipRRect(
                    child: Image.asset(
                      'assets/banks/Logo_mandiri.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, left: 5),
                  width: 120,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: ClipRRect(
                    child: Image.asset(
                      'assets/banks/Logo_permata.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ]),
            ),
          ),
          Text(
            'E-Money',
            style: GoogleFonts.assistant(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0A142F),
              fontSize: width * 0.023,
            ),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 5, left: 5),
                width: 120,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.grey, width: 1)),
                child: ClipRRect(
                  // borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset(
                    'assets/banks/Logo_Dana.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5, left: 5),
                width: 120,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.grey, width: 1)),
                child: ClipRRect(
                  // borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset(
                    'assets/banks/Logo_Gopay.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5, left: 5),
                width: 120,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.grey, width: 1)),
                child: ClipRRect(
                  // borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset(
                    'assets/banks/Logo_Ovo.jpg',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 30, bottom: 15),
            height: 2,
            decoration: BoxDecoration(
              color: const Color(0xFF0081FE).withOpacity(0.2),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '© Copyright PT DAC Solution Informatika',
                style: GoogleFonts.assistant(
                  fontWeight: FontWeight.w500,
                  color: CusColors.inactive,
                  fontSize: width * 0.023,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
