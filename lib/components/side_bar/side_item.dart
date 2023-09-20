import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/constants.dart';

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
    return isSelected
        ? Container(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
              left: 20,
            ),
            decoration: BoxDecoration(
                color: const Color(0xFFe4e6f4),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 26,
                  color: CusColors.sidebarIconActive,
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                      fontSize: width * .01,
                      color: CusColors.sidebarActive,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 20),
            child: GestureDetector(
              onTap: onTap,
              child: Row(
                children: [
                  Icon(
                    icon,
                    size: 26,
                    color: CusColors.sidebarIconInactive,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                        fontSize: width * .01,
                        color: CusColors.sidebarInactive,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
          );
  }
}
