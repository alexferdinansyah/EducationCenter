import 'package:flutter/material.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/screens/auth/login/sign_in_responsive.dart';
import 'package:project_tc/screens/dashboard/dashboard_app.dart';
import 'package:project_tc/services/firestore_service.dart';
import 'package:provider/provider.dart';

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
      return FutureBuilder<bool>(
        // Check if it's the user's first sign-in
        future: FirestoreService(uid: user.uid).checkUserExists(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Loading state
            return const CircularProgressIndicator(); // You can use a different loading indicator
          } else if (snapshot.hasError) {
            // Error occurred while checking
            return const Text('Error checking first sign-in');
          } else {
            // Check the result and decide where to navigate
            final bool isFirstSignIn = snapshot.data ?? false;

            if (!isFirstSignIn) {
              // User is signing in for the first time
              return const DashboardApp(
                selected: 'Settings',
              ); // Navigate to the edit profile page
            } else {
              // User has signed in before
              return const DashboardApp(
                selected: 'My Courses',
              ); // Navigate to the dashboard
            }
          }
        },
      );
    }
  }
}
