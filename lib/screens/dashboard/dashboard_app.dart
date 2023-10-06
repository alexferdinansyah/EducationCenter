import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/components/side_bar/drop_down_icon.dart';
import 'package:project_tc/components/side_bar/side_item.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/screens/dashboard/edit_profile.dart';
import 'package:project_tc/screens/dashboard/membership_info.dart';
import 'package:project_tc/screens/dashboard/membership_upgrade.dart';
import 'package:project_tc/screens/dashboard/my_course.dart';
import 'package:project_tc/screens/dashboard/newsflash.dart';
import 'package:project_tc/screens/dashboard/setting.dart';
import 'package:project_tc/screens/dashboard/transaction.dart';
import 'package:project_tc/services/firestore_service.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class DashboardApp extends StatefulWidget {
  late String selected;
  String? optionalSelected;
  DashboardApp({super.key, required this.selected, this.optionalSelected});

  @override
  State<DashboardApp> createState() => _DashboardAppState();
}

class _DashboardAppState extends State<DashboardApp> {
  final List<SideItem> sidebarItems = [
    const SideItem(icon: IconlyBold.category, title: 'Newsflash'),
    const SideItem(icon: IconlyBold.chart, title: 'My Courses'),
    const SideItem(icon: IconlyBold.buy, title: 'Transaction'),
    const SideItem(icon: IconlyBold.document, title: 'Free Tutorial'),
    const SideItem(icon: IconlyBold.chat, title: 'Review'),
  ];

  final List<SideItem> otherItems = [
    const SideItem(icon: IconlyBold.setting, title: 'Settings'),
    const SideItem(icon: IconlyBold.info_square, title: 'Help'),
    // Add other "OTHERS" items as needed
  ];

  MembershipModel? membershipData;
  String selectedSidebarItem = '';

  @override
  void initState() {
    super.initState();
    String currentRoute = Get.currentRoute;
    setState(() {
      if (currentRoute == "/edit-profile") {
        widget.optionalSelected = 'Settings';
        widget.selected = 'Edit-Profile';
      } else if (currentRoute == "/membership-info") {
        widget.optionalSelected = 'Settings';
        widget.selected = 'Membership';
      } else if (currentRoute == "/membership-upgrade") {
        widget.optionalSelected = 'Settings';
        widget.selected = 'Membership-Upgrade';
      }
      if (widget.optionalSelected == null) {
        selectedSidebarItem = widget.selected;
      } else {
        selectedSidebarItem = widget.optionalSelected!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context, listen: false);
    double width = MediaQuery.of(context).size.width;

    void selectSidebarItem(String itemTitle) {
      setState(() {
        selectedSidebarItem = itemTitle;
      });
    }

    // Function to build content based on the selected sidebar item
    Widget buildContent(dataUser, user, membershipData) {
      switch (selectedSidebarItem) {
        case 'Newsflash':
          return const Newsflash();
        case 'My Courses':
          return const MyCourses();
        case 'Transaction':
          return const TransactionTable();
        case 'Free Tutorial':
          return Container(
            height: 50,
            width: 50,
            color: Colors.black,
          );
        case 'Review':
          return Container(
            height: 50,
            width: 50,
            color: Colors.blue,
          );
        case 'Settings':
          if (widget.selected == 'Edit-Profile') {
            return EditProfile(userData: dataUser, user: user);
          } else if (widget.selected == 'Membership') {
            return MembershipInfo(membershipData: membershipData);
          } else if (widget.selected == 'Membership-Upgrade') {
            return MembershipUpgrade(membershipData: membershipData);
          } else {
            return Settings(
              user: user,
            );
          }
        // case 'Help':
        //   return HelpWidget();
        default:
          return Container(); // Handle the default case here
      }
    }

    return Scaffold(
        body: SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: double.infinity,
            width: width * .17,
            color: CusColors.bgSideBar,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 10, bottom: 60),
                  child: Image.asset(
                    'assets/images/logo_dac.png',
                    width: width * .13,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 21, left: 40),
                      child: Text(
                        'MENU',
                        style: GoogleFonts.poppins(
                            fontSize: width * .01,
                            color: CusColors.sidebarInactive,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: sidebarItems.length,
                      itemBuilder: (context, index) {
                        final item = sidebarItems[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: SideItem(
                            icon: item.icon,
                            title: item.title,
                            isSelected: item.title == selectedSidebarItem,
                            onTap: () {
                              selectSidebarItem(item.title);
                            },
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(bottom: 21, top: 19, left: 40),
                      child: Text(
                        'OTHERS',
                        style: GoogleFonts.poppins(
                            fontSize: width * .01,
                            color: CusColors.sidebarInactive,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: otherItems.length,
                      itemBuilder: (context, index) {
                        final item = otherItems[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: SideItem(
                            icon: item.icon,
                            title: item.title,
                            isSelected: item.title == selectedSidebarItem,
                            onTap: () {
                              selectSidebarItem(item.title);
                            },
                          ),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          StreamBuilder(
              stream: FirestoreService(uid: user!.uid).userData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  UserData? userData = snapshot.data;
                  if (userData != null) {
                    membershipData = userData.membership;
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        height: 60,
                        width: width * .83,
                        decoration: BoxDecoration(
                          color: CusColors.bg,
                          border: const Border(
                            bottom: BorderSide(
                              width: 0.5,
                              color: Color(0xFFC8CBD9),
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: width / 3,
                              decoration: BoxDecoration(
                                  color: const Color(0xFFF6F6FB),
                                  borderRadius: BorderRadius.circular(5)),
                              child: TextField(
                                style: GoogleFonts.poppins(
                                    fontSize: width * .01,
                                    color: CusColors.sidebarInactive),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  isDense: true,
                                  hintText: 'Search',
                                  hintStyle: GoogleFonts.poppins(
                                      fontSize: width * .01,
                                      color: const Color(0xFFb5bdc7)),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(15, 12, 5, 12),
                                  suffixIcon: const Icon(
                                    IconlyLight.search,
                                    size: 18,
                                  ),
                                  suffixIconColor: const Color(0xFFb5bdc7),
                                ),
                              ),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(userData!.photoUrl),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    userData.name,
                                    style: GoogleFonts.poppins(
                                        fontSize: width * .01,
                                        color: const Color(0xFF1F384C)),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2(
                                        isDense: true,
                                        customButton: const Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 24,
                                        ),
                                        items: [
                                          ...MenuItems.firstItems.map(
                                            (item) =>
                                                DropdownMenuItem<MenuItem>(
                                              value: item,
                                              child: MenuItems.buildItem(item),
                                            ),
                                          ),
                                          const DropdownMenuItem<Divider>(
                                              enabled: false, child: Divider()),
                                          ...MenuItems.secondItems.map(
                                            (item) =>
                                                DropdownMenuItem<MenuItem>(
                                              value: item,
                                              child: MenuItems.buildItem(item),
                                            ),
                                          ),
                                        ],
                                        onChanged: (value) {
                                          MenuItems.onChanged(
                                              context, value! as MenuItem);
                                        },
                                        dropdownStyleData: DropdownStyleData(
                                          width: 160,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 6),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            border: Border.all(
                                                color: const Color(0xFFCCCCCC),
                                                width: 1),
                                            color: Colors.white,
                                          ),
                                          offset: const Offset(0, 3),
                                        ),
                                        menuItemStyleData: MenuItemStyleData(
                                          customHeights: [
                                            ...List<double>.filled(
                                                MenuItems.firstItems.length,
                                                48),
                                            8,
                                            ...List<double>.filled(
                                                MenuItems.secondItems.length,
                                                48),
                                          ],
                                          padding: const EdgeInsets.only(
                                              left: 16, right: 16),
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                            const Icon(
                              Icons.notifications,
                              color: Color(0xFFB0C3CC),
                            )
                          ],
                        ),
                      ),
                      buildContent(userData, user, membershipData),
                    ],
                  );
                } else {
                  return const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SpinKitDualRing(
                        color: Colors.blue,
                      ),
                    ],
                  );
                }
              }),
        ],
      ),
    ));
  }
}
