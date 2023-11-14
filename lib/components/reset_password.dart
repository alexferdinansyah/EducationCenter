import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ResetPasswordDialog extends StatefulWidget {
  const ResetPasswordDialog({super.key});

  @override
  State<ResetPasswordDialog> createState() => _ResetPasswordDialogState();
}

class _ResetPasswordDialogState extends State<ResetPasswordDialog> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  String email = '';
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final user = Provider.of<UserModel?>(context);

    email = user!.email;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Color(0xFFCCCCCC),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Reset your password',
          style: GoogleFonts.poppins(
            fontSize: getValueForScreenType<double>(
              context: context,
              mobile: width * .022,
              tablet: width * .019,
              desktop: width * .014,
            ),
            fontWeight: FontWeight.w500,
            color: const Color(0xFF1F384C),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "We will send you an email with a link to reset your password, please check if the email is correct.",
          style: GoogleFonts.poppins(
            fontSize: getValueForScreenType<double>(
              context: context,
              mobile: width * .016,
              tablet: width * .013,
              desktop: width * .008,
            ),
            fontWeight: FontWeight.w400,
            color: const Color(0xFF7d848c),
          ),
        )
      ]),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: TextFormField(
            initialValue: email,
            style: GoogleFonts.poppins(
              fontSize: getValueForScreenType<double>(
                context: context,
                mobile: width * .018,
                tablet: width * .015,
                desktop: width * .01,
              ),
              fontWeight: FontWeight.w500,
              color: CusColors.text,
            ),
            keyboardType: TextInputType.emailAddress,
            decoration: editProfileDecoration.copyWith(
              contentPadding: EdgeInsets.symmetric(
                  vertical: getValueForScreenType<double>(
                    context: context,
                    mobile: 13,
                    tablet: 15,
                    desktop: 16,
                  ),
                  horizontal: 18),
              hintText: 'Enter an email',
              hintStyle: GoogleFonts.poppins(
                fontSize: getValueForScreenType<double>(
                  context: context,
                  mobile: width * .018,
                  tablet: width * .015,
                  desktop: width * .01,
                ),
                fontWeight: FontWeight.w500,
                color: CusColors.secondaryText,
              ),
            ),
            validator: (val) {
              if (val!.isEmpty) {
                return 'Enter an email';
              } else if (!_auth.isValidEmail(val)) {
                return 'Enter a valid email';
              }
              return null;
            },
            onChanged: (val) {
              setState(() => email = val);
            },
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: GoogleFonts.poppins(
              fontSize: getValueForScreenType<double>(
                context: context,
                mobile: width * .018,
                tablet: width * .015,
                desktop: width * .01,
              ),
              fontWeight: FontWeight.w500,
              color: CusColors.secondaryText,
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        SizedBox(
          height: getValueForScreenType<double>(
            context: context,
            mobile: 26,
            tablet: 33,
            desktop: 38,
          ),
          child: ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                // Call your registration function here
                dynamic result = await _auth.forgotPassword(email);

                setState(() {
                  if (result != null) {
                    Get.snackbar(
                      'Success',
                      result,
                      snackbarStatus: (status) {
                        switch (status) {
                          case SnackbarStatus.CLOSED:
                            Get.back(closeOverlays: true);
                            break;
                          default:
                        }
                      },
                    );
                  } else {
                    Get.snackbar(
                      'Failed',
                      'Email is not valid',
                    );
                  }
                });
              }
            },
            style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(
                    horizontal: getValueForScreenType<double>(
                      context: context,
                      mobile: 20,
                      tablet: 25,
                      desktop: 30,
                    ),
                  ),
                ),
                foregroundColor: MaterialStateProperty.all(
                  const Color(0xFF4351FF),
                ),
                backgroundColor: MaterialStateProperty.all(
                  const Color(0xFF4351FF),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                )),
            child: Text(
              'Send link',
              style: GoogleFonts.poppins(
                fontSize: getValueForScreenType<double>(
                  context: context,
                  mobile: width * .018,
                  tablet: width * .015,
                  desktop: width * .01,
                ),
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }
}
