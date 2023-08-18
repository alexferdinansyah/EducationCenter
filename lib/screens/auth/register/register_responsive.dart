import 'package:flutter/material.dart';
import 'package:project_tc/screens/auth/register/register_mobile.dart';
import 'package:project_tc/screens/auth/register/register_website.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ResponsiveRegister extends StatefulWidget {
  const ResponsiveRegister({super.key});

  @override
  State<ResponsiveRegister> createState() => _ResponsiveRegisterState();
}

class _ResponsiveRegisterState extends State<ResponsiveRegister> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        // Check the sizing information here and return your UI
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          return const RegisterWebsite();
        }

        if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
          return const RegisterMobile();
        }

        return Container(color: Colors.white);
      },
    );
  }
}
