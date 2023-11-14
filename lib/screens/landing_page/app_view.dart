import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/components/navigation_bar/navigation_bar.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AppView extends StatefulWidget {
  final Widget child;
  const AppView({super.key, required this.child});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // print('Current Widget in AppView: ${widget.child.runtimeType}');

    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: width * .045, vertical: height * .018),
            color: CusColors.bg,
            alignment: Alignment.centerLeft,
            child: AnimateIfVisibleWrapper(
              showItemInterval: const Duration(milliseconds: 150),
              child: SingleChildScrollView(
                physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ScreenTypeLayout.builder(
                        desktop: (BuildContext context) =>
                            const CusNavigationBar(),
                        tablet: (BuildContext context) => const SizedBox(),
                        mobile: (BuildContext context) => const SizedBox()),
                    widget.child,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppViewWrapper extends StatefulWidget {
  final Widget child;
  const AppViewWrapper({super.key, required this.child});

  @override
  State<AppViewWrapper> createState() => _AppViewWrapperState();
}

class _AppViewWrapperState extends State<AppViewWrapper> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        // Check the sizing information here and return your UI
        if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
          return _mobileNav(widget.child, width, height);
        } else if (sizingInformation.deviceScreenType ==
            DeviceScreenType.tablet) {
          return _mobileNav(widget.child, width, height);
        } else {
          return _dekstopNav(widget.child);
        }
      },
    );
  }

  Widget _mobileNav(child, width, height) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            title: Image.asset(
              'assets/images/dec_logo2.png',
              width: getValueForScreenType<double>(
                context: context,
                mobile: width * .13,
                tablet: width * .1,
                desktop: width * .02,
              ),
            ),
            elevation: 0,
            centerTitle: false,
            backgroundColor: CusColors.bg,
            automaticallyImplyLeading: false,
            actions: [
              Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    padding: EdgeInsets.only(right: width * .03),
                    icon: const Icon(Icons.menu),
                    enableFeedback: false,
                    hoverColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                  );
                },
              ),
            ],
            iconTheme: const IconThemeData(color: Color(0xFF458FF6))),
        endDrawer: Drawer(
          width: double.infinity,
          backgroundColor: CusColors.bgSideBar,
          child: ListView(
            children: const [CusNavigationBarMobile()],
          ),
        ),
        body: AppView(child: child));
  }

  Widget _dekstopNav(child) {
    return Scaffold(body: AppView(child: child));
  }
}
