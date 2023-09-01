import 'package:flutter/material.dart';
import 'package:project_tc/routes/routes.dart';
import 'package:project_tc/screens/auth/register/register_responsive.dart';
import 'package:project_tc/screens/landing_page/detail_bundle_course.dart';
import 'package:project_tc/screens/wrapper.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeHome:
        return MaterialPageRoute(builder: (_) => const DetailBundleCourse());
      case routeCourses:
        return MaterialPageRoute(builder: (_) => const Wrapper());
      case routeBundleCourses:
        return MaterialPageRoute(builder: (_) => const DetailBundleCourse());
      case routeArticle:
        return MaterialPageRoute(builder: (_) => const Wrapper());
      default:
        // Return a default route or handle unknown routes here
        return MaterialPageRoute(builder: (_) => const ResponsiveRegister());
    }
  }
}
