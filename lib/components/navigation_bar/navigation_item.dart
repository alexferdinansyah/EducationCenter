import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_tc/components/navigation_bar/interactive_nav_item.dart';
import 'package:responsive_builder/responsive_builder.dart';

class NavigationItem extends StatelessWidget {
  final String title;
  final String routeName;
  final bool selected;
  final Function onHighlight;

  const NavigationItem({
    super.key,
    required this.title,
    required this.routeName,
    required this.selected,
    required this.onHighlight,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.rootDelegate.toNamed(routeName);
        onHighlight(routeName);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getValueForScreenType<double>(
                context: context, mobile: 20, desktop: 10, tablet: 30),
            vertical: getValueForScreenType<double>(
              context: context,
              mobile: 8,
            )),
        child: InteractiveNavItem(
          text: title,
          routeName: routeName,
          selected: selected,
        ),
      ),
    );
  }
}
