import 'package:flutter/material.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/screens/auth/login/sign_in_responsive.dart';
import 'package:project_tc/screens/dashboard/dashboard_app.dart';
import 'package:project_tc/screens/dashboard/dashboard_admin.dart';
import 'package:project_tc/services/firestore_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    if (user == null) {
      // User is not signed in
      return const ResponsiveSignIn();
    } else {
      // User is signed in
      return FutureBuilder<Map<String, dynamic>>(
        // Check if it's the user's first sign-in and if they are an admin
        future: FirestoreService(uid: user.uid).checkUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Loading state
            return const SpinKitWanderingCubes(
              color: Colors.blue,
            ); // You can use a different loading indicator
          } else if (snapshot.hasError) {
            // Error occurred while checking
            return const Text('Error checking user data');
          } else {
            // Check the results and decide where to navigate
            final Map<String, dynamic> userData = snapshot.data ?? {};
            final bool exists = userData['exists'] ?? false;
            final bool isAdmin = userData['isAdmin'] ?? false;

            if (!exists) {
              // User data doesn't exist (first sign-in)
              return DashboardApp(
                selected: 'Edit-Profile',
                optionalSelected: 'Settings',
              );
            } else {
              // User data exists
              return isAdmin
                  ? const DashboardAdmin() // Admin
                  : DashboardApp(selected: 'Newsflash'); // Non-admin
            }
          }
        },
      );
    }
  }
}
