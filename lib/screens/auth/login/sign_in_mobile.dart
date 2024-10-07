import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_tc/routes/routes.dart';
import 'package:project_tc/components/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tc/services/auth_service.dart';

class SignInMobile extends StatefulWidget {
  const SignInMobile({super.key});

  @override
  State<SignInMobile> createState() => _SignInMobileState();
}

class _SignInMobileState extends State<SignInMobile> {
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
              child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/svg/sign_in.svg',
                            height: 300,
                            alignment: Alignment.topCenter,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          'Masuk',
                          style: GoogleFonts.quicksand(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10, bottom: 5, right: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(error,
                                style: GoogleFonts.mulish(
                                  color: Colors.red,
                                  fontSize: width * .03,
                                ))
                          ],
                        ),
                      ),
                      Container(
                        child: TextFormField(
                          autocorrect: true,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(color: CusColors.subHeader),
                          decoration: textInputDecoration.copyWith(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 15),
                            prefixIcon: Container(
                              margin:
                                  const EdgeInsets.only(left: 20, right: 15),
                              child: Icon(
                                IconlyLight.message,
                                size: width * .05,
                                color: CusColors.mainColor,
                              ),
                            ),
                            hintText: "you@example.com",
                            hintStyle: GoogleFonts.mulish(
                              color: CusColors.subHeader.withOpacity(.5),
                              fontSize: width * .032,
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
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          style: TextStyle(color: CusColors.subHeader),
                          decoration: textInputDecoration.copyWith(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 15),
                            prefixIcon: Container(
                              margin:
                                  const EdgeInsets.only(left: 20, right: 15),
                              child: Icon(
                                IconlyLight.lock,
                                size: width * .05,
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
                                  color: CusColors.subHeader.withOpacity(0.5),
                                ),
                              ),
                            ),
                            hintText: "password",
                            hintStyle: GoogleFonts.mulish(
                              color: CusColors.subHeader.withOpacity(.5),
                              fontSize: width * .032,
                            ),
                          ),
                          obscureText: showPassword ? false : true,
                          validator: (val) => val!.length < 6
                              ? 'Masukkan kata sandi sepanjang 6 karakter'
                              : null,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, right: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.rootDelegate.toNamed(routeForgotPassword);
                              },
                              child: Text('Lupa kata sandi?',
                                  style: GoogleFonts.mulish(
                                    color: CusColors.mainColor,
                                    fontSize: width * .028,
                                  )),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      Container(
                        width: double.infinity,
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
                                  color: Colors.black.withOpacity(.25),
                                  spreadRadius: 0,
                                  blurRadius: 20,
                                  offset: const Offset(0, 4))
                            ]),
                        child: ElevatedButton(
                          onPressed: loading
                              ? null // Disable the button when loading is true
                              : () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() => loading =
                                        true); // Set loading to true when pressed

                                    // Call your registration function here
                                    dynamic result =
                                        await _auth.signInWithEmailAndPassword(
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
                                      borderRadius: BorderRadius.circular(8))),
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                      const EdgeInsets.all(10)),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              shadowColor: MaterialStateProperty.all(
                                  Colors.transparent)),
                          child: loading
                              ? const CircularProgressIndicator() // Show loading indicator while loading is true
                              : Text(
                                  'Masuk',
                                  style: GoogleFonts.mulish(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: width * .043,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: height * .025,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 2,
                              child: Divider(
                                height: 1,
                                color: CusColors.subHeader.withOpacity(0.4),
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
                                color: CusColors.subHeader.withOpacity(0.4),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * .025,
                      ),
                      SizedBox(
                        width: double.infinity,
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
                                    const EdgeInsets.all(10)),
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: BorderSide(
                                          color: CusColors.subHeader
                                              .withOpacity(.5),
                                          width: 1.3)),
                                ),
                                backgroundColor: MaterialStatePropertyAll(
                                    onHover
                                        ? Colors.grey.shade100
                                        : Colors.white),
                                shadowColor: const MaterialStatePropertyAll(
                                    Colors.transparent)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/svg/google.svg",
                                  width: width * .05,
                                ),
                                const SizedBox(
                                  width: 14,
                                ),
                                Text(
                                  "Masuk dengan google",
                                  style: GoogleFonts.mulish(
                                      color: CusColors.subHeader,
                                      fontWeight: FontWeight.w500,
                                      fontSize: width * .035),
                                )
                              ],
                            )),
                      ),
                      SizedBox(
                        height: height * .025,
                      ),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(left: 5),
                        child: RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                              text: "Baru di sini?",
                              style: GoogleFonts.mulish(
                                color: CusColors.subHeader.withOpacity(.5),
                                fontSize: width * .035,
                              ),
                              children: <InlineSpan>[
                                TextSpan(
                                    text: "Daftar",
                                    style: GoogleFonts.mulish(
                                        color: CusColors.mainColor,
                                        fontWeight: FontWeight.w700),
                                    mouseCursor:
                                        MaterialStateMouseCursor.clickable,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => Get.rootDelegate
                                          .toNamed(routeRegister))
                              ]),
                        ),
                      ),
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
