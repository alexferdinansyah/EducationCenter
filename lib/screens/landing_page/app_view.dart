import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/components/navigation_bar/navigation_bar.dart';

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
    print('Current Widget in AppView: ${widget.child.runtimeType}');
    return Scaffold(
      body: SizedBox(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [const CusNavigationBar(), widget.child],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
