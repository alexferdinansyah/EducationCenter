import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AdminEbook extends StatefulWidget {
  const AdminEbook({super.key});

  @override
  State<AdminEbook> createState() => _AdminEbookState();
}

class _AdminEbookState extends State<AdminEbook> {
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
            Text('E-Book',
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
                  'Add E-Book',
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