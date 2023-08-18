import 'package:flutter/material.dart';
import 'package:project_tc/screens/auth/login/sign_in_mobile.dart';
import 'package:project_tc/screens/auth/login/sign_in_website.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ResponsiveSignIn extends StatelessWidget {
  const ResponsiveSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        // Check the sizing information here and return your UI
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          return const SignInWebsite();
        }

        if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
          return const SignInMobile();
        }

        return Container(color: Colors.white);
      },
    );
  }
}
