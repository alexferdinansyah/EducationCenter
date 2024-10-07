import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AdminPortopolio extends StatefulWidget {
  const AdminPortopolio({super.key});

  @override
  State<AdminPortopolio> createState() => _AdminPortopolioState();
}

class _AdminPortopolioState extends State<AdminPortopolio> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        getValueForScreenType<double>(
          context: context,
          mobile: 15,
          tablet: 15,
          desktop: 40,
        ),
        getValueForScreenType<double>(
          context: context,
          mobile: 15,
          tablet: 15,
          desktop: 40,
        ),
        getValueForScreenType<double>(
          context: context,
          mobile: 15,
          tablet: 15,
          desktop: 40,
        ),
        10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
        Row(
          children: [
            Text('Review Cv/Portopolio',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                      const SizedBox(width: 10),
                      ElevatedButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(
                    const Color(0xFF4351FF),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    Colors.white,
                  ),
                  elevation: MaterialStateProperty.all(0),
                  side: MaterialStateProperty.all(BorderSide(
                    color: Color(0xFF4351FF),
                  )),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                onPressed: () {
                  // Get.rootDelegate.toNamed(routeCreateBootcamp);
                },
                child: Text(
                  'Add Review',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF4351FF),
                  ),
                ),
              )
          ],
        ),
      ]),
    );
  }
}