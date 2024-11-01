import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_tc/screens/auth/confirm_email.dart';
import 'package:project_tc/screens/auth/forgot_password.dart';
import 'package:project_tc/screens/auth/register/register_responsive.dart';
import 'package:project_tc/screens/dashboard_admin/admin_detail_article.dart';
import 'package:project_tc/screens/dashboard_admin/admin_detail_course.dart';
import 'package:project_tc/screens/dashboard_admin/admin_detail_ebook.dart';
import 'package:project_tc/screens/dashboard_admin/admin_detail_videoLearning.dart';
import 'package:project_tc/screens/dashboard_admin/admin_learn_course.dart';
import 'package:project_tc/screens/dashboard_admin/admin_learn_videoLearning.dart';
import 'package:project_tc/screens/landing_page/EBook.dart';
import 'package:project_tc/screens/landing_page/Portopolio.dart';
import 'package:project_tc/screens/landing_page/detail_bootcamp.dart';
import 'package:project_tc/screens/landing_page/detail_video_learning.dart';
import 'package:project_tc/screens/landing_page/detail_webinar.dart';
import 'package:project_tc/screens/landing_page/video_learningPage.dart';
import 'package:project_tc/screens/landing_page/webinarPage.dart';
import 'package:project_tc/screens/learning/learning_course.dart';
import 'package:project_tc/screens/landing_page/app_view.dart';
import 'package:project_tc/screens/landing_page/article_list.dart';
import 'package:project_tc/screens/landing_page/contact_us.dart';
import 'package:project_tc/screens/landing_page/bootcampPage.dart';
import 'package:project_tc/screens/landing_page/detail_article.dart';
import 'package:project_tc/screens/landing_page/detail_single_course.dart';
import 'package:project_tc/screens/landing_page/landing_page.dart';
import 'package:project_tc/screens/landing_page/single_course_list.dart';
import 'package:project_tc/screens/learning/learning_video.dart';
import 'package:project_tc/screens/learning/payment_page.dart';
import 'package:project_tc/screens/middleware/admin_middleware.dart';
import 'package:project_tc/screens/wrapper.dart';

const String routeHome = '/home';
const String routeCourses = '/courses';
const String routeBundleCourses = '/bundle-course';
const String routeDetailSingleCourse = '/detail-single-courses';
const String routeDetailBundleCourse = '/detail-bundle-courses';
const String routeArticle = '/articles';
const String routeDetailArticle = '/detail-article';
const String routeContacts = '/contact';
const String routeLogin = '/login';
const String routeRegister = '/register';
const String routeConfirmEmail = '/verify-account';
const String routeForgotPassword = '/forgot-password';
const String routeSettings = '/settings';
const String routeEditProfile = '/edit-profile';
const String routeTransaction = '/transactions';
const String routeMembershipInfo = '/membership-info';
const String routeMembershipUpgrade = '/membership-upgrade';
const String routeMembershipUpgradePayment = '/membership-upgrade-payment';
const String routeLearnCourse = '/learn-course';
const String routeLearnVideo = '/learn-video';
const String routeOfferLearnCourse = '/learn-course/offers';
const String routeOfferLearnVideo = '/learn-video/offers';
const String routeBuyCourse = '/checkout/course';
const String routeBuyVideo = '/checkout/video';
const String routeAdminDetailCourse = '/admin-detail-course';
const String routeAdminLearnCourse = '/admin-learn-course';
const String routeAdminDetailVideoLearning = '/admin-detail-videoLearning';
const String routeAdminLearnVideolearning = '/admin-learn-video-learning';
const String routeDetailVideoLearning = '/deatail-video-learning';
const String routeAdminDetailArticle = '/admin-detail-article';
const String routeAdminDetailEbook = '/admin-detail-ebook';
const String routeAdminCoupon = '/admin-coupons';
const String routeCreateCoupon = '/create-coupon';
const String routeCreateFAQ = '/create-faq';
const String routeFAQ = '/faq';
const String routeBootcamp = '/bootcamp';
const String routeVideoLearning = '/Video-Learning';
const String routeWebinar = '/webinar';
const String routePortopolio = '/portopolio';
const String routeEBook = '/EBook';
const String routeDetailBootcamp = '/detail-bootcamp';
const String routeCreateBootcamp = '/create-bootcamp';
const String routeCreateEBook = '/create-E-book';
const String routeCreateWebinar = '/create-webinar';
const String routeDetailWebinar = '/Detail-webinar';
const String routeEditCoupon = '/edit-coupon';


final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

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
    name: routeConfirmEmail,
    page: () => const ConfirmEmail(),
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
    name: routeBootcamp,
    page: () => wrapWithAppView(const Bootcamppage()),
  ),
  GetPage(
    name: routeVideoLearning,
    page: () => wrapWithAppView(const VideoLearningpage()),
  ),
  GetPage(
    name: routeDetailVideoLearning,
    page: () => wrapWithAppView(const DetailVideoLearning()),
  ),
  GetPage(
    name: routeWebinar,
    page: () => wrapWithAppView(const Webinarpage()),
  ),
  GetPage(
    name: routeDetailWebinar,
    page: () => wrapWithAppView(const DetailWebinar()),
  ),
  GetPage(
    name: routePortopolio,
    page: () => wrapWithAppView(const Portopolio()),
  ),
  GetPage(
    name: routeEBook,
    page: () => wrapWithAppView(const Ebook()),
  ),
  GetPage(
    name: routeDetailBootcamp,
    page: () => wrapWithAppView(const DetailBootcamp()),
  ),
  // GetPage(
  //   name: routeBundleCourses,
  //   page: () => wrapWithAppView(const BundleCourseList()),
  // ),
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
  // GetPage(
  //   name: routeDetailBundleCourse,
  //   page: () => wrapWithAppView(const DetailBundleCourse()),
  // ),
  GetPage(
    name: routeDetailArticle,
    page: () => wrapWithAppView(const DetailArticle()),
  ),
  GetPage(
    name: routeTransaction,
    page: () => const Wrapper(),
  ),
  GetPage(
    name: routeSettings,
    page: () => const Wrapper(),
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
  GetPage(
    name: routeLearnVideo,
    page: () => const LearningVideo(),
  ),
  GetPage(
    name: routeOfferLearnVideo,
    page: () => const LearningVideo(),
  ),
  GetPage(
    name: routeOfferLearnCourse,
    page: () => const LearningCourse(),
  ),
  GetPage(
    name: routeBuyCourse,
    page: () => const PaymentPage(),
  ),
  GetPage(
    name: routeBuyVideo,
    page: () => const PaymentPage(),
  ),
  GetPage(
      name: routeAdminDetailCourse,
      page: () => const AdminDetailCourse(),
      middlewares: [AdminMiddleware()]),
      GetPage(
      name: routeAdminDetailVideoLearning,
      page: () => const AdminDetailVideolearning(),
      middlewares: [AdminMiddleware()]),
  GetPage(
      name: routeAdminDetailArticle,
      page: () => const AdminDetailArticle(),
      middlewares: [AdminMiddleware()]),
  GetPage(
      name: routeAdminDetailEbook,
      page: () => const AdminDetailEbook(),
      middlewares: [AdminMiddleware()]),
  GetPage(
      name: routeAdminLearnCourse,
      page: () => const AdminLearnCourse(),
      middlewares: [AdminMiddleware()]),
  GetPage(
      name: routeAdminLearnVideolearning,
      page: () => const AdminLearnVideolearning(),
      middlewares: [AdminMiddleware()]),
  GetPage(
    name: routeCreateCoupon,
    page: () => const Wrapper(),
  ),
  GetPage(
    name: routeCreateFAQ,
    page: () => const Wrapper(),
  ),
  GetPage(
    name: routeCreateBootcamp,
    page: () => const Wrapper(),
  ),
   GetPage(
    name: routeCreateEBook,
    page: () => const Wrapper(),
  ),
  GetPage(
    name: routeCreateWebinar,
    page: () => const Wrapper(),
  ),
  GetPage(
    name: routeFAQ,
    page: () => const Wrapper(),
  ),
  GetPage(
    name: routeEditCoupon,
    page: () => const Wrapper(),
  ),
  GetPage(
    name: routeAdminCoupon,
    page: () => const Wrapper(),
  )
];
