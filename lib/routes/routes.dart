import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_tc/screens/auth/forgot_password.dart';
import 'package:project_tc/screens/auth/register/register_responsive.dart';
import 'package:project_tc/screens/dashboard/learning_course.dart';
import 'package:project_tc/screens/landing_page/app_view.dart';
import 'package:project_tc/screens/landing_page/article_list.dart';
import 'package:project_tc/screens/landing_page/bundle_course_list.dart';
import 'package:project_tc/screens/landing_page/contact_us.dart';
import 'package:project_tc/screens/landing_page/detail_article.dart';
import 'package:project_tc/screens/landing_page/detail_bundle_course.dart';
import 'package:project_tc/screens/landing_page/detail_single_course.dart';
import 'package:project_tc/screens/landing_page/landing_page.dart';
import 'package:project_tc/screens/landing_page/single_course_list.dart';
import 'package:project_tc/screens/wrapper.dart';

const String routeHome = '/home';
const String routeCourses = '/courses';
const String routeBundleCourses = '/bundle-course';
const String routeDetailSingleCourse = '/detail-single-courses';
const String routeDetailBundleCourse = '/detail-bundle-courses';
const String routeArticle = '/article';
const String routeDetailArticle = '/detail-article';
const String routeContacts = '/contact';
const String routeLogin = '/login';
const String routeRegister = '/register';
const String routeForgotPassword = '/forgot-password';
const String routeEditProfile = '/edit-profile';
const String routeMembershipInfo = '/membership-info';
const String routeMembershipUpgrade = '/membership-upgrade';
const String routeMembershipUpgradePayment = '/membership-upgrade-payment';
const String routeLearnCourse = '/learn-course';

final navKey = GlobalKey<NavigatorState>();

Widget wrapWithAppView(Widget page) {
  return AppViewWrapper(
    child: page,
  );
}

final getPages = [
  GetPage(
    name: routeHome,
    page: () => wrapWithAppView(const LandingPage()),
  ),
  GetPage(
    name: routeLogin,
    page: () => const Wrapper(),
  ),
  GetPage(
    name: routeRegister,
    page: () => const ResponsiveRegister(),
  ),
  GetPage(
    name: routeForgotPassword,
    page: () => const ForgotPassword(),
  ),
  GetPage(
    name: routeCourses,
    page: () => wrapWithAppView(const SingleCourseList()),
  ),
  GetPage(
    name: routeBundleCourses,
    page: () => wrapWithAppView(const BundleCourseList()),
  ),
  GetPage(
    name: routeArticle,
    page: () => wrapWithAppView(const ArticleList()),
  ),
  GetPage(
    name: routeContacts,
    page: () => wrapWithAppView(const ContactUs()),
  ),
  GetPage(
    name: routeDetailSingleCourse,
    page: () => wrapWithAppView(const DetailSingleCourse()),
  ),
  GetPage(
    name: routeDetailBundleCourse,
    page: () => wrapWithAppView(const DetailBundleCourse()),
  ),
  GetPage(
    name: routeDetailArticle,
    page: () => wrapWithAppView(const DetailArticle()),
  ),
  GetPage(
    name: routeEditProfile,
    page: () => const Wrapper(),
  ),
  GetPage(
    name: routeMembershipInfo,
    page: () => const Wrapper(),
  ),
  GetPage(
    name: routeMembershipUpgrade,
    page: () => const Wrapper(),
  ),
  GetPage(
    name: routeMembershipUpgradePayment,
    page: () => const Wrapper(),
  ),
  GetPage(
    name: routeLearnCourse,
    page: () => const LearningCourse(),
  ),
];
