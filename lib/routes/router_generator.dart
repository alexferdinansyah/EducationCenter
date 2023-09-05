import 'package:flutter/material.dart';
import 'package:project_tc/models/course.dart';
import 'package:project_tc/routes/routes.dart';
import 'package:project_tc/screens/landing_page/app_view.dart';
import 'package:project_tc/screens/landing_page/detail_bundle_course.dart';
import 'package:project_tc/screens/landing_page/test_animation.dart';
import 'package:project_tc/screens/wrapper.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeHome:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            return const AppView(
              child: TestAnimation(),
            );
          },
        );
      case routeCourses:
        return MaterialPageRoute(builder: (_) => const Wrapper());
      case routeArticle:
        return MaterialPageRoute(builder: (_) => const Wrapper());
      case routeDetailBundleCourse:
        // Extract the arguments passed to the route.
        final args = settings.arguments as Map<String, dynamic>;
        // Get the 'course' argument.
        final Course course = args['course'];

        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            return AppView(
              child: DetailBundleCourse(course: course),
            );
          },
        );
      default:
        // Return a default route or handle unknown routes here
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return const AppView(
              child: TestAnimation(),
            );
          },
        );
    }
  }
}
