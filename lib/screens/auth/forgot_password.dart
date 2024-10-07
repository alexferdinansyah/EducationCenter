import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/routes/routes.dart';
import 'package:project_tc/services/auth_service.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
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
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: height * .04),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Lupa kata sandi',
                                  style: GoogleFonts.mPlus1(
                                      fontSize: width * .015,
                                      fontWeight: FontWeight.bold,
                                      color: CusColors.text),
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                                SizedBox(
                                  width: width / 3,
                                  child: Text(
                                    'Kami akan mengirimi Anda email berisi tautan untuk mengatur ulang kata sandi Anda, silakan masukkan email yang terkait dengan akun Anda di bawah.',
                                    style: GoogleFonts.mulish(
                                        fontSize: width * .01,
                                        color: CusColors.subHeader
                                            .withOpacity(0.7)),
                                  ),
                                ),
                                Container(
                                  width: width / 3.5,
                                  margin: EdgeInsets.symmetric(
                                      vertical: height * .02),
                                  alignment: Alignment.center,
                                  child: Text(
                                    error,
                                    style: GoogleFonts.mulish(
                                        fontSize: width * .01,
                                        color: Colors.red.withOpacity(0.7)),
                                  ),
                                ),
                                SizedBox(
                                  width: width / 3.5,
                                  child: TextFormField(
                                    autocorrect: true,
                                    keyboardType: TextInputType.emailAddress,
                                    style:
                                        TextStyle(color: CusColors.subHeader),
                                    decoration: textInputDecoration.copyWith(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 20.0,
                                          vertical: width * .016),
                                      prefixIcon: Container(
                                        margin: const EdgeInsets.only(
                                            left: 20, right: 15),
                                        child: Icon(
                                          IconlyLight.message,
                                          size: width * .02,
                                          color: CusColors.mainColor,
                                        ),
                                      ),
                                      hintText: "you@example.com",
                                      hintStyle: GoogleFonts.mulish(
                                          color: CusColors.subHeader
                                              .withOpacity(.5),
                                          fontSize: width * .009),
                                    ),
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return 'Masukkan email';
                                      } else if (!_auth.isValidEmail(val)) {
                                        return 'Masukkan email yang valid';
                                      }
                                      return null;
                                    },
                                    onChanged: (val) {
                                      setState(() => email = val);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.05,
                                ),
                                Container(
                                  width: width / 3.5,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: const Alignment(-1.2, 0.0),
                                          colors: [
                                            const Color(0xFF19A7CE),
                                            CusColors.mainColor,
                                          ]),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(.25),
                                            spreadRadius: 0,
                                            blurRadius: 20,
                                            offset: const Offset(0, 4))
                                      ]),
                                  child: ElevatedButton(
                                    onPressed: loading
                                        ? null // Disable the button when loading is true
                                        : () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              setState(() => loading =
                                                  true); // Set loading to true when pressed

                                              // Call your registration function here
                                              dynamic result = await _auth
                                                  .forgotPassword(email);

                                              setState(() {
                                                if (result != null) {
                                                  Get.snackbar(
                                                    'sukses',
                                                    result,
                                                    snackbarStatus: (status) {
                                                      switch (status) {
                                                        case SnackbarStatus
                                                              .CLOSED:
                                                          Get.back(
                                                              closeOverlays:
                                                                  true);
                                                          break;
                                                        default:
                                                      }
                                                    },
                                                  );
                                                } else {
                                                  error = 'emailnya tidak valid';
                                                }
                                                loading =
                                                    false; // Set loading back to false
                                              });
                                            }
                                          },
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8))),
                                        padding: MaterialStateProperty.all<
                                                EdgeInsetsGeometry>(
                                            EdgeInsets.symmetric(
                                          vertical: width * .014,
                                        )),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.transparent),
                                        shadowColor: MaterialStateProperty.all(
                                            Colors.transparent)),
                                    child: loading
                                        ? const CircularProgressIndicator() // Show loading indicator while loading is true
                                        : Text(
                                            'Mengonfirmasi',
                                            style: GoogleFonts.mulish(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                              fontSize: width * .015,
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        SvgPicture.asset(
                          'assets/svg/forgot_password.svg',
                          height: width * .3,
                        )
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
