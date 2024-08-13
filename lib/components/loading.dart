import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:project_tc/components/constants.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: getValueForScreenType<double>(
        context: context,
        mobile: width * .86,
        tablet: width * .79,
        desktop: width * .83,
      ),
      height: getValueForScreenType<double>(
        context: context,
        mobile: height - 40,
        tablet: height - 50,
        desktop: height - 60,
      ),
      color: CusColors.bg,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SpinKitDualRing(
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
