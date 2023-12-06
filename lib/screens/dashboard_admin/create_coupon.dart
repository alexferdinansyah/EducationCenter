import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:multiple_search_selection/multiple_search_selection.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/components/custom_alert.dart';
import 'package:project_tc/components/side_bar/side_item.dart';
import 'package:project_tc/models/coupon.dart';
import 'package:project_tc/models/coupons.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/routes/routes.dart';
import 'package:project_tc/services/firestore_service.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:project_tc/services/extension.dart';

class CreateCoupon extends StatefulWidget {
  const CreateCoupon({super.key});

  @override
  State<CreateCoupon> createState() => _CreateCouponState();
}

class _CreateCouponState extends State<CreateCoupon> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _limitPerCouponController =
      TextEditingController();
  final TextEditingController _limitPerUserController = TextEditingController();
  final List<SideItem> sidebarItems = [
    const SideItem(icon: IconlyBold.category, title: 'General'),
    const SideItem(icon: IconlyBold.danger, title: 'Usage Restriction'),
    const SideItem(icon: IconlyBold.graph, title: 'Usage Limits'),
  ];

  List<bool> isOpen = [true, true];
  String selectedSidebarItem = 'General';
  String? description;
  Coupons type = Coupons.percentageCoupon;
  DateTime? expiryDate;
  Status status = Status.Draft;
  VisibilityType visibility = VisibilityType.Private;
  bool? loading;
  List<String> items = ['Membership'];
  List<String>? products;
  List<String>? excludeProducts;
  List<String>? productReward;

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        expiryDate = picked;
        _dateController.text = expiryDate?.formatDate() ?? '';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCourseTitles();
  }

  Future<void> fetchCourseTitles() async {
    List<String> titles =
        await FirestoreService.withoutUID().getAllCourseTitles();
    setState(() {
      items.addAll(titles);
    });
  }

  String generateCouponCode() {
    const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const numbers = '0123456789';
    final random = Random();

    String generateRandomLetters(int length) {
      return String.fromCharCodes(
        List.generate(
            length, (_) => letters.codeUnitAt(random.nextInt(letters.length))),
      );
    }

    String generateRandomNumbers(int length) {
      return String.fromCharCodes(
        List.generate(
            length, (_) => numbers.codeUnitAt(random.nextInt(numbers.length))),
      );
    }

    final firstPart = generateRandomLetters(4);
    final secondPart = generateRandomNumbers(4);

    return '$firstPart$secondPart';
  }

  void selectSidebarItem(String itemTitle) {
    setState(() {
      selectedSidebarItem = itemTitle;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final user = Provider.of<UserModel?>(context);

    var deviceType = getDeviceType(MediaQuery.of(context).size);
    double title = 0;
    double subTitle = 0;
    double buttonText = 0;
    double subHeader = 0;

    switch (deviceType) {
      case DeviceScreenType.desktop:
        subHeader = width * .01;
        buttonText = width * .009;
        title = width * .014;
        subTitle = width * .011;
        break;
      case DeviceScreenType.tablet:
        subHeader = width * .015;
        buttonText = width * .014;
        title = width * .019;
        subTitle = width * .016;

        break;
      case DeviceScreenType.mobile:
        subHeader = width * .018;
        buttonText = width * .017;
        title = width * .022;
        subTitle = width * .019;
        break;
      default:
        subHeader = 0;
        buttonText = 0;
        title = 0;
        subTitle = 0;
    }

    // Function to build content based on the selected sidebar item
    Widget buildContent(subHeader, buttonText) {
      switch (selectedSidebarItem) {
        case 'General':
          return _generalMenu(subHeader, buttonText);
        case 'Usage Restriction':
          return _usageRestriction(subHeader, buttonText);
        case 'Usage Limits':
          return _usageLimits(subHeader, buttonText);
        default:
          return Container(); // Handle the default case here
      }
    }

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
      child: Form(
        key: _formKey,
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
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: GestureDetector(
                            onTap: () =>
                                Get.rootDelegate.offNamed(routeAdminCoupon),
                            child: Icon(
                              Icons.arrow_back_rounded,
                              size: getValueForScreenType<double>(
                                context: context,
                                mobile: 18,
                                tablet: 22,
                                desktop: 24,
                              ),
                            )),
                      ),
                      Text(
                        'Add new coupon',
                        style: GoogleFonts.poppins(
                          fontSize: title,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF1F384C),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              key: const Key('coupon code'),
                              controller: _codeController,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(
                                    r'[a-zA-Z0-9]')), // Allow only letters and numbers
                              ],
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Enter an coupon code';
                                }
                                return null;
                              },
                              style: GoogleFonts.poppins(
                                  fontSize: buttonText,
                                  fontWeight: FontWeight.w500,
                                  color: CusColors.subHeader),
                              onChanged: (value) {
                                _codeController.value = TextEditingValue(
                                  text: value.toUpperCase(),
                                  selection: _codeController.selection,
                                );
                              },
                              decoration: editProfileDecoration.copyWith(
                                hintText: 'Coupon code',
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: buttonText,
                                  fontWeight: FontWeight.w500,
                                  color: CusColors.subHeader.withOpacity(0.5),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 8, bottom: 12),
                              height: getValueForScreenType<double>(
                                context: context,
                                mobile: 24,
                                tablet: 26,
                                desktop: 30,
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  _codeController.text = generateCouponCode();
                                },
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                      EdgeInsets.symmetric(
                                        horizontal:
                                            getValueForScreenType<double>(
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
                                    elevation:
                                        const MaterialStatePropertyAll(0),
                                    side: const MaterialStatePropertyAll(
                                        BorderSide(
                                      color: Color(0xFF4351FF),
                                    )),
                                    overlayColor:
                                        MaterialStateProperty.resolveWith<
                                            Color>((Set<MaterialState> states) {
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
                                  'Generate coupon code',
                                  style: GoogleFonts.poppins(
                                    fontSize: buttonText,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF4351FF),
                                  ),
                                ),
                              ),
                            ),
                            TextFormField(
                              key: const Key('description'),
                              minLines: 4,
                              maxLines: 5,
                              style: GoogleFonts.poppins(
                                  fontSize: buttonText,
                                  fontWeight: FontWeight.w500,
                                  color: CusColors.subHeader),
                              onChanged: (value) {
                                description = value;
                              },
                              decoration: editProfileDecoration.copyWith(
                                hintText: 'Description (optional)',
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: buttonText,
                                  fontWeight: FontWeight.w500,
                                  color: CusColors.subHeader.withOpacity(0.5),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: width / 4.5,
                        margin: const EdgeInsets.only(left: 25),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(
                            color: const Color(0xFFCCCCCC),
                            width: 1,
                          ),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Publish',
                                    style: GoogleFonts.poppins(
                                      fontSize: subTitle,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF1F384C),
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isOpen[0] = !isOpen[0];
                                      });
                                    },
                                    child: Icon(
                                      isOpen[0]
                                          ? Icons.keyboard_arrow_up
                                          : Icons.keyboard_arrow_down,
                                      size: getValueForScreenType<double>(
                                        context: context,
                                        mobile: 20,
                                        tablet: 22,
                                        desktop: 24,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: double.infinity,
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                height: 1,
                                color: const Color(0xFFCCCCCC),
                              ),
                              AnimatedSize(
                                curve: Curves.fastOutSlowIn,
                                duration: const Duration(milliseconds: 400),
                                child: Visibility(
                                  visible: isOpen[0],
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              text: 'Status : ',
                                              style: GoogleFonts.poppins(
                                                fontSize: subHeader,
                                                fontWeight: FontWeight.w400,
                                                color: const Color(0xFF1F384C),
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: status.name,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: subHeader,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        const Color(0xFF1F384C),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          DropdownButtonHideUnderline(
                                            child: DropdownButton2(
                                              isDense: true,
                                              customButton: Text(
                                                'Edit',
                                                style: GoogleFonts.poppins(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontSize: buttonText,
                                                  fontWeight: FontWeight.w400,
                                                  color: CusColors.accentBlue,
                                                ),
                                              ),
                                              items: Status.values
                                                  .map(
                                                    (item) => DropdownMenuItem<
                                                        Status>(
                                                      value: item,
                                                      child: Text(
                                                        item.name,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: subHeader,
                                                          fontWeight: item ==
                                                                  status
                                                              ? FontWeight.w500
                                                              : FontWeight.w400,
                                                          color: const Color(
                                                              0xFF1F384C),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  status = value!;
                                                });
                                              },
                                              dropdownStyleData:
                                                  DropdownStyleData(
                                                width: getValueForScreenType<
                                                        double>(
                                                    context: context,
                                                    mobile: 100,
                                                    tablet: 130,
                                                    desktop: 160),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 6),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  border: Border.all(
                                                      color: const Color(
                                                          0xFFCCCCCC),
                                                      width: 1),
                                                  color: Colors.white,
                                                ),
                                                offset: const Offset(0, 3),
                                              ),
                                              menuItemStyleData:
                                                  const MenuItemStyleData(
                                                padding: EdgeInsets.only(
                                                    left: 16, right: 16),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              text: 'Visibility : ',
                                              style: GoogleFonts.poppins(
                                                fontSize: subHeader,
                                                fontWeight: FontWeight.w400,
                                                color: const Color(0xFF1F384C),
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: visibility.name,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: subHeader,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        const Color(0xFF1F384C),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          DropdownButtonHideUnderline(
                                            child: DropdownButton2(
                                              isDense: true,
                                              customButton: Text(
                                                'Edit',
                                                style: GoogleFonts.poppins(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontSize: buttonText,
                                                  fontWeight: FontWeight.w400,
                                                  color: CusColors.accentBlue,
                                                ),
                                              ),
                                              items: VisibilityType.values
                                                  .map(
                                                    (item) => DropdownMenuItem<
                                                        VisibilityType>(
                                                      value: item,
                                                      child: Text(
                                                        item.name,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: subHeader,
                                                          fontWeight: item ==
                                                                  visibility
                                                              ? FontWeight.w500
                                                              : FontWeight.w400,
                                                          color: const Color(
                                                              0xFF1F384C),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  visibility = value!;
                                                });
                                              },
                                              dropdownStyleData:
                                                  DropdownStyleData(
                                                width: getValueForScreenType<
                                                        double>(
                                                    context: context,
                                                    mobile: 100,
                                                    tablet: 130,
                                                    desktop: 160),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 6),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  border: Border.all(
                                                      color: const Color(
                                                          0xFFCCCCCC),
                                                      width: 1),
                                                  color: Colors.white,
                                                ),
                                                offset: const Offset(0, 3),
                                              ),
                                              menuItemStyleData:
                                                  const MenuItemStyleData(
                                                padding: EdgeInsets.only(
                                                    left: 16, right: 16),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Container(
                                        width: double.infinity,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 4),
                                        height: 1,
                                        color: const Color(0xFFCCCCCC),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: SizedBox(
                                          height: getValueForScreenType<double>(
                                            context: context,
                                            mobile: 25,
                                            tablet: 30,
                                            desktop: 35,
                                          ),
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                final FirestoreService
                                                    firestore =
                                                    FirestoreService(
                                                        uid: user!.uid);
                                                final couponData = Coupon(
                                                  code: _codeController.text,
                                                  type: type,
                                                  amount: int.tryParse(
                                                      _amountController.text),
                                                  product: productReward?[0],
                                                  description:
                                                      description ?? '',
                                                  expires: expiryDate,
                                                  timesUsed: 0,
                                                  status: status,
                                                  visibility: visibility,
                                                  usageRestriction:
                                                      UsageRestriction(
                                                          products: products,
                                                          excludeProducts:
                                                              excludeProducts),
                                                  usageLimit: UsageLimit(
                                                    perCoupon: int.tryParse(
                                                        _limitPerCouponController
                                                            .text),
                                                    perUser: int.tryParse(
                                                        _limitPerUserController
                                                            .text),
                                                  ),
                                                );
                                                final result = await firestore
                                                    .addCoupon(couponData);

                                                if (result ==
                                                    'Success adding coupon') {
                                                  if (context.mounted) {
                                                    showDialog(
                                                        context: context,
                                                        builder: (_) {
                                                          return CustomAlert(
                                                              onPressed: () => Get
                                                                  .rootDelegate
                                                                  .offNamed(
                                                                      routeAdminCoupon),
                                                              title: 'Success',
                                                              message: result,
                                                              animatedIcon:
                                                                  'assets/animations/check.json');
                                                        });
                                                  }
                                                } else {
                                                  if (context.mounted) {
                                                    showDialog(
                                                        context: context,
                                                        builder: (_) {
                                                          return CustomAlert(
                                                              onPressed: () =>
                                                                  Get.back(),
                                                              title: 'Failed',
                                                              message: result,
                                                              animatedIcon:
                                                                  'assets/animations/failed.json');
                                                        });
                                                  }
                                                }
                                              }
                                            },
                                            style: ButtonStyle(
                                                foregroundColor:
                                                    MaterialStateProperty.all(
                                                  const Color(0xFF4351FF),
                                                ),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                  const Color(0xFF4351FF),
                                                ),
                                                shape:
                                                    MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                  ),
                                                )),
                                            child: Text(
                                              'Save',
                                              style: GoogleFonts.poppins(
                                                fontSize: subHeader,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ]),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xFFCCCCCC),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                'Coupon data',
                                style: GoogleFonts.poppins(
                                  fontSize: subTitle,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF1F384C),
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isOpen[1] = !isOpen[1];
                                  });
                                },
                                child: Icon(
                                  isOpen[1]
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  size: getValueForScreenType<double>(
                                    context: context,
                                    mobile: 20,
                                    tablet: 22,
                                    desktop: 24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 1,
                          color: const Color(0xFFCCCCCC),
                        ),
                        AnimatedSize(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.fastOutSlowIn,
                          child: Visibility(
                            visible: isOpen[1],
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: width / 5,
                                  padding: const EdgeInsets.only(bottom: 70),
                                  decoration: BoxDecoration(
                                      color:
                                          CusColors.bgSideBar.withOpacity(.5),
                                      border: const Border(
                                        right: BorderSide(
                                          color: Color(0xFFCCCCCC),
                                        ),
                                      )),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: sidebarItems.length,
                                    itemBuilder: (context, index) {
                                      final item = sidebarItems[index];
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical:
                                              getValueForScreenType<double>(
                                            context: context,
                                            mobile: 5,
                                            tablet: 7,
                                            desktop: 10,
                                          ),
                                        ),
                                        child: SideItem(
                                          icon: item.icon,
                                          title: item.title,
                                          isSelected:
                                              item.title == selectedSidebarItem,
                                          onTap: () {
                                            selectSidebarItem(item.title);
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                buildContent(subHeader, buttonText),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _generalMenu(subHeader, buttonText) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 200,
                  child: Text(
                    'Coupon type',
                    style: GoogleFonts.poppins(
                      fontSize: subHeader,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF1F384C),
                    ),
                  ),
                ),
                Expanded(
                  child: DropdownButtonFormField<Coupons>(
                    key: const Key('coupon type'),
                    value: type,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      size: getValueForScreenType<double>(
                        context: context,
                        mobile: 18,
                        tablet: 22,
                        desktop: 24,
                      ),
                    ),
                    decoration: editProfileDecoration.copyWith(
                        hintText: 'Select coupon type',
                        hintStyle: GoogleFonts.poppins(
                          fontSize: buttonText,
                          fontWeight: FontWeight.w500,
                          color: CusColors.subHeader.withOpacity(0.5),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: getValueForScreenType<double>(
                              context: context,
                              mobile: 2,
                              tablet: 3,
                              desktop: 5,
                            ),
                            horizontal: 10)),
                    onChanged: (val) {
                      setState(() {
                        type = val!; // Update the selected value
                      });
                    },
                    items: Coupons.values.map((coupon) {
                      return DropdownMenuItem<Coupons>(
                        value: coupon,
                        child: Text(
                          getCouponDisplayName(coupon),
                          style: GoogleFonts.poppins(
                              fontSize: buttonText,
                              fontWeight: FontWeight.w500,
                              color: CusColors.subHeader),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            if (type == Coupons.productCoupon)
              Row(
                children: [
                  SizedBox(
                    width: 200,
                    child: Text(
                      'Product',
                      style: GoogleFonts.poppins(
                        fontSize: subHeader,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF1F384C),
                      ),
                    ),
                  ),
                  Expanded(
                    child: MultipleSearchSelection(
                      key: const Key('product reward'),
                      items: items,
                      initialPickedItems: productReward,
                      fieldToCheck: (product) {
                        return product; // String
                      },
                      itemBuilder: (item, index) {
                        return Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 20.0,
                                horizontal: 12,
                              ),
                              child: Text(item),
                            ),
                          ),
                        );
                      },
                      pickedItemBuilder: (item) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey[400]!),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(item),
                          ),
                        );
                      },
                      fuzzySearch: FuzzySearch.levenshtein,
                      showSelectAllButton: false,
                      itemsVisibility: ShowedItemsVisibility.onType,
                      onPickedChange: (items) {
                        setState(() {
                          productReward = items;
                        });
                      },
                      showClearAllButton: false,
                      maxSelectedItems: 1,
                      searchFieldInputDecoration:
                          editProfileDecoration.copyWith(
                        hintText: 'Products',
                        hintStyle: GoogleFonts.poppins(
                          fontSize: buttonText,
                          fontWeight: FontWeight.w500,
                          color: CusColors.subHeader.withOpacity(0.5),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: getValueForScreenType<double>(
                            context: context,
                            mobile: 2,
                            tablet: 3,
                            desktop: 5,
                          ),
                          horizontal: 10,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            if (type != Coupons.productCoupon)
              Row(
                children: [
                  SizedBox(
                    width: 200,
                    child: Text(
                      'Coupon amount',
                      style: GoogleFonts.poppins(
                        fontSize: subHeader,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF1F384C),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      key: const Key('coupon amount'),
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*')),
                      ],
                      style: GoogleFonts.poppins(
                          fontSize: buttonText,
                          fontWeight: FontWeight.w500,
                          color: CusColors.subHeader),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Enter an amount coupon';
                        }
                        return null;
                      },
                      decoration: editProfileDecoration.copyWith(
                        hintText: 'Coupon amount',
                        hintStyle: GoogleFonts.poppins(
                          fontSize: buttonText,
                          fontWeight: FontWeight.w500,
                          color: CusColors.subHeader.withOpacity(0.5),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: getValueForScreenType<double>(
                            context: context,
                            mobile: 2,
                            tablet: 3,
                            desktop: 5,
                          ),
                          horizontal: 10,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                SizedBox(
                  width: 200,
                  child: Text(
                    'Coupon expiry date',
                    style: GoogleFonts.poppins(
                      fontSize: subHeader,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF1F384C),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectDate(context),
                    child: TextFormField(
                      key: const Key('expiry date'),
                      enabled: false,
                      controller: _dateController,
                      style: GoogleFonts.poppins(
                          fontSize: buttonText,
                          fontWeight: FontWeight.w500,
                          color: CusColors.subHeader),
                      decoration: editProfileDecoration.copyWith(
                        hintText: 'Expiry date',
                        hintStyle: GoogleFonts.poppins(
                          fontSize: buttonText,
                          fontWeight: FontWeight.w500,
                          color: CusColors.subHeader.withOpacity(0.5),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: getValueForScreenType<double>(
                            context: context,
                            mobile: 2,
                            tablet: 3,
                            desktop: 5,
                          ),
                          horizontal: 10,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _usageRestriction(subHeader, buttonText) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 200,
                  child: Text(
                    'Products',
                    style: GoogleFonts.poppins(
                      fontSize: subHeader,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF1F384C),
                    ),
                  ),
                ),
                Expanded(
                  child: MultipleSearchSelection(
                    key: const Key('ur products'),
                    items: items,
                    initialPickedItems: products,
                    fieldToCheck: (product) {
                      return product; // String
                    },
                    itemBuilder: (item, index) {
                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 12,
                            ),
                            child: Text(item),
                          ),
                        ),
                      );
                    },
                    pickedItemBuilder: (item) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey[400]!),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(item),
                        ),
                      );
                    },
                    fuzzySearch: FuzzySearch.levenshtein,
                    showSelectAllButton: false,
                    itemsVisibility: ShowedItemsVisibility.onType,
                    onPickedChange: (items) {
                      setState(() {
                        products = items;
                      });
                    },
                    searchFieldInputDecoration: editProfileDecoration.copyWith(
                      hintText: 'Products',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: buttonText,
                        fontWeight: FontWeight.w500,
                        color: CusColors.subHeader.withOpacity(0.5),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: getValueForScreenType<double>(
                          context: context,
                          mobile: 2,
                          tablet: 3,
                          desktop: 5,
                        ),
                        horizontal: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                SizedBox(
                  width: 200,
                  child: Text(
                    'Exclude Products',
                    style: GoogleFonts.poppins(
                      fontSize: subHeader,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF1F384C),
                    ),
                  ),
                ),
                Expanded(
                  child: MultipleSearchSelection(
                    key: const Key('ur exclude products'),
                    items: items,
                    initialPickedItems: excludeProducts,
                    fieldToCheck: (product) {
                      return product; // String
                    },
                    itemBuilder: (item, index) {
                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 12,
                            ),
                            child: Text(item),
                          ),
                        ),
                      );
                    },
                    pickedItemBuilder: (item) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey[400]!),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(item),
                        ),
                      );
                    },
                    fuzzySearch: FuzzySearch.levenshtein,
                    showSelectAllButton: false,
                    itemsVisibility: ShowedItemsVisibility.onType,
                    onPickedChange: (items) {
                      setState(() {
                        excludeProducts = items;
                      });
                    },
                    searchFieldInputDecoration: editProfileDecoration.copyWith(
                      hintText: 'Exclude Products',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: buttonText,
                        fontWeight: FontWeight.w500,
                        color: CusColors.subHeader.withOpacity(0.5),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: getValueForScreenType<double>(
                          context: context,
                          mobile: 2,
                          tablet: 3,
                          desktop: 5,
                        ),
                        horizontal: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _usageLimits(subHeader, buttonText) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 250,
                  child: Text(
                    'Usage limit per coupon',
                    style: GoogleFonts.poppins(
                      fontSize: subHeader,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF1F384C),
                    ),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    key: const Key('limit per coupon'),
                    controller: _limitPerCouponController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*')),
                    ],
                    style: GoogleFonts.poppins(
                        fontSize: buttonText,
                        fontWeight: FontWeight.w500,
                        color: CusColors.subHeader),
                    decoration: editProfileDecoration.copyWith(
                      hintText: 'Unlimited usage',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: buttonText,
                        fontWeight: FontWeight.w500,
                        color: CusColors.subHeader.withOpacity(0.5),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: getValueForScreenType<double>(
                            context: context,
                            mobile: 2,
                            tablet: 3,
                            desktop: 5,
                          ),
                          horizontal: 10),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                SizedBox(
                  width: 250,
                  child: Text(
                    'Usage limit per user',
                    style: GoogleFonts.poppins(
                      fontSize: subHeader,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF1F384C),
                    ),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    key: const Key('limit per user'),
                    controller: _limitPerUserController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*')),
                    ],
                    style: GoogleFonts.poppins(
                        fontSize: buttonText,
                        fontWeight: FontWeight.w500,
                        color: CusColors.subHeader),
                    decoration: editProfileDecoration.copyWith(
                      hintText: 'Unlimited usage',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: buttonText,
                        fontWeight: FontWeight.w500,
                        color: CusColors.subHeader.withOpacity(0.5),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: getValueForScreenType<double>(
                            context: context,
                            mobile: 2,
                            tablet: 3,
                            desktop: 5,
                          ),
                          horizontal: 10),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
