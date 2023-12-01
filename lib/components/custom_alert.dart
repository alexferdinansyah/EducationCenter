import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CustomAlert extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final String message;
  final String animatedIcon;
  const CustomAlert({
    super.key,
    required this.onPressed,
    required this.title,
    required this.message,
    required this.animatedIcon,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
              title,
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
            Text(
              message,
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
            Lottie.asset(animatedIcon, height: 130),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: getValueForScreenType<double>(
                context: context,
                mobile: 28,
                tablet: 35,
                desktop: 40,
              ),
              child: ElevatedButton(
                onPressed: onPressed,
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(
                        horizontal: getValueForScreenType<double>(
                          context: context,
                          mobile: 28,
                          tablet: 40,
                          desktop: 60,
                        ),
                      ),
                    ),
                    foregroundColor: MaterialStateProperty.all(
                      const Color(0xFF4351FF),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      const Color(0xFF4351FF),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    )),
                child: Text(
                  'Ok',
                  style: GoogleFonts.poppins(
                    fontSize: getValueForScreenType<double>(
                      context: context,
                      mobile: width * .018,
                      tablet: width * .015,
                      desktop: width * .01,
                    ),
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
