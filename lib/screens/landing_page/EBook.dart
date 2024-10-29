import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Ebook extends StatelessWidget {
  const Ebook({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
            margin: EdgeInsets.only(top: 30),
            width: width * 0.8,
            child: Image.asset('assets/images/SLIDE 7.png'))
      ]),
      Padding(
        padding: EdgeInsets.only(
          top: getValueForScreenType<double>(
            context: context,
            mobile: 40,
            tablet: 70,
            desktop: 100,
          ),
          bottom: getValueForScreenType<double>(
            context: context,
            mobile: 40,
            tablet: 70,
            desktop: 100,
          ),
        ),
      )
    ]);
  }
}