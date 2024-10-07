import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/routes/routes.dart';
import 'package:project_tc/services/auth_service.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MenuItem {
  const MenuItem({
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;
}

abstract class MenuItems {
  static const List<MenuItem> firstItems = [home, settings];
  static const List<MenuItem> secondItems = [logout];

  static const home = MenuItem(text: 'Home', icon: Icons.home);
  static const settings = MenuItem(text: 'Settings', icon: Icons.settings);
  static const logout = MenuItem(text: 'Log Out', icon: Icons.logout);

  static Widget buildItem(MenuItem item, context, width) {
    return Row(
      children: [
        Icon(
          item.icon,
          color: CusColors.sidebarIconInactive,
          size: getValueForScreenType<double>(
            context: context,
            mobile: 18,
            tablet: 20,
            desktop: 22,
          ),
        ),
        SizedBox(
          width: getValueForScreenType<double>(
            context: context,
            mobile: 2,
            tablet: 5,
            desktop: 10,
          ),
        ),
        Text(
          item.text,
          style: TextStyle(
            color: CusColors.sidebarInactive,
            fontSize: getValueForScreenType<double>(
              context: context,
              mobile: width * .018,
              tablet: width * .015,
              desktop: width * .01,
            ),
          ),
        ),
      ],
    );
  }

  static void onChanged(BuildContext context, MenuItem item) {
    logout() async {
      final auth = AuthService();
      await auth.signOut();
    }

    switch (item) {
      case MenuItems.home:
        Get.rootDelegate.toNamed(routeHome);
        break;
      case MenuItems.settings:
        Get.rootDelegate.toNamed(routeSettings);
        break;
      case MenuItems.logout:
        logout();
        Get.rootDelegate.offAndToNamed(routeLogin);
        break;
    }
  }
}
