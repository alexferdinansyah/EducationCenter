import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/routes/routes.dart';
import 'package:project_tc/services/auth_service.dart';

class RegisterMobile extends StatefulWidget {
  const RegisterMobile({super.key});

  @override
  State<RegisterMobile> createState() => _RegisterMobileState();
}

class _RegisterMobileState extends State<RegisterMobile> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String name = '';
  String email = '';
  String noWhatsapp = '';
  String address = '';
  String lastEducation = 'Pilih pendidikan terakhir';
  List lastEducations = [
    'Pilih pendidikan terakhir',
    'SMA/SMK',
    'D3',
    'S1',
  ];
  String workingStatus = 'Sudah bekerja?';
  List working = [
    'Sudah bekerja?',
    'Ya',
    'Tidak',
  ];
  String reason = '';
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
                          'Mendaftar',
                          style: GoogleFonts.quicksand(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        child: TextFormField(
                          autocorrect: true,
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: CusColors.subHeader),
                          decoration: textInputDecoration.copyWith(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 15),
                            prefixIcon: Container(
                              margin:
                                  const EdgeInsets.only(left: 20, right: 15),
                              child: Icon(
                                IconlyLight.profile,
                                size: width * .05,
                                color: CusColors.mainColor,
                              ),
                            ),
                            hintText: "Fullname",
                            hintStyle: GoogleFonts.mulish(
                              color: CusColors.subHeader.withOpacity(.5),
                              fontSize: width * .032,
                            ),
                          ),
                          validator: (val) =>
                              val!.isEmpty ? 'Masukkan nama' : null,
                          onChanged: (val) {
                            setState(() => name = val);
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^[0-9\-\+\s()]*$')),
                          ],
                          style: TextStyle(color: CusColors.subHeader),
                          decoration: textInputDecoration.copyWith(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 15),
                            prefixIcon: Container(
                              margin:
                                  const EdgeInsets.only(left: 20, right: 15),
                              child: Icon(
                                IconlyLight.call,
                                size: width * .05,
                                color: CusColors.mainColor,
                              ),
                            ),
                            hintText: "No. Whatsapp",
                            hintStyle: GoogleFonts.mulish(
                              color: CusColors.subHeader.withOpacity(.5),
                              fontSize: width * .032,
                            ),
                          ),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Masukkan No. Whatsapp';
                            } else if (val.length < 11 || val.length > 15) {
                              return 'Nomor harus antara 11 dan 15 karakter';
                            } else if (!val.startsWith('08')) {
                              return 'Nomor tidak valid, contoh 08xxxxxxx';
                            }
                            return null;
                          },
                          onChanged: (val) {
                            setState(() => noWhatsapp = val);
                          },
                        ),
                      ),
                      Container(
                        child: TextFormField(
                          autocorrect: true,
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: CusColors.subHeader),
                          decoration: textInputDecoration.copyWith(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 15),
                            prefixIcon: Container(
                              margin:
                                  const EdgeInsets.only(left: 20, right: 15),
                              child: Icon(
                                IconlyLight.location,
                                size: width * .05,
                                color: CusColors.mainColor,
                              ),
                            ),
                            hintText: "Alamat",
                            hintStyle: GoogleFonts.mulish(
                              color: CusColors.subHeader.withOpacity(.5),
                              fontSize: width * .032,
                            ),
                          ),
                          validator: (val) =>
                              val!.isEmpty ? 'Masukkan alamat' : null,
                          onChanged: (val) {
                            setState(() => address = val);
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: DropdownButtonFormField<String>(
                          value:
                              lastEducation, // Make sure to define 'selectedValue' as a state variable.
                          decoration: textInputDecoration.copyWith(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 15),
                            prefixIcon: Container(
                              margin:
                                  const EdgeInsets.only(left: 20, right: 15),
                              child: Icon(
                                IconlyLight.work,
                                size: width * .05,
                                color: CusColors.mainColor,
                              ),
                            ),
                            hintText: "Pendidikan terakhir",
                            hintStyle: GoogleFonts.mulish(
                              color: CusColors.subHeader.withOpacity(.5),
                              fontSize: width * .032,
                            ),
                          ),
                          validator: (val) => val == null ||
                                  val.isEmpty ||
                                  val == 'Pilih pendidikan terakhir'
                              ? 'Silakan pilih pendidikan'
                              : null,
                          onChanged: (val) {
                            setState(() {
                              lastEducation = val!; // Update the selected value
                            });
                          },
                          items: lastEducations.map((education) {
                            return DropdownMenuItem<String>(
                              value: education,
                              child: education == 'Pilih pendidikan terakhir'
                                  ? Text(
                                      education,
                                      style: GoogleFonts.mulish(
                                          color: CusColors.subHeader
                                              .withOpacity(.5),
                                          fontSize: width * .032),
                                    )
                                  : Text(
                                      education,
                                      style: GoogleFonts.mulish(
                                          fontSize: width * .032),
                                    ),
                            );
                          }).toList(),
                        ),
                      ),
                      Container(
                        child: DropdownButtonFormField<String>(
                          value:
                              workingStatus, // Make sure to define 'selectedValue' as a state variable.
                          decoration: textInputDecoration.copyWith(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 15),
                            prefixIcon: Container(
                              margin:
                                  const EdgeInsets.only(left: 20, right: 15),
                              child: Icon(
                                IconlyLight.activity,
                                size: width * .05,
                                color: CusColors.mainColor,
                              ),
                            ),
                            hintText: "Sudah bekerja?",
                            hintStyle: GoogleFonts.mulish(
                              color: CusColors.subHeader.withOpacity(.5),
                              fontSize: width * .032,
                            ),
                          ),
                          validator: (val) => val == null ||
                                  val.isEmpty ||
                                  val == 'Sudah bekerja?'
                              ? 'Silakan pilih status kerja'
                              : null,
                          onChanged: (val) {
                            setState(() {
                              workingStatus = val!; // Update the selected value
                            });
                          },
                          items: working.map((work) {
                            return DropdownMenuItem<String>(
                              value: work,
                              child: work == 'Sudah bekerja?'
                                  ? Text(
                                      work,
                                      style: GoogleFonts.mulish(
                                          color: CusColors.subHeader
                                              .withOpacity(.5),
                                          fontSize: width * .032),
                                    )
                                  : Text(
                                      work,
                                      style: GoogleFonts.mulish(
                                          fontSize: width * .032),
                                    ),
                            );
                          }).toList(),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
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
                        child: TextFormField(
                          obscureText: showPassword ? false : true,
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
                          validator: (val) => val!.length < 6
                              ? 'Masukkan kata sandi sepanjang 6 karakter'
                              : null,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: TextFormField(
                          autocorrect: true,
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: CusColors.subHeader),
                          decoration: textInputDecoration.copyWith(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 15),
                            prefixIcon: Container(
                              margin:
                                  const EdgeInsets.only(left: 20, right: 15),
                              child: Icon(
                                IconlyLight.document,
                                size: width * .05,
                                color: CusColors.mainColor,
                              ),
                            ),
                            hintText: "Alasan mengapa bergabung dengan pusat pendidikan",
                            hintStyle: GoogleFonts.mulish(
                              color: CusColors.subHeader.withOpacity(.5),
                              fontSize: width * .032,
                            ),
                          ),
                          validator: (val) =>
                              val!.isEmpty ? 'Masukkan alasannya' : null,
                          onChanged: (val) {
                            setState(() => reason = val);
                          },
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        padding:
                            const EdgeInsets.only(left: 5, top: 20, bottom: 15),
                        child: RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                              text: "Dengan mendaftar, Anda menyetujui kami ",
                              style: GoogleFonts.mulish(
                                color: CusColors.subHeader.withOpacity(.5),
                                fontSize: width * .026,
                              ),
                              children: <InlineSpan>[
                                TextSpan(
                                    text: "Syarat & Ketentuan ",
                                    style: GoogleFonts.mulish(
                                        color: CusColors.mainColor,
                                        fontWeight: FontWeight.w700)),
                                TextSpan(
                                  text: "dan ",
                                  style: GoogleFonts.mulish(
                                    color: CusColors.subHeader.withOpacity(.5),
                                    fontSize: width * .026,
                                  ),
                                ),
                                TextSpan(
                                    text: "Kebijakan Privasi",
                                    style: GoogleFonts.mulish(
                                        color: CusColors.mainColor,
                                        fontWeight: FontWeight.w700)),
                              ]),
                        ),
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
                                    dynamic result = await _auth
                                        .registerWithEmailAndPassword(
                                      name,
                                      noWhatsapp,
                                      address,
                                      lastEducation,
                                      workingStatus,
                                      email,
                                      password,
                                      reason,
                                    );

                                    setState(() {
                                      if (result is String) {
                                        error = result;
                                      }
                                      loading =
                                          false; // Set loading back to false
                                    });
                                    if (result is UserModel) {
                                      Get.rootDelegate.offAndToNamed(routeConfirmEmail);
                                    }
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
                                  'Melanjutkan',
                                  style: GoogleFonts.mulish(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: width * .043,
                                  ),
                                ),
                        ),
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
                              Get.back();
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
                                  "Daftar dengan Google",
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
                              text: "Bergabung dengan kami sebelumnya? ",
                              style: GoogleFonts.mulish(
                                color: CusColors.subHeader.withOpacity(.5),
                                fontSize: width * .035,
                              ),
                              children: <InlineSpan>[
                                TextSpan(
                                    text: "Login",
                                    style: GoogleFonts.mulish(
                                        color: CusColors.mainColor,
                                        fontWeight: FontWeight.w700),
                                    mouseCursor:
                                        MaterialStateMouseCursor.clickable,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => Get.back())
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
