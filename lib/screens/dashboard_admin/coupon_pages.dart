import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/components/loading.dart';
import 'package:project_tc/models/coupon.dart';
import 'package:project_tc/models/coupons.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/routes/routes.dart';
import 'package:project_tc/services/extension.dart';
import 'package:project_tc/services/firestore_service.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AdminCoupons extends StatefulWidget {
  const AdminCoupons({super.key});

  @override
  State<AdminCoupons> createState() => _AdminCouponsState();
}

class _AdminCouponsState extends State<AdminCoupons> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    final FirestoreService firestoreService = FirestoreService(uid: user!.uid);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    var deviceType = getDeviceType(MediaQuery.of(context).size);
    double title = 0;
    double buttonText = 0;
    double subHeader = 0;
    double fixedWidthStatus = 0;

    switch (deviceType) {
      case DeviceScreenType.desktop:
        subHeader = width * .01;
        buttonText = width * .009;
        title = width * .014;
        fixedWidthStatus = 180;
        break;
      case DeviceScreenType.tablet:
        subHeader = width * .015;
        buttonText = width * .014;
        title = width * .019;
        fixedWidthStatus = 170;

        break;
      case DeviceScreenType.mobile:
        subHeader = width * .018;
        buttonText = width * .017;
        title = width * .022;
        fixedWidthStatus = 150;
        break;
      default:
        subHeader = 0;
        buttonText = 0;
        title = 0;
        fixedWidthStatus = 0;
    }
    return StreamBuilder(
      stream: firestoreService.couponsData,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          List<DataRow2> dataRows = snapshot.data!.asMap().entries.map((entry) {
            final Coupon coupon = entry.value['coupon'];
            final String couponId = entry.value['id'];
            int counter = entry.key + 1;
            // You need to adjust this part to match your Firestore data structure

            return DataRow2(cells: [
              DataCell(Text(
                counter.toString(),
                style: GoogleFonts.poppins(
                    fontSize: subHeader,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF121212)),
              )),
              DataCell(
                Text(
                  coupon.code!,
                  style: GoogleFonts.poppins(
                      fontSize: subHeader,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF121212)),
                ),
              ),
              DataCell(Text(
                getCouponDisplayName(coupon.type!),
                style: GoogleFonts.poppins(
                    fontSize: subHeader,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF7D8398)),
              )),
              DataCell(Text(
                coupon.amount.toString(),
                style: GoogleFonts.poppins(
                    fontSize: subHeader,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF7D8398)),
              )),
              DataCell(Text(
                coupon.description!,
                style: GoogleFonts.poppins(
                    fontSize: subHeader,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF7D8398)),
              )),
              DataCell(Text(
                '${coupon.timesUsed} / ${coupon.usageLimit!.perCoupon ?? "Unlimited"}',
                style: GoogleFonts.poppins(
                    fontSize: subHeader,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF7D8398)),
              )),
              DataCell(Text(
                coupon.expires != null
                    ? coupon.expires!.formatDate()
                    : 'No Expired',
                style: GoogleFonts.poppins(
                    fontSize: subHeader,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF7D8398)),
              )),
              DataCell(GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0xFF121212).withOpacity(.03),
                          offset: const Offset(0, 3),
                          blurRadius: 6)
                    ],
                    border: Border.all(
                      color: const Color(0xFF7D8398).withOpacity(.3),
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.edit,
                          color: Color(0xFF121212),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Text(
                            'Edit',
                            style: GoogleFonts.poppins(
                                fontSize: subHeader,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF121212)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )),
            ]);
          }).toList();
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
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getValueForScreenType<double>(
                      context: context,
                      mobile: 20,
                      tablet: 30,
                      desktop: 40,
                    ),
                    vertical: getValueForScreenType<double>(
                      context: context,
                      mobile: 20,
                      tablet: 30,
                      desktop: 35,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Coupons',
                            style: GoogleFonts.poppins(
                              fontSize: title,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF1F384C),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          SizedBox(
                            height: getValueForScreenType<double>(
                              context: context,
                              mobile: 24,
                              tablet: 26,
                              desktop: 30,
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                Get.rootDelegate.toNamed(routeCreateCoupon);
                              },
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(
                                      horizontal: getValueForScreenType<double>(
                                        context: context,
                                        mobile: 8,
                                        tablet: 10,
                                        desktop: 15,
                                      ),
                                    ),
                                  ),
                                  foregroundColor: MaterialStateProperty.all(
                                    const Color(0xFF4351FF),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.white,
                                  ),
                                  elevation: const MaterialStatePropertyAll(0),
                                  side:
                                      const MaterialStatePropertyAll(BorderSide(
                                    color: Color(0xFF4351FF),
                                  )),
                                  overlayColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.focused)) {
                                      return CusColors.accentBlue
                                          .withOpacity(.5);
                                    }
                                    if (states
                                        .contains(MaterialState.hovered)) {
                                      return CusColors.accentBlue
                                          .withOpacity(.3);
                                    }
                                    if (states
                                        .contains(MaterialState.pressed)) {
                                      return CusColors.accentBlue;
                                    }
                                    return Colors.transparent;
                                  }),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  )),
                              child: Text(
                                'Add coupon',
                                style: GoogleFonts.poppins(
                                  fontSize: buttonText,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF4351FF),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: height - 230,
                        child: DataTable2(
                          minWidth: getValueForScreenType<double>(
                            context: context,
                            mobile: 900,
                            tablet: 1000,
                            desktop: 1300,
                          ),
                          isHorizontalScrollBarVisible: false,
                          empty: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: getValueForScreenType<double>(
                                  context: context,
                                  mobile: 50,
                                  tablet: 60,
                                  desktop: 70,
                                ),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFCFCFC),
                                  border: Border.all(
                                    color: const Color(0xFF55565A)
                                        .withOpacity(.12),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'No Coupon data',
                                      style: GoogleFonts.poppins(
                                          fontSize: subHeader,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF7D8398)),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    GestureDetector(
                                      onTap: () => Get.rootDelegate
                                          .toNamed(routeCreateCoupon),
                                      child: Icon(
                                        CupertinoIcons.add_circled,
                                        color: CusColors.accentBlue,
                                        size: getValueForScreenType<double>(
                                          context: context,
                                          mobile: 18,
                                          tablet: 22,
                                          desktop: 24,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          dataRowHeight: getValueForScreenType<double>(
                            context: context,
                            mobile: 60,
                            tablet: 70,
                            desktop: 90,
                          ),
                          dividerThickness: .5,
                          headingRowHeight: getValueForScreenType<double>(
                            context: context,
                            mobile: 40,
                            tablet: 50,
                            desktop: 70,
                          ),
                          dataRowColor:
                              const MaterialStatePropertyAll(Color(0xFFfcfcfc)),
                          border: TableBorder.symmetric(
                              outside: BorderSide(
                            color: const Color(0xFF55565A).withOpacity(.12),
                          )),
                          showBottomBorder: false,
                          headingTextStyle: GoogleFonts.poppins(
                              fontSize: subHeader,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF121212)),
                          columns: [
                            const DataColumn2(
                                fixedWidth: 50,
                                label: Text(
                                  'No',
                                )),
                            const DataColumn2(
                                label: Text(
                              'Code',
                            )),
                            const DataColumn2(
                                label: Text(
                              'Coupon type',
                            )),
                            const DataColumn2(
                                size: ColumnSize.L,
                                label: Text(
                                  'Coupon amount',
                                )),
                            const DataColumn2(
                                label: Text(
                              'Description',
                            )),
                            const DataColumn2(
                                label: Text(
                              'Usage / Limit',
                            )),
                            const DataColumn2(
                                label: Text(
                              'Expired at',
                            )),
                            DataColumn2(
                                fixedWidth: fixedWidthStatus,
                                label: const Text(
                                  'Actions',
                                )),
                          ],
                          rows: dataRows,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No Coupon available.'),
          );
        } else {
          return const Center(
            child: Text('kok iso.'),
          );
        }
      },
    );
  }
}
