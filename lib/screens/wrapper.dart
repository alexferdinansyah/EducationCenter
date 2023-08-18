import 'package:flutter/material.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/screens/auth/login/sign_in_responsive.dart';
import 'package:project_tc/screens/dashboard/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    // return either home or authenticate
    if (user == null) {
      return const ResponsiveSignIn();
    } else {
      return const Home();
    }
  }
}
