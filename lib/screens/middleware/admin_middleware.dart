import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:project_tc/routes/routes.dart';
import 'package:project_tc/services/firestore_service.dart';

class AdminMiddleware extends GetMiddleware {
  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    final user = FirebaseAuth.instance.currentUser;

    // Check if the user is logged in and fetch their data
    if (user != null) {
      final userData = await FirestoreService(uid: user.uid).checkUser();
      // Fetch user data from FirestoreService
      final isAdmin = userData['isAdmin'];

      if (!isAdmin) {
        // Redirect if the user is not an admin or doesn't have user data
        return Get.rootDelegate.toNamed(routeLogin);
      }
    } else {
      // Redirect to login if the user is not logged in
      return Get.rootDelegate.toNamed(routeLogin);
    }

    return super.redirectDelegate(route);
  }
}
