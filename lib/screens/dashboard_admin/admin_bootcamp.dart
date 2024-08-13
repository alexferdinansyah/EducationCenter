import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:project_tc/routes/routes.dart';

class AdminBootcamp extends StatefulWidget {
  const AdminBootcamp({super.key});

  @override
  State<AdminBootcamp> createState() => _AdminBootcampState();
}

class _AdminBootcampState extends State<AdminBootcamp> {
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
            Text('Bootcamp',
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
                  Get.rootDelegate.toNamed(routeCreateBootcamp);
                },
                child: Text(
                  'Add Bootcamp',
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