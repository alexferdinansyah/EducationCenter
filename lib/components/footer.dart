import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/constants.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 100, bottom: 30),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 50),
            height: 2,
            decoration: const BoxDecoration(
              color: Color(0xFF0081FE),
            ),
          ),
          Row(
            children: [
              Image.asset(
                'assets/images/logo_dac.png',
                width: width * .14,
              ),
              const Spacer(),
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
                        ),
                      ),
                      Text(
                        'Jl. Karet Hijau no.52 Beji Timur,Depok - Jawa Barat 16421',
                        style: GoogleFonts.assistant(
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF0A142F),
                          fontSize: width * 0.01,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 35),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.phone,
                          color: Color(0xFF0081FE),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 10, right: width * .05),
                          child: Text(
                            '+62-21-7721-0358',
                            style: GoogleFonts.assistant(
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF0A142F),
                              fontSize: width * 0.01,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.mail,
                            color: Color(0xFF0081FE),
                          ),
                        ),
                        Text(
                          'info@dac-solution.com',
                          style: GoogleFonts.assistant(
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF0A142F),
                            fontSize: width * 0.01,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Social Media',
                        style: GoogleFonts.assistant(
                          fontWeight: FontWeight.w500,
                          color: CusColors.inactive,
                          fontSize: width * 0.01,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: SvgPicture.asset('assets/svg/facebook.svg'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: SvgPicture.asset('assets/svg/Instagram.svg'),
                      ),
                      SvgPicture.asset('assets/svg/whatsapp.svg'),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 80, bottom: 25),
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
                  fontSize: width * 0.01,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
