import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tc/screens/auth/register/register_responsive.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/services/auth_service.dart';

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
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/logo_dac.png',
                      height: width * .05,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Welcome Back !',
                      style: GoogleFonts.mPlus1(
                          fontSize: width * .015,
                          fontWeight: FontWeight.bold,
                          color: CusColors.text),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Text(
                      'Start your training center faster and better',
                      style: GoogleFonts.mulish(
                          fontSize: width * .01,
                          color: CusColors.subHeader.withOpacity(0.7)),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: height * .04),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  width: width / 3.5,
                                  margin: EdgeInsets.only(bottom: height * .02),
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
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: width / 3.5,
                                  child: TextFormField(
                                    autocorrect: true,
                                    keyboardType: TextInputType.visiblePassword,
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
                                          IconlyLight.lock,
                                          size: width * .02,
                                          color: CusColors.mainColor,
                                        ),
                                      ),
                                      suffixIcon: Container(
                                        margin: const EdgeInsets.only(right: 8),
                                        child: Icon(
                                          Icons.remove_red_eye_outlined,
                                          color: CusColors.subHeader
                                              .withOpacity(0.5),
                                          size: width * .015,
                                        ),
                                      ),
                                      hintText: "password",
                                      hintStyle: GoogleFonts.mulish(
                                          color: CusColors.subHeader
                                              .withOpacity(.5),
                                          fontSize: width * .009),
                                    ),
                                    obscureText: true,
                                    validator: (val) => val!.length < 6
                                        ? 'Enter an password 6 chars long'
                                        : null,
                                    onChanged: (val) {
                                      setState(() => password = val);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 15, right: 5),
                                  child: Row(
                                    children: [
                                      Text('Forgot password ?',
                                          style: GoogleFonts.mulish(
                                            color: CusColors.mainColor,
                                            fontSize: width * .0095,
                                          ))
                                    ],
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
                                                  .signInWithEmailAndPassword(
                                                      email, password);

                                              setState(() {
                                                if (result == null) {
                                                  error =
                                                      'Could not sign in with those credentials';
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
                                            'Sign in',
                                            style: GoogleFonts.mulish(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                              fontSize: width * .015,
                                            ),
                                          ),
                                  ),
                                ),
                                SizedBox(
                                  height: height * .04,
                                ),
                                Container(
                                  width: width / 3.5,
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
                                            "Or",
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
                                  height: height * .035,
                                ),
                                SizedBox(
                                  width: width / 3.5,
                                  child: ElevatedButton(
                                      onPressed: () {},
                                      style: ButtonStyle(
                                          padding: MaterialStateProperty.all<
                                                  EdgeInsetsGeometry>(
                                              EdgeInsets.symmetric(
                                                  vertical: width * .016)),
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
                                              const MaterialStatePropertyAll(
                                                  Colors.white),
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
                                            "Sign in with google",
                                            style: GoogleFonts.mulish(
                                                color: CusColors.subHeader,
                                                fontWeight: FontWeight.w500,
                                                fontSize: width * .01),
                                          )
                                        ],
                                      )),
                                ),
                                SizedBox(
                                  height: height * .03,
                                ),
                                Container(
                                  width: width / 3.5,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(left: 5),
                                  child: RichText(
                                    textAlign: TextAlign.left,
                                    text: TextSpan(
                                        text: "New here? ",
                                        style: GoogleFonts.mulish(
                                          color: CusColors.subHeader
                                              .withOpacity(.5),
                                          fontSize: width * .01,
                                        ),
                                        children: <InlineSpan>[
                                          TextSpan(
                                              text: "Register",
                                              style: GoogleFonts.mulish(
                                                  color: CusColors.mainColor,
                                                  fontWeight: FontWeight.w700),
                                              mouseCursor:
                                                  MaterialStateMouseCursor
                                                      .clickable,
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () => Get.to(
                                                      const ResponsiveRegister(),
                                                      transition:
                                                          Transition.fadeIn,
                                                    ))
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
