import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tc/routes/routes.dart';

import 'package:project_tc/components/constants.dart';
import 'package:project_tc/services/auth_service.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SignInWebsite extends StatefulWidget {
  const SignInWebsite({super.key});

  @override
  State<SignInWebsite> createState() => _SignInWebsiteState();
}

class _SignInWebsiteState extends State<SignInWebsite> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';
  bool showPassword = false;
  bool onHover = false;

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
                    SizedBox(
                      height: getValueForScreenType<double>(
                        context: context,
                        mobile: 15,
                        tablet: 20,
                        desktop: 30,
                      ),
                    ),
                    Text(
                      'Selamat Datang Kembali !',
                      style: GoogleFonts.mPlus1(
                          fontSize: getValueForScreenType<double>(
                            context: context,
                            mobile: width * .023,
                            tablet: width * .02,
                            desktop: width * .015,
                          ),
                          fontWeight: FontWeight.bold,
                          color: CusColors.text),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Text(
                      'Mulai pusat pendidikan Anda lebih cepat dan lebih baik',
                      style: GoogleFonts.mulish(
                          fontSize: getValueForScreenType<double>(
                            context: context,
                            mobile: width * .018,
                            tablet: width * .015,
                            desktop: width * .01,
                          ),
                          color: CusColors.subHeader.withOpacity(0.7)),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: getValueForScreenType<double>(
                              context: context,
                              mobile: 20,
                              tablet: 40,
                              desktop: height * .04,
                            ),
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  width: getValueForScreenType<double>(
                                    context: context,
                                    mobile: width * .019,
                                    tablet: width / 2.5,
                                    desktop: width / 3.5,
                                  ),
                                  margin: EdgeInsets.only(
                                    bottom: getValueForScreenType<double>(
                                      context: context,
                                      mobile: 10,
                                      tablet: 15,
                                      desktop: height * .02,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    error,
                                    style: GoogleFonts.mulish(
                                        fontSize: getValueForScreenType<double>(
                                          context: context,
                                          mobile: width * .018,
                                          tablet: width * .015,
                                          desktop: width * .01,
                                        ),
                                        color: Colors.red.withOpacity(0.7)),
                                  ),
                                ),
                                SizedBox(
                                  width: getValueForScreenType<double>(
                                    context: context,
                                    mobile: width * .019,
                                    tablet: width / 2.5,
                                    desktop: width / 3.5,
                                  ),
                                  child: TextFormField(
                                    autocorrect: true,
                                    keyboardType: TextInputType.emailAddress,
                                    style: GoogleFonts.mulish(
                                      color: CusColors.subHeader,
                                      fontSize: getValueForScreenType<double>(
                                        context: context,
                                        mobile: width * .019,
                                        tablet: width * .014,
                                        desktop: width * .009,
                                      ),
                                    ),
                                    decoration: textInputDecoration.copyWith(
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 20.0,
                                        vertical: getValueForScreenType<double>(
                                          context: context,
                                          mobile: 5,
                                          tablet: 15,
                                          desktop: width * .016,
                                        ),
                                      ),
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
                                        color:
                                            CusColors.subHeader.withOpacity(.5),
                                        fontSize: getValueForScreenType<double>(
                                          context: context,
                                          mobile: width * .019,
                                          tablet: width * .014,
                                          desktop: width * .009,
                                        ),
                                      ),
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
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: getValueForScreenType<double>(
                                    context: context,
                                    mobile: width * .019,
                                    tablet: width / 2.5,
                                    desktop: width / 3.5,
                                  ),
                                  child: TextFormField(
                                    autocorrect: true,
                                    keyboardType: TextInputType.visiblePassword,
                                    style: GoogleFonts.mulish(
                                      color: CusColors.subHeader,
                                      fontSize: getValueForScreenType<double>(
                                        context: context,
                                        mobile: width * .019,
                                        tablet: width * .014,
                                        desktop: width * .009,
                                      ),
                                    ),
                                    decoration: textInputDecoration.copyWith(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 20.0,
                                          vertical: width * .016),
                                      prefixIcon: Container(
                                        margin: const EdgeInsets.only(
                                            left: 20, right: 15),
                                        child: Icon(
                                          IconlyLight.lock,
                                          size: width * .02,
                                          color: CusColors.mainColor,
                                        ),
                                      ),
                                      suffixIcon: Container(
                                        margin: const EdgeInsets.only(right: 8),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              showPassword = !showPassword;
                                            });
                                          },
                                          child: Icon(
                                            showPassword
                                                ? Icons.visibility_off_outlined
                                                : Icons.remove_red_eye_outlined,
                                            color: CusColors.subHeader
                                                .withOpacity(0.5),
                                            size: width * .015,
                                          ),
                                        ),
                                      ),
                                      hintText: "password",
                                      hintStyle: GoogleFonts.mulish(
                                        color:
                                            CusColors.subHeader.withOpacity(.5),
                                        fontSize: getValueForScreenType<double>(
                                          context: context,
                                          mobile: width * .019,
                                          tablet: width * .014,
                                          desktop: width * .009,
                                        ),
                                      ),
                                    ),
                                    obscureText: showPassword ? false : true,
                                    validator: (val) => val!.length < 6
                                        ? 'Masukkan kata sandi sepanjang 6 karakter'
                                        : null,
                                    onChanged: (val) {
                                      setState(() => password = val);
                                    },
                                    onFieldSubmitted: loading
                                        ? null // Disable the button when loading is true
                                        : (value) async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              setState(() => loading =
                                                  true); // Set loading to true when pressed

                                              // Call your registration function here
                                              dynamic result = await _auth
                                                  .signInWithEmailAndPassword(
                                                      email, value);

                                              setState(() {
                                                if (result is String) {
                                                  error = result;
                                                }

                                                loading =
                                                    false; // Set loading back to false
                                              });
                                            }
                                          },
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 15, right: 5),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.rootDelegate.toNamed(routeForgotPassword);
                                        },
                                        child: Text('Lupa kata sandi?',
                                            style: GoogleFonts.mulish(
                                              color: CusColors.mainColor,
                                              fontSize:
                                                  getValueForScreenType<double>(
                                                context: context,
                                                mobile: width * .018,
                                                tablet: width * .015,
                                                desktop: width * .0095,
                                              ),
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: getValueForScreenType<double>(
                                    context: context,
                                    mobile: 15,
                                    tablet: 25,
                                    desktop: height * .05,
                                  ),
                                ),
                                Container(
                                  width: getValueForScreenType<double>(
                                    context: context,
                                    mobile: width * .019,
                                    tablet: width / 2.5,
                                    desktop: width / 3.5,
                                  ),
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
                                                  .signInWithEmailAndPassword(
                                                      email, password);

                                              setState(() {
                                                if (result is String) {
                                                  error = result;
                                                } else {
                                                  error = '';
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
                                          vertical: height * .018,
                                        )),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.transparent),
                                        shadowColor: MaterialStateProperty.all(
                                            Colors.transparent)),
                                    child: loading
                                        ? const CircularProgressIndicator() // Show loading indicator while loading is true
                                        : Text(
                                            'Masuk',
                                            style: GoogleFonts.mulish(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                              fontSize:
                                                  getValueForScreenType<double>(
                                                context: context,
                                                mobile: width * .023,
                                                tablet: width * .02,
                                                desktop: width * .015,
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                                SizedBox(
                                  height: getValueForScreenType<double>(
                                    context: context,
                                    mobile: 15,
                                    tablet: 22,
                                    desktop: height * .04,
                                  ),
                                ),
                                Container(
                                  width: getValueForScreenType<double>(
                                    context: context,
                                    mobile: width * .019,
                                    tablet: width / 2.5,
                                    desktop: width / 3.5,
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        flex: 2,
                                        child: Divider(
                                          height: 1,
                                          color: CusColors.subHeader
                                              .withOpacity(0.4),
                                        ),
                                      ),
                                      Flexible(
                                          flex: 1,
                                          child: Text(
                                            "Atau",
                                            style: GoogleFonts.mulish(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 11,
                                                color: CusColors.subHeader),
                                          )),
                                      Flexible(
                                        flex: 2,
                                        child: Divider(
                                          height: 1,
                                          color: CusColors.subHeader
                                              .withOpacity(0.4),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: getValueForScreenType<double>(
                                    context: context,
                                    mobile: 15,
                                    tablet: 22,
                                    desktop: height * .04,
                                  ),
                                ),
                                SizedBox(
                                  width: getValueForScreenType<double>(
                                    context: context,
                                    mobile: width * .019,
                                    tablet: width / 2.5,
                                    desktop: width / 3.5,
                                  ),
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        await AuthService().signInWithGoogle();
                                      },
                                      onHover: (value) {
                                        setState(() {
                                          onHover = value;
                                        });
                                      },
                                      style: ButtonStyle(
                                          padding: MaterialStateProperty.all<
                                                  EdgeInsetsGeometry>(
                                              EdgeInsets.symmetric(
                                                  vertical: height * .018)),
                                          shape: MaterialStatePropertyAll(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                side: BorderSide(
                                                    color: CusColors.subHeader
                                                        .withOpacity(.5),
                                                    width: 1.3)),
                                          ),
                                          backgroundColor:
                                              MaterialStatePropertyAll(onHover
                                                  ? Colors.grey.shade100
                                                  : Colors.white),
                                          shadowColor:
                                              const MaterialStatePropertyAll(
                                                  Colors.transparent)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/svg/google.svg",
                                            width: width * .015,
                                          ),
                                          const SizedBox(
                                            width: 14,
                                          ),
                                          Text(
                                            "Masuk dengan google",
                                            style: GoogleFonts.mulish(
                                              color: CusColors.subHeader,
                                              fontWeight: FontWeight.w500,
                                              fontSize:
                                                  getValueForScreenType<double>(
                                                context: context,
                                                mobile: width * .018,
                                                tablet: width * .015,
                                                desktop: width * .01,
                                              ),
                                            ),
                                          )
                                        ],
                                      )),
                                ),
                                SizedBox(
                                  height: getValueForScreenType<double>(
                                    context: context,
                                    mobile: 15,
                                    tablet: 20,
                                    desktop: height * .03,
                                  ),
                                ),
                                Container(
                                  width: getValueForScreenType<double>(
                                    context: context,
                                    mobile: width * .019,
                                    tablet: width / 2.5,
                                    desktop: width / 3.5,
                                  ),
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(left: 5),
                                  child: RichText(
                                    textAlign: TextAlign.left,
                                    text: TextSpan(
                                        text: "Baru di sini? ",
                                        style: GoogleFonts.mulish(
                                          color: CusColors.subHeader
                                              .withOpacity(.5),
                                          fontSize:
                                              getValueForScreenType<double>(
                                            context: context,
                                            mobile: width * .018,
                                            tablet: width * .015,
                                            desktop: width * .01,
                                          ),
                                        ),
                                        children: <InlineSpan>[
                                          TextSpan(
                                              text: "Daftar",
                                              style: GoogleFonts.mulish(
                                                color: CusColors.mainColor,
                                                fontWeight: FontWeight.w700,
                                                fontSize: getValueForScreenType<
                                                    double>(
                                                  context: context,
                                                  mobile: width * .018,
                                                  tablet: width * .015,
                                                  desktop: width * .01,
                                                ),
                                              ),
                                              mouseCursor:
                                                  MaterialStateMouseCursor
                                                      .clickable,
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () =>
                                                    Get.rootDelegate.toNamed(routeRegister))
                                        ]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        SvgPicture.asset(
                          'assets/svg/sign_in.svg',
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
