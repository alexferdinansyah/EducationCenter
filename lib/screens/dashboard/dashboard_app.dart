import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/components/loading.dart';
import 'package:project_tc/components/side_bar/drop_down_icon.dart';
import 'package:project_tc/components/side_bar/side_item.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/routes/routes.dart';
import 'package:project_tc/screens/dashboard/edit_profile.dart';
import 'package:project_tc/screens/dashboard/help_page.dart';
import 'package:project_tc/screens/dashboard/membership_info.dart';
import 'package:project_tc/screens/dashboard/membership_upgrade.dart';
import 'package:project_tc/screens/dashboard/my_course.dart';
import 'package:project_tc/screens/dashboard/newsflash.dart';
import 'package:project_tc/screens/dashboard/setting.dart';
import 'package:project_tc/screens/dashboard/transaction_table.dart';
import 'package:project_tc/screens/learning/payment_page.dart';
import 'package:project_tc/services/firestore_service.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

// ignore: must_be_immutable
class DashboardApp extends StatefulWidget {
  late String selected;
  String? optionalSelected;
  DashboardApp({super.key, required this.selected, this.optionalSelected});

  @override
  State<DashboardApp> createState() => _DashboardAppState();
}

class _DashboardAppState extends State<DashboardApp> {
  String selectedSidebarItem = '';

  @override
  void initState() {
    super.initState();
    String currentRoute = Get.rootDelegate.currentConfiguration!.location!;

    setState(() {
      if (currentRoute == "/settings") {
        widget.selected = 'Settings';
      } else if (currentRoute == "/edit-profile") {
        widget.optionalSelected = 'Settings';
        widget.selected = 'Edit-Profile';
      } else if (currentRoute == "/transactions") {
        widget.selected = 'Transaction';
      } else if (currentRoute == "/membership-info") {
        widget.optionalSelected = 'Settings';
        widget.selected = 'Membership';
      } else if (currentRoute == "/membership-upgrade") {
        widget.optionalSelected = 'Settings';
        widget.selected = 'Membership-Upgrade';
      } else if (currentRoute == "/membership-upgrade-payment") {
        widget.optionalSelected = 'Settings';
        widget.selected = 'Membership-Payment';
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
    final user = Provider.of<UserModel?>(context);
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
          return MyCourses(
            user: user,
          );
        case 'Transaction':
          return TransactionTable(
            user: user,
          );
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
          } else if (widget.selected == 'Membership-Payment') {
            return PaymentPage(
              user: user,
              price: '35,000',
              title: 'Membership',
              type: 'Pro',
            );
          } else {
            return Settings(
              user: user,
            );
          }
        case 'Help':
          return const HelpPage();
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
          DashboardSideBar(
              selectedSidebarItem: selectedSidebarItem,
              onItemSelected: selectSidebarItem),
          StreamBuilder(
              stream: FirestoreService(uid: user!.uid).userData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  UserData? userData = snapshot.data;
                  MembershipModel membershipData = userData!.membership;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: getValueForScreenType<double>(
                            context: context,
                            mobile: 20,
                            tablet: 30,
                            desktop: 40,
                          ),
                        ),
                        height: getValueForScreenType<double>(
                          context: context,
                          mobile: 40,
                          tablet: 50,
                          desktop: 60,
                        ),
                        width: getValueForScreenType<double>(
                          context: context,
                          mobile: width * .86,
                          tablet: width * .79,
                          desktop: width * .83,
                        ),
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
                            //! Search bar that has no function
                            // Container(
                            //   width: width / 3,
                            //   decoration: BoxDecoration(
                            //       color: const Color(0xFFF6F6FB),
                            //       borderRadius: BorderRadius.circular(5)),
                            //   child: TextField(
                            //     style: GoogleFonts.poppins(
                            //         fontSize: width * .01,
                            //         color: CusColors.sidebarInactive),
                            //     decoration: InputDecoration(
                            //       border: InputBorder.none,
                            //       isDense: true,
                            //       hintText: 'Search',
                            //       hintStyle: GoogleFonts.poppins(
                            //           fontSize: width * .01,
                            //           color: const Color(0xFFb5bdc7)),
                            //       contentPadding:
                            //           const EdgeInsets.fromLTRB(15, 12, 5, 12),
                            //       suffixIcon: const Icon(
                            //         IconlyLight.search,
                            //         size: 18,
                            //       ),
                            //       suffixIconColor: const Color(0xFFb5bdc7),
                            //     ),
                            //   ),
                            // ),
                            const Spacer(),
                            Row(
                              children: [
                                Container(
                                  width: getValueForScreenType<double>(
                                    context: context,
                                    mobile: 25,
                                    tablet: 30,
                                    desktop: 40,
                                  ),
                                  height: getValueForScreenType<double>(
                                    context: context,
                                    mobile: 25,
                                    tablet: 30,
                                    desktop: 40,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(userData.photoUrl),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    userData.name,
                                    style: GoogleFonts.poppins(
                                        fontSize: getValueForScreenType<double>(
                                          context: context,
                                          mobile: width * .018,
                                          tablet: width * .015,
                                          desktop: width * .01,
                                        ),
                                        color: const Color(0xFF1F384C)),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: getValueForScreenType<double>(
                                        context: context,
                                        mobile: 8,
                                        tablet: 12,
                                        desktop: 18,
                                      ),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2(
                                        isDense: true,
                                        customButton: Icon(
                                          Icons.keyboard_arrow_down,
                                          size: getValueForScreenType<double>(
                                            context: context,
                                            mobile: 20,
                                            tablet: 22,
                                            desktop: 24,
                                          ),
                                        ),
                                        items: [
                                          ...MenuItems.firstItems.map(
                                            (item) =>
                                                DropdownMenuItem<MenuItem>(
                                              value: item,
                                              child: MenuItems.buildItem(
                                                  item, context, width),
                                            ),
                                          ),
                                          const DropdownMenuItem<Divider>(
                                              enabled: false, child: Divider()),
                                          ...MenuItems.secondItems.map(
                                            (item) =>
                                                DropdownMenuItem<MenuItem>(
                                              value: item,
                                              child: MenuItems.buildItem(
                                                  item, context, width),
                                            ),
                                          ),
                                        ],
                                        onChanged: (value) {
                                          MenuItems.onChanged(
                                              context, value! as MenuItem);
                                        },
                                        dropdownStyleData: DropdownStyleData(
                                          width: getValueForScreenType<double>(
                                              context: context,
                                              mobile: 100,
                                              tablet: 130,
                                              desktop: 160),
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
                                              getValueForScreenType<double>(
                                                context: context,
                                                mobile: 28,
                                                tablet: 35,
                                                desktop: 48,
                                              ),
                                            ),
                                            8,
                                            ...List<double>.filled(
                                              MenuItems.secondItems.length,
                                              getValueForScreenType<double>(
                                                context: context,
                                                mobile: 28,
                                                tablet: 35,
                                                desktop: 48,
                                              ),
                                            ),
                                          ],
                                          padding: const EdgeInsets.only(
                                              left: 16, right: 16),
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                            // Icon(
                            //   Icons.notifications,
                            //   color: const Color(0xFFB0C3CC),
                            //   size: getValueForScreenType<double>(
                            //     context: context,
                            //     mobile: 20,
                            //     tablet: 22,
                            //     desktop: 24,
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      buildContent(userData, user, membershipData),
                    ],
                  );
                } else {
                  return const Loading();
                }
              }),
        ],
      ),
    ));
  }
}

class DashboardSideBar extends StatefulWidget {
  final String selectedSidebarItem;
  final Function(String) onItemSelected;
  const DashboardSideBar(
      {super.key,
      required this.selectedSidebarItem,
      required this.onItemSelected});

  @override
  State<DashboardSideBar> createState() => _DashboardSideBarState();
}

class _DashboardSideBarState extends State<DashboardSideBar> {
  final List<SideItem> sidebarItems = [
    const SideItem(icon: IconlyBold.category, title: 'Newsflash'),
    const SideItem(icon: IconlyBold.chart, title: 'My Courses'),
    const SideItem(icon: IconlyBold.buy, title: 'Transaction'),
    // const SideItem(icon: IconlyBold.document, title: 'Free Tutorial'),
    // const SideItem(icon: IconlyBold.chat, title: 'Review'),
  ];

  final List<SideItem> otherItems = [
    const SideItem(icon: IconlyBold.setting, title: 'Settings'),
    const SideItem(icon: IconlyBold.info_square, title: 'Help'),
    // Add other "OTHERS" items as needed
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: double.infinity,
      width: getValueForScreenType<double>(
        context: context,
        mobile: width * .14,
        tablet: width * .21,
        desktop: width * .17,
      ),
      color: CusColors.bgSideBar,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: getValueForScreenType<double>(
                context: context,
                mobile: 10,
                tablet: 40,
                desktop: 60,
              ),
              top: 10,
              bottom: getValueForScreenType<double>(
                context: context,
                mobile: 15,
                tablet: 30,
                desktop: 50,
              ),
            ),
            child: GestureDetector(
              onTap: () {
                Get.rootDelegate.toNamed(routeHome);
              },
              child: Image.asset(
                'assets/images/dec_logo2.png',
                width: getValueForScreenType<double>(
                  context: context,
                  mobile: width * .1,
                  tablet: width * .08,
                  desktop: width * .06,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  bottom: getValueForScreenType<double>(
                    context: context,
                    mobile: 10,
                    tablet: 12,
                    desktop: 21,
                  ),
                  left: getValueForScreenType<double>(
                    context: context,
                    mobile: 15,
                    tablet: 25,
                    desktop: 40,
                  ),
                ),
                child: Text(
                  'MENU',
                  style: GoogleFonts.poppins(
                      fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .018,
                        tablet: width * .015,
                        desktop: width * .01,
                      ),
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
                    padding: EdgeInsets.symmetric(
                      horizontal: getValueForScreenType<double>(
                        context: context,
                        mobile: 2,
                        tablet: 10,
                        desktop: 20,
                      ),
                      vertical: getValueForScreenType<double>(
                        context: context,
                        mobile: 5,
                        tablet: 7,
                        desktop: 10,
                      ),
                    ),
                    child: SideItem(
                      icon: item.icon,
                      title: item.title,
                      isSelected: item.title == widget.selectedSidebarItem,
                      onTap: () {
                        widget.onItemSelected(item.title);
                      },
                    ),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: getValueForScreenType<double>(
                    context: context,
                    mobile: 10,
                    tablet: 12,
                    desktop: 21,
                  ),
                  top: 25,
                  left: getValueForScreenType<double>(
                    context: context,
                    mobile: 15,
                    tablet: 25,
                    desktop: 40,
                  ),
                ),
                child: Text(
                  'OTHERS',
                  style: GoogleFonts.poppins(
                      fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .018,
                        tablet: width * .015,
                        desktop: width * .01,
                      ),
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
                    padding: EdgeInsets.symmetric(
                      horizontal: getValueForScreenType<double>(
                        context: context,
                        mobile: 2,
                        tablet: 10,
                        desktop: 20,
                      ),
                      vertical: getValueForScreenType<double>(
                        context: context,
                        mobile: 5,
                        tablet: 7,
                        desktop: 10,
                      ),
                    ),
                    child: SideItem(
                      icon: item.icon,
                      title: item.title,
                      isSelected: item.title == widget.selectedSidebarItem,
                      onTap: () {
                        widget.onItemSelected(item.title);
                      },
                    ),
                  );
                },
              ),
              //! hapus buat check device doang
              // Text(
              //   getValueForScreenType<String>(
              //     context: context,
              //     mobile: 'Mobile',
              //     tablet: 'Tablet',
              //     desktop: 'Desktop',
              //   ),
              // )
            ],
          ),
        ],
      ),
    );
  }
}
