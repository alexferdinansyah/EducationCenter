import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/components/custom_alert.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/services/firestore_service.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CouponRedeem extends StatefulWidget {
  final bool isProductCoupon;
  final String? title;
  const CouponRedeem({super.key, required this.isProductCoupon, this.title});

  @override
  State<CouponRedeem> createState() => _CouponRedeemState();
}

class _CouponRedeemState extends State<CouponRedeem> {
  final TextEditingController _codeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String? error;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final user = Provider.of<UserModel?>(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Color(0xFFCCCCCC),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      title: Row(
        children: [
          Text(
            widget.isProductCoupon ? 'Redeem code' : 'Use coupon',
            style: GoogleFonts.poppins(
              fontSize: getValueForScreenType<double>(
                context: context,
                mobile: width * .021,
                tablet: width * .018,
                desktop: width * .013,
              ),
              fontWeight: FontWeight.w500,
              color: const Color(0xFF1F384C),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => Get.back(result: false),
            child: Icon(
              Icons.close,
              size: getValueForScreenType<double>(
                context: context,
                mobile: 20,
                tablet: 22,
                desktop: 24,
              ),
            ),
          )
        ],
      ),
      content: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: getValueForScreenType<double>(
                      context: context,
                      mobile: 200,
                      tablet: 250,
                      desktop: 300,
                    ),
                    child: TextFormField(
                      style: GoogleFonts.poppins(
                        fontSize: getValueForScreenType<double>(
                          context: context,
                          mobile: width * .018,
                          tablet: width * .015,
                          desktop: width * .009,
                        ),
                        fontWeight: FontWeight.w500,
                        color: CusColors.text,
                      ),
                      controller: _codeController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(
                            r'[a-zA-Z0-9]')), // Allow only letters and numbers
                      ],
                      onChanged: (value) {
                        _codeController.value = TextEditingValue(
                          text: value.toUpperCase(),
                          selection: _codeController.selection,
                        );
                      },
                      keyboardType: TextInputType.text,
                      decoration: editProfileDecoration.copyWith(
                        errorText: error,
                        errorMaxLines: 2,
                        errorStyle: GoogleFonts.poppins(
                          fontSize: getValueForScreenType<double>(
                            context: context,
                            mobile: width * .017,
                            tablet: width * .014,
                            desktop: width * .008,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: getValueForScreenType<double>(
                            context: context,
                            mobile: 9,
                            tablet: 11,
                            desktop: 12,
                          ),
                          horizontal: 15,
                        ),
                        hintText: 'Enter an code',
                        hintStyle: GoogleFonts.poppins(
                          fontSize: getValueForScreenType<double>(
                            context: context,
                            mobile: width * .018,
                            tablet: width * .015,
                            desktop: width * .009,
                          ),
                          fontWeight: FontWeight.w500,
                          color: CusColors.secondaryText,
                        ),
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Code cannot be empty';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: getValueForScreenType<double>(
                      context: context,
                      mobile: 8,
                      tablet: 10,
                      desktop: 15,
                    ),
                  ),
                  SizedBox(
                    height: getValueForScreenType<double>(
                      context: context,
                      mobile: 28,
                      tablet: 30,
                      desktop: 34,
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          final FirestoreService firestore =
                              FirestoreService(uid: user!.uid);

                          if (widget.isProductCoupon) {
                            final result =
                                await firestore.checkValidationCoupon(
                                    _codeController.text,
                                    widget.isProductCoupon,
                                    widget.title);

                            if (result is String &&
                                result != 'Success Redeem') {
                              setState(() {
                                error = result;
                                loading = false;
                              });
                            } else {
                              Get.back();
                              if (context.mounted) {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return CustomAlert(
                                          onPressed: () => Get.back(),
                                          title: 'Success',
                                          message: result,
                                          animatedIcon:
                                              'assets/animations/check.json');
                                    });
                              }
                            }
                          } else {
                            final result =
                                await firestore.checkValidationCoupon(
                                    _codeController.text,
                                    widget.isProductCoupon,
                                    widget.title);

                            if (result is String) {
                              setState(() {
                                error = result;
                                loading = false;
                              });
                            } else {
                              Get.back(result: result);
                            }
                          }
                        }
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
                          side: const MaterialStatePropertyAll(BorderSide(
                            color: Color(0xFF4351FF),
                          )),
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                            if (states.contains(MaterialState.focused)) {
                              return CusColors.accentBlue.withOpacity(.5);
                            }
                            if (states.contains(MaterialState.hovered)) {
                              return CusColors.accentBlue.withOpacity(.3);
                            }
                            if (states.contains(MaterialState.pressed)) {
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
                        'Apply',
                        style: GoogleFonts.poppins(
                          fontSize: getValueForScreenType<double>(
                            context: context,
                            mobile: width * .018,
                            tablet: width * .015,
                            desktop: width * .009,
                          ),
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF4351FF),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
