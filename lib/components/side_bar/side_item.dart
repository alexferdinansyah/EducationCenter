import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/constants.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SideItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final Function()? onTap;
  const SideItem({
    super.key,
    required this.icon,
    required this.title,
    this.isSelected = false, // Default to false
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    var deviceType = getDeviceType(MediaQuery.of(context).size);
    bool isMobile = false;
    switch (deviceType) {
      case DeviceScreenType.desktop:
        isMobile = false;
        break;
      case DeviceScreenType.tablet:
        isMobile = false;
        break;
      case DeviceScreenType.mobile:
        isMobile = true;
        break;
      default:
    }
    return isSelected
        ? Container(
            padding: EdgeInsets.only(
              top: 10,
              bottom: 10,
              left: getValueForScreenType<double>(
                context: context,
                mobile: 15,
                tablet: 15,
                desktop: 20,
              ),
            ),
            decoration: BoxDecoration(
                color: const Color(0xFFe4e6f4),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: CusColors.sidebarIconActive,
                ),
                SizedBox(
                  width: getValueForScreenType<double>(
                    context: context,
                    mobile: 5,
                    tablet: 8,
                    desktop: 12,
                  ),
                ),
                if (isMobile == false)
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                        fontSize: getValueForScreenType<double>(
                          context: context,
                          mobile: width * .018,
                          tablet: width * .015,
                          desktop: width * .01,
                        ),
                        color: CusColors.sidebarActive,
                        fontWeight: FontWeight.w500),
                  )
              ],
            ),
          )
        : Padding(
            padding: EdgeInsets.only(
              left: getValueForScreenType<double>(
                context: context,
                mobile: 15,
                tablet: 15,
                desktop: 20,
              ),
            ),
            child: GestureDetector(
              onTap: onTap,
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: CusColors.sidebarIconInactive,
                  ),
                  SizedBox(
                    width: getValueForScreenType<double>(
                      context: context,
                      mobile: 5,
                      tablet: 8,
                      desktop: 12,
                    ),
                  ),
                  if (isMobile == false)
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                          fontSize: getValueForScreenType<double>(
                            context: context,
                            mobile: width * .018,
                            tablet: width * .015,
                            desktop: width * .01,
                          ),
                          color: CusColors.sidebarInactive,
                          fontWeight: FontWeight.w400),
                    )
                ],
              ),
            ),
          );
  }
}
