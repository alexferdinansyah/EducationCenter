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
import 'package:responsive_builder/responsive_builder.dart';

class RegisterWebsite extends StatefulWidget {
  const RegisterWebsite({super.key});

  @override
  State<RegisterWebsite> createState() => _RegisterWebsiteState();
}

class _RegisterWebsiteState extends State<RegisterWebsite> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String name = '';
  String email = '';
  String password = '';
  String noWhatsapp = '';
  String address = '';
  String lastEducation = 'Pilih pendidikan terakhir';
  List lastEducations = [
    'Pilih pendidikan terakhir',
    'SMA/SMK',
    'D3',
    'S1',
  ];
  String workingStatus = 'Sudah bekerja??';
  List working = [
    'Sudah bekerja??',
    'Ya',
    'Tidak',
  ];
  String reason = '';
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
                    'Selamat datang!',
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
                            tablet: 45,
                            desktop: height * .06,
                          ),
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: getValueForScreenType<double>(
                                  context: context,
                                  mobile: width * .019,
                                  tablet: width / 2.5,
                                  desktop: width / 3.5,
                                ),
                                child: TextFormField(
                                  autocorrect: true,
                                  keyboardType: TextInputType.text,
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
                                        IconlyLight.profile,
                                        size: width * .02,
                                        color: CusColors.mainColor,
                                      ),
                                    ),
                                    hintText: "Nama lengkap",
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
                                  validator: (val) =>
                                      val!.isEmpty ? 'Masukkan nama' : null,
                                  onChanged: (val) {
                                    setState(() => name = val);
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
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^[0-9\-\+\s()]*$')),
                                  ],
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
                                        IconlyLight.call,
                                        size: width * .02,
                                        color: CusColors.mainColor,
                                      ),
                                    ),
                                    hintText: "No. Whatsapp",
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
                                      return 'Masukkan No. Whatsapp';
                                    } else if (val.length < 11 ||
                                        val.length > 15) {
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
                                  keyboardType: TextInputType.text,
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
                                        IconlyLight.location,
                                        size: width * .02,
                                        color: CusColors.mainColor,
                                      ),
                                    ),
                                    hintText: "Alamat",
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
                                  validator: (val) =>
                                      val!.isEmpty ? 'Masukkan alamat' : null,
                                  onChanged: (val) {
                                    setState(() => address = val);
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
                                child: DropdownButtonFormField<String>(
                                  value:
                                      lastEducation, // Make sure to define 'selectedValue' as a state variable.
                                  decoration: textInputDecoration.copyWith(
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                      vertical: width * .015,
                                    ),
                                    prefixIcon: Container(
                                      margin: const EdgeInsets.only(
                                          left: 20, right: 15),
                                      child: Icon(
                                        IconlyLight.work,
                                        size: width * .02,
                                        color: CusColors.mainColor,
                                      ),
                                    ),
                                    hintText: "Pendidikan terakhir",
                                    hintStyle: GoogleFonts.mulish(
                                      color:
                                          CusColors.subHeader.withOpacity(.5),
                                      fontSize: width * .009,
                                    ),
                                  ),
                                  validator: (val) => val == null ||
                                          val.isEmpty ||
                                          val == 'Pilih pendidikan terakhir'
                                      ? 'Please select a education'
                                      : null,
                                  onChanged: (val) {
                                    setState(() {
                                      lastEducation =
                                          val!; // Update the selected value
                                    });
                                  },
                                  items: lastEducations.map((education) {
                                    return DropdownMenuItem<String>(
                                      value: education,
                                      child: education ==
                                              'Pilih pendidikan terakhir'
                                          ? Text(
                                              education,
                                              style: GoogleFonts.mulish(
                                                color: CusColors.subHeader
                                                    .withOpacity(.5),
                                                fontSize: getValueForScreenType<
                                                    double>(
                                                  context: context,
                                                  mobile: width * .019,
                                                  tablet: width * .014,
                                                  desktop: width * .009,
                                                ),
                                              ),
                                            )
                                          : Text(
                                              education,
                                              style: GoogleFonts.mulish(
                                                fontSize: getValueForScreenType<
                                                    double>(
                                                  context: context,
                                                  mobile: width * .019,
                                                  tablet: width * .014,
                                                  desktop: width * .009,
                                                ),
                                              ),
                                            ),
                                    );
                                  }).toList(),
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
                                child: DropdownButtonFormField<String>(
                                  value:
                                      workingStatus, // Make sure to define 'selectedValue' as a state variable.
                                  decoration: textInputDecoration.copyWith(
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                      vertical: width * .015,
                                    ),
                                    prefixIcon: Container(
                                      margin: const EdgeInsets.only(
                                          left: 20, right: 15),
                                      child: Icon(
                                        IconlyLight.activity,
                                        size: width * .02,
                                        color: CusColors.mainColor,
                                      ),
                                    ),
                                    hintText: "Sudah bekerja??",
                                    hintStyle: GoogleFonts.mulish(
                                      color:
                                          CusColors.subHeader.withOpacity(.5),
                                      fontSize: width * .009,
                                    ),
                                  ),
                                  validator: (val) => val == null ||
                                          val.isEmpty ||
                                          val == 'Sudah bekerja??'
                                      ? 'Silakan pilih status kerja'
                                      : null,
                                  onChanged: (val) {
                                    setState(() {
                                      workingStatus =
                                          val!; // Update the selected value
                                    });
                                  },
                                  items: working.map((work) {
                                    return DropdownMenuItem<String>(
                                      value: work,
                                      child: work == 'Sudah bekerja??'
                                          ? Text(
                                              work,
                                              style: GoogleFonts.mulish(
                                                color: CusColors.subHeader
                                                    .withOpacity(.5),
                                                fontSize: getValueForScreenType<
                                                    double>(
                                                  context: context,
                                                  mobile: width * .019,
                                                  tablet: width * .014,
                                                  desktop: width * .009,
                                                ),
                                              ),
                                            )
                                          : Text(
                                              work,
                                              style: GoogleFonts.mulish(
                                                fontSize: getValueForScreenType<
                                                    double>(
                                                  context: context,
                                                  mobile: width * .019,
                                                  tablet: width * .014,
                                                  desktop: width * .009,
                                                ),
                                              ),
                                            ),
                                    );
                                  }).toList(),
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
                                          size: getValueForScreenType<double>(
                                            context: context,
                                            mobile: width * .022,
                                            tablet: width * .02,
                                            desktop: width * .015,
                                          ),
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
                                  keyboardType: TextInputType.text,
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
                                        IconlyLight.document,
                                        size: width * .02,
                                        color: CusColors.mainColor,
                                      ),
                                    ),
                                    hintText:
                                        "Alasan mengapa bergabung dengan pusat pendidikan",
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
                                  validator: (val) =>
                                      val!.isEmpty ? 'Masukkan alasannya' : null,
                                  onChanged: (val) {
                                    setState(() => reason = val);
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
                                                .registerWithEmailAndPassword(
                                              name,
                                              noWhatsapp,
                                              address,
                                              lastEducation,
                                              workingStatus,
                                              email,
                                              password,
                                              value,
                                            );

                                            setState(() {
                                              if (result is String) {
                                                error = result;
                                              }
                                              loading =
                                                  false; // Set loading back to false
                                            });
                                            if (result is UserModel) {
                                              Get.offAndToNamed(
                                                  routeConfirmEmail);
                                            }
                                          }
                                        },
                                ),
                              ),
                              Container(
                                width: getValueForScreenType<double>(
                                  context: context,
                                  mobile: width * .019,
                                  tablet: width / 2.5,
                                  desktop: width / 3.5,
                                ),
                                margin: EdgeInsets.only(bottom: height * .01),
                                alignment: Alignment.center,
                                child: Text(
                                  error,
                                  style: GoogleFonts.mulish(
                                      fontSize: width * .01,
                                      color: Colors.red.withOpacity(0.7)),
                                ),
                              ),
                              Container(
                                width: getValueForScreenType<double>(
                                  context: context,
                                  mobile: width * .019,
                                  tablet: width / 2.5,
                                  desktop: width / 3.5,
                                ),
                                alignment: Alignment.centerLeft,
                                padding:
                                    const EdgeInsets.only(left: 5, bottom: 15),
                                child: RichText(
                                  textAlign: TextAlign.left,
                                  text: TextSpan(
                                      text:
                                          "Dengan mendaftar, Anda menyetujui kami ",
                                      style: GoogleFonts.mulish(
                                        color:
                                            CusColors.subHeader.withOpacity(.5),
                                        fontSize: getValueForScreenType<double>(
                                          context: context,
                                          mobile: width * .018,
                                          tablet: width * .013,
                                          desktop: width * .008,
                                        ),
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
                                            color: CusColors.subHeader
                                                .withOpacity(.5),
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
                                          color: Colors.black.withOpacity(.25),
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
                                              Get.offAndToNamed(
                                                  routeConfirmEmail);
                                            }
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
                                          'Melanjutkan',
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
                                height: height * .035,
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
                                      backgroundColor: MaterialStatePropertyAll(
                                          onHover
                                              ? Colors.grey.shade100
                                              : Colors.white),
                                      shadowColor:
                                          const MaterialStatePropertyAll(
                                              Colors.transparent),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SvgPicture.asset(
                                          "assets/svg/google.svg",
                                          width: width * .015,
                                        ),
                                        const SizedBox(
                                          width: 14,
                                        ),
                                        Text(
                                          "Daftar dengan Google",
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
                                      text: "Bergabung dengan kami sebelumnya? ",
                                      style: GoogleFonts.mulish(
                                        color:
                                            CusColors.subHeader.withOpacity(.5),
                                        fontSize: getValueForScreenType<double>(
                                          context: context,
                                          mobile: width * .018,
                                          tablet: width * .015,
                                          desktop: width * .01,
                                        ),
                                      ),
                                      children: <InlineSpan>[
                                        TextSpan(
                                            text: "Login",
                                            style: GoogleFonts.mulish(
                                                color: CusColors.mainColor,
                                                fontWeight: FontWeight.w700),
                                            mouseCursor:
                                                MaterialStateMouseCursor
                                                    .clickable,
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () => Get.back())
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      SvgPicture.asset(
                        'assets/svg/sign_up.svg',
                        height: width * .3,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
