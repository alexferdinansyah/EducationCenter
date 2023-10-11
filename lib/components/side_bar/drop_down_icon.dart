import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/routes/routes.dart';
import 'package:project_tc/screens/dashboard/dashboard_app.dart';
import 'package:project_tc/services/auth_service.dart';

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

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: CusColors.sidebarIconInactive, size: 22),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: TextStyle(
            color: CusColors.sidebarInactive,
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
        Get.toNamed(routeHome);
        break;
      case MenuItems.settings:
        Get.to(DashboardApp(selected: 'Settings'));
        break;
      case MenuItems.logout:
        logout();
        Get.offAndToNamed(routeLogin);
        break;
    }
  }
}
