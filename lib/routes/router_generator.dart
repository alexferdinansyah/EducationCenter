import 'package:flutter/material.dart';
import 'package:project_tc/models/article.dart';
import 'package:project_tc/models/course.dart';
import 'package:project_tc/routes/routes.dart';
import 'package:project_tc/screens/landing_page/app_view.dart';
import 'package:project_tc/screens/landing_page/bundle_course_list.dart';
import 'package:project_tc/screens/landing_page/detail_article.dart';
import 'package:project_tc/screens/landing_page/detail_bundle_course.dart';
import 'package:project_tc/screens/landing_page/detail_single_course.dart';
import 'package:project_tc/screens/landing_page/landing_page.dart';
import 'package:project_tc/screens/wrapper.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Helper function to wrap a page with AppView
    Widget wrapWithAppView(Widget page) {
      return AppView(
        child: page,
      );
    }

    switch (settings.name) {
      case routeHome:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            return wrapWithAppView(const LandingPage());
          },
        );
      case routeCourses:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            return const Wrapper();
          },
        );
      case routeBundleCourses:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            return wrapWithAppView(const BundleCourseList());
          },
        );
      case routeArticle:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            return const Wrapper();
          },
        );
      case routeDetailSingleCourse:
        // Extract the arguments passed to the route.
        final args = settings.arguments as Map<String, dynamic>;
        // Get the 'course' argument.
        final Course course = args['course'];

        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            return wrapWithAppView(DetailSingleCourse(course: course));
          },
        );
      case routeDetailArticle:
        // Extract the arguments passed to the route.
        final args = settings.arguments as Map<String, dynamic>;
        // Get the 'course' argument.
        final Article article = args['article'];
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            return wrapWithAppView(DetailArticle(
              article: article,
            ));
          },
        );
      case routeDetailBundleCourse:
        // Extract the arguments passed to the route.
        final args = settings.arguments as Map<String, dynamic>;
        // Get the 'course' argument.
        final Course course = args['course'];

        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            return wrapWithAppView(DetailBundleCourse(course: course));
          },
        );
      default:
        // Return a default route or handle unknown routes here
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            return wrapWithAppView(const LandingPage());
          },
        );
    }
  }
}
