import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/components/side_bar/side_item.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/screens/dashboard/edit_profile.dart';
import 'package:project_tc/services/auth_service.dart';
import 'package:project_tc/services/firestore_service.dart';
import 'package:provider/provider.dart';

class DashboardApp extends StatefulWidget {
  final String selected;
  const DashboardApp({super.key, required this.selected});

  @override
  State<DashboardApp> createState() => _DashboardAppState();
}

class _DashboardAppState extends State<DashboardApp> {
  final List<SideItem> sidebarItems = [
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

  String selectedSidebarItem = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedSidebarItem = widget.selected;
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
    Widget buildContent(dataUser, user) {
      switch (selectedSidebarItem) {
        case 'My Courses':
          return Container();
        case 'Transaction':
          return Container(
            height: 50,
            width: 50,
            color: Colors.amber,
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
          return EditProfile(userData: dataUser, user: user);
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
                    TextButton(
                        onPressed: () async {
                          final auth = AuthService();
                          await auth.signOut();
                        },
                        child: const Text('logut'))
                  ],
                )
              ],
            ),
          ),
          StreamBuilder(
              stream: FirestoreService(uid: user!.uid).userData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  UserData userData = snapshot.data!;
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
                                        image: NetworkImage(userData.photoUrl),
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
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 24,
                                    color: Color(0xFF8d99a3),
                                  ),
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.notifications,
                              color: Color(0xFFB0C3CC),
                            )
                          ],
                        ),
                      ),
                      buildContent(userData, user),
                    ],
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              }),
        ],
      ),
    ));
  }
}
