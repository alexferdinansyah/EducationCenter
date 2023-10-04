import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/components/footer.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                'Contact Us',
                style: GoogleFonts.poppins(
                  fontSize: width * .02,
                  fontWeight: FontWeight.w700,
                  color: CusColors.text,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 30),
                child: Text(
                  'Any question or remarks? Just write us a message!',
                  style: GoogleFonts.poppins(
                    fontSize: width * .01,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF717171),
                  ),
                ),
              ),
              Container(
                width: width * .9,
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.03),
                      blurRadius: 40,
                    )
                  ],
                  color: Colors.white,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width * .35,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white,
                        border: Border.all(
                          color: const Color(0xFFCCCCCC),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Contact Information',
                            style: GoogleFonts.poppins(
                              fontSize: width * .017,
                              fontWeight: FontWeight.w600,
                              color: CusColors.text,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Say something to start a live chat!',
                            style: GoogleFonts.poppins(
                              fontSize: width * .01,
                              fontWeight: FontWeight.w400,
                              color: CusColors.secondaryText,
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.phone,
                                  color: Color(0xFF0081FE),
                                ),
                              ),
                              Text(
                                '+62-21-7721-0358',
                                style: GoogleFonts.assistant(
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF0A142F),
                                  fontSize: width * 0.01,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 25),
                            child: Row(
                              children: [
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
                          const SizedBox(
                            height: 70,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset('assets/svg/facebook.svg'),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: SvgPicture.asset(
                                    'assets/svg/instagram.svg'),
                              ),
                              SvgPicture.asset('assets/svg/whatsapp.svg'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: width * .48,
                      margin: const EdgeInsets.only(left: 40),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextFormField(
                            cursorColor: const Color(0xFF8D8D8D),
                            style: GoogleFonts.poppins(
                              fontSize: width * .011,
                              fontWeight: FontWeight.w500,
                              color: CusColors.subHeader,
                            ),
                            decoration: InputDecoration(
                              label: Text(
                                'Name',
                                style: GoogleFonts.poppins(
                                    fontSize: width * .012,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF8D8D8D),
                                    height: .01),
                              ),
                              hintText: 'Write your name',
                              hintStyle: GoogleFonts.poppins(
                                fontSize: width * .011,
                                fontWeight: FontWeight.w400,
                                color: CusColors.subHeader.withOpacity(.5),
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF8D8D8D),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40),
                            child: TextFormField(
                              cursorColor: const Color(0xFF8D8D8D),
                              style: GoogleFonts.poppins(
                                fontSize: width * .011,
                                fontWeight: FontWeight.w500,
                                color: CusColors.subHeader,
                              ),
                              decoration: InputDecoration(
                                label: Text(
                                  'Email',
                                  style: GoogleFonts.poppins(
                                      fontSize: width * .012,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF8D8D8D),
                                      height: .01),
                                ),
                                hintText: 'Write your email',
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: width * .011,
                                  fontWeight: FontWeight.w400,
                                  color: CusColors.subHeader.withOpacity(.5),
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF8D8D8D),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TextFormField(
                            cursorColor: const Color(0xFF8D8D8D),
                            style: GoogleFonts.poppins(
                              fontSize: width * .011,
                              fontWeight: FontWeight.w500,
                              color: CusColors.subHeader,
                            ),
                            decoration: InputDecoration(
                              label: Text(
                                'Message',
                                style: GoogleFonts.poppins(
                                    fontSize: width * .012,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF8D8D8D),
                                    height: .01),
                              ),
                              hintText: 'Write your message',
                              hintStyle: GoogleFonts.poppins(
                                fontSize: width * .011,
                                fontWeight: FontWeight.w400,
                                color: CusColors.subHeader.withOpacity(.5),
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF8D8D8D),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 40),
                            width: width * .1,
                            decoration: BoxDecoration(
                                color: const Color(0xFF00C8FF),
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(.25),
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
                                              BorderRadius.circular(2))),
                                  padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry>(EdgeInsets.symmetric(
                                    vertical: height * .03,
                                  )),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  shadowColor: MaterialStateProperty.all(
                                      Colors.transparent)),
                              child: Text(
                                'Send Message',
                                style: GoogleFonts.mulish(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: width * .01,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
      const SizedBox(
        height: 60,
      ),
      const Footer()
    ]);
  }
}
