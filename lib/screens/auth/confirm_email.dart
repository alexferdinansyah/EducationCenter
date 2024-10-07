import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/components/footer.dart';
import 'package:project_tc/routes/routes.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ConfirmEmail extends StatefulWidget {
  const ConfirmEmail({super.key});

  @override
  State<ConfirmEmail> createState() => _ConfirmEmailState();
}

class _ConfirmEmailState extends State<ConfirmEmail> {
  bool? isVerify;
  Timer? timer;

  @override
  void initState() {
    isVerify = FirebaseAuth.instance.currentUser?.emailVerified;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    checkEmailVerified() async {
      await FirebaseAuth.instance.currentUser?.reload();

      setState(() {
        isVerify = FirebaseAuth.instance.currentUser!.emailVerified;
      });

      if (isVerify!) {
        if (context.mounted) {
          Navigator.pop(context);
        }
        timer?.cancel();
      }
    }

    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: ListView(
          children: [
            Container(
              color: CusColors.bg,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.rootDelegate.toNamed(routeHome);
                    },
                    child: Image.asset(
                      'assets/images/dec_logo2.png',
                      width: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .13,
                        tablet: width * .06,
                        desktop: width * .06,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 20),
                    child: SvgPicture.asset(
                      isVerify == true
                          ? 'assets/svg/success_verify.svg'
                          : 'assets/svg/verify_email.svg',
                      height: getValueForScreenType<double>(
                        context: context,
                        mobile: 300,
                        tablet: height / 2.6,
                        desktop: height / 2.3,
                      ),
                    ),
                  ),
                  Text(
                    isVerify == true
                        ? 'Berhasil memverifikasi akun Anda'
                        : 'Verifikasi akun Anda',
                    style: GoogleFonts.mPlus1(
                        fontSize: getValueForScreenType<double>(
                          context: context,
                          mobile: width * .025,
                          tablet: width * .022,
                          desktop: width * .017,
                        ),
                        fontWeight: FontWeight.bold,
                        color: CusColors.text),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  SizedBox(
                    width: getValueForScreenType<double>(
                      context: context,
                      mobile: width / 2,
                      tablet: width / 2.6,
                      desktop: width / 3,
                    ),
                    child: Text(
                      isVerify == true
                          ? 'Terima kasih telah memverifikasi akun Anda, sekarang Anda bisa mendapatkan tiga video pertama secara gratis, silakan buka dasbor untuk memeriksa kursus Anda'
                          : 'Terima kasih telah mendaftar, harap verifikasi akun Anda untuk mendapatkan tiga video pertama secara gratis. Klik tombol di bawah untuk memverifikasi akun Anda',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.mulish(
                          fontSize: getValueForScreenType<double>(
                            context: context,
                            mobile: width * .018,
                            tablet: width * .015,
                            desktop: width * .01,
                          ),
                          color: CusColors.subHeader.withOpacity(0.7),
                          height: 1.5),
                    ),
                  ),
                  if (Get.currentRoute.contains('learn-course') &&
                      isVerify == true)
                    Text(
                      'Mengarahkan',
                      style: GoogleFonts.mPlus1(
                          fontSize: getValueForScreenType<double>(
                            context: context,
                            mobile: width * .018,
                            tablet: width * .015,
                            desktop: width * .01,
                          ),
                          fontWeight: FontWeight.bold,
                          color: CusColors.text),
                    ),
                  Container(
                    height: getValueForScreenType<double>(
                      context: context,
                      mobile: 28,
                      tablet: 33,
                      desktop: 38,
                    ),
                    margin: EdgeInsets.symmetric(
                      vertical: getValueForScreenType<double>(
                        context: context,
                        mobile: 15,
                        tablet: 20,
                        desktop: 30,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        color: const Color(0xFF00C8FF),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.25),
                              spreadRadius: 0,
                              blurRadius: 20,
                              offset: const Offset(0, 4))
                        ]),
                    child: ElevatedButton(
                      onPressed: () {
                        if (isVerify == true) {
                          Get.offAndToNamed(routeLogin);
                        } else {
                          showModalConfirmEmail(width);
                          // FirebaseAuth.instance.currentUser
                          //     ?.sendEmailVerification();
                          // timer = Timer.periodic(
                          //   const Duration(seconds: 2),
                          //   (_) => checkEmailVerified(),
                          // );
                        }
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                        shadowColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: Text(
                        isVerify == true ? 'Go to dashboard' : 'Confirm',
                        style: GoogleFonts.mulish(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: getValueForScreenType<double>(
                            context: context,
                            mobile: width * .019,
                            tablet: width * .016,
                            desktop: width * .011,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (isVerify == false)
                    GestureDetector(
                      onTap: () {
                        Get.offAndToNamed(routeLogin);
                      },
                      child: Text(
                        'Ingatkan saya nanti',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.mulish(
                          fontSize: getValueForScreenType<double>(
                            context: context,
                            mobile: width * .018,
                            tablet: width * .015,
                            desktop: width * .01,
                          ),
                          color: CusColors.subHeader.withOpacity(0.5),
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * .045, vertical: height * .018),
              child: const Footer(),
            )
          ],
        ),
      ),
    );
  }

  showModalConfirmEmail(width) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Color(0xFFCCCCCC),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Verifikasi email',
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
                Container(
                    margin: EdgeInsets.only(
                      top: 4,
                      bottom: getValueForScreenType<double>(
                        context: context,
                        mobile: 6,
                        tablet: 8,
                        desktop: 10,
                      ),
                    ),
                    width: width * .03,
                    height: 1.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromRGBO(0, 0, 0, 1),
                    )),
                Text(
                  'Verifikasi email telah dikirimkan ke email Anda',
                  style: GoogleFonts.poppins(
                    fontSize: getValueForScreenType<double>(
                      context: context,
                      mobile: width * .016,
                      tablet: width * .013,
                      desktop: width * .008,
                    ),
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF7d848c),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  FirebaseAuth.instance.currentUser!.email!,
                  style: GoogleFonts.poppins(
                    fontSize: getValueForScreenType<double>(
                      context: context,
                      mobile: width * .016,
                      tablet: width * .013,
                      desktop: width * .008,
                    ),
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF7d848c),
                  ),
                ),
                Lottie.asset('assets/animations/email.json', height: 130),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    FirebaseAuth.instance.currentUser?.sendEmailVerification();
                  },
                  child: Text(
                    "Belum dapat emailnya?, kirim lagi",
                    style: GoogleFonts.poppins(
                      fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .016,
                        tablet: width * .013,
                        desktop: width * .008,
                      ),
                      fontWeight: FontWeight.bold,
                      color: CusColors.mainColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
