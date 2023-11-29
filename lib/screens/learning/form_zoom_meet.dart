import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/models/course.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/services/extension.dart';
import 'package:project_tc/services/firestore_service.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class FormZoomMeeting extends StatefulWidget {
  final String noWhatsapp;
  final String id;
  final String courseName;
  const FormZoomMeeting(
      {super.key,
      required this.noWhatsapp,
      required this.id,
      required this.courseName});

  @override
  State<FormZoomMeeting> createState() => _FormZoomMeetingState();
}

class _FormZoomMeetingState extends State<FormZoomMeeting> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  DateTime today = DateTime.now();
  DateTime? nextMonday;
  DateTime? selectedDate;
  String? noWhatsapp;
  String? note;
  @override
  void initState() {
    nextMonday = today.add(Duration(days: DateTime.monday - today.weekday + 7));

    if (selectedDate != null) {
      dateController.text = selectedDate!.formatDateAndTime();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          color: CusColors.bgSideBar,
          borderRadius: BorderRadius.circular(10)),
      child: Form(
        key: _formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Form for request zoom meeting to instructor',
                style: GoogleFonts.poppins(
                  fontSize: getValueForScreenType<double>(
                    context: context,
                    mobile: width * .019,
                    tablet: width * .016,
                    desktop: width * .011,
                  ),
                  fontWeight: FontWeight.w600,
                  color: CusColors.title,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'No Whatsapp',
            style: GoogleFonts.poppins(
              fontSize: getValueForScreenType<double>(
                context: context,
                mobile: width * .017,
                tablet: width * .014,
                desktop: width * .009,
              ),
              fontWeight: FontWeight.w600,
              color: CusColors.subHeader.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 4),
          TextFormField(
            keyboardType: TextInputType.phone,
            initialValue: widget.noWhatsapp,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^[0-9\-\+\s()]*$')),
            ],
            style: GoogleFonts.poppins(
                fontSize: getValueForScreenType<double>(
                  context: context,
                  mobile: width * .017,
                  tablet: width * .014,
                  desktop: width * .009,
                ),
                fontWeight: FontWeight.w500,
                color: CusColors.subHeader),
            onChanged: (value) {
              noWhatsapp = value;
            },
            decoration: editProfileDecoration.copyWith(
                hintText: 'No Whatsapp',
                hintStyle: GoogleFonts.poppins(
                  fontSize: getValueForScreenType<double>(
                    context: context,
                    mobile: width * .017,
                    tablet: width * .014,
                    desktop: width * .009,
                  ),
                  fontWeight: FontWeight.w500,
                  color: CusColors.subHeader.withOpacity(0.5),
                ),
                contentPadding: EdgeInsets.symmetric(
                    vertical: getValueForScreenType<double>(
                      context: context,
                      mobile: 10,
                      tablet: 14,
                      desktop: 16,
                    ),
                    horizontal: 15)),
          ),
          const SizedBox(height: 6),
          Text(
            'Date and Time',
            style: GoogleFonts.poppins(
              fontSize: getValueForScreenType<double>(
                context: context,
                mobile: width * .017,
                tablet: width * .014,
                desktop: width * .009,
              ),
              fontWeight: FontWeight.w600,
              color: CusColors.subHeader.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: () async {
              selectedDate = await showOmniDateTimePicker(
                context: context,
                initialDate: nextMonday,
                firstDate: nextMonday,
                lastDate: DateTime.now().add(
                  const Duration(days: 3652),
                ),
                is24HourMode: false,
                isShowSeconds: false,
                minutesInterval: 1,
                secondsInterval: 1,
                isForce2Digits: true,
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                constraints: const BoxConstraints(
                  maxWidth: 350,
                  maxHeight: 650,
                ),
                transitionBuilder: (context, anim1, anim2, child) {
                  return FadeTransition(
                    opacity: anim1.drive(
                      Tween(
                        begin: 0,
                        end: 1,
                      ),
                    ),
                    child: child,
                  );
                },
                transitionDuration: const Duration(milliseconds: 200),
                barrierDismissible: true,
                selectableDayPredicate: (dateTime) {
                  return dateTime.weekday != DateTime.saturday &&
                      dateTime.weekday != DateTime.sunday;
                },
              ).then((value) {
                setState(() {
                  selectedDate = value;
                  dateController.text = selectedDate?.formatDateAndTime() ?? '';
                });
                return value;
              });
            },
            child: TextFormField(
              enabled: false,
              controller: dateController,
              keyboardType: TextInputType.text,
              style: GoogleFonts.poppins(
                  fontSize: getValueForScreenType<double>(
                    context: context,
                    mobile: width * .017,
                    tablet: width * .014,
                    desktop: width * .009,
                  ),
                  fontWeight: FontWeight.w500,
                  color: CusColors.subHeader),
              decoration: editProfileDecoration.copyWith(
                  hintText: 'Select date',
                  hintStyle: GoogleFonts.poppins(
                    fontSize: getValueForScreenType<double>(
                      context: context,
                      mobile: width * .017,
                      tablet: width * .014,
                      desktop: width * .009,
                    ),
                    fontWeight: FontWeight.w500,
                    color: CusColors.subHeader.withOpacity(0.5),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: getValueForScreenType<double>(
                        context: context,
                        mobile: 10,
                        tablet: 14,
                        desktop: 16,
                      ),
                      horizontal: 15)),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Note',
            style: GoogleFonts.poppins(
              fontSize: getValueForScreenType<double>(
                context: context,
                mobile: width * .017,
                tablet: width * .014,
                desktop: width * .009,
              ),
              fontWeight: FontWeight.w600,
              color: CusColors.subHeader.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 4),
          TextFormField(
            keyboardType: TextInputType.text,
            style: GoogleFonts.poppins(
                fontSize: getValueForScreenType<double>(
                  context: context,
                  mobile: width * .017,
                  tablet: width * .014,
                  desktop: width * .009,
                ),
                fontWeight: FontWeight.w500,
                color: CusColors.subHeader),
            onChanged: (value) {
              note = value;
            },
            decoration: editProfileDecoration.copyWith(
                hintText: 'Note (Opsional)',
                hintStyle: GoogleFonts.poppins(
                  fontSize: getValueForScreenType<double>(
                    context: context,
                    mobile: width * .017,
                    tablet: width * .014,
                    desktop: width * .009,
                  ),
                  fontWeight: FontWeight.w500,
                  color: CusColors.subHeader.withOpacity(0.5),
                ),
                contentPadding: EdgeInsets.symmetric(
                    vertical: getValueForScreenType<double>(
                      context: context,
                      mobile: 10,
                      tablet: 14,
                      desktop: 16,
                    ),
                    horizontal: 15)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Container(
              height: getValueForScreenType<double>(
                context: context,
                mobile: 28,
                tablet: 35,
                desktop: 40,
              ),
              decoration: BoxDecoration(
                  color: CusColors.accentBlue,
                  borderRadius: BorderRadius.circular(80),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(.25),
                        spreadRadius: 0,
                        blurRadius: 20,
                        offset: const Offset(0, 4))
                  ]),
              child: ElevatedButton(
                onPressed: () async {
                  final firestoreService = FirestoreService(uid: user!.uid);
                  final scheduleData = MeetModel(
                      noWhatsapp: noWhatsapp,
                      uid: user.uid,
                      courseId: widget.id,
                      dateAndTime: selectedDate,
                      note: note ?? '');
                  await firestoreService
                      .addMeetRequest(scheduleData, widget.id, user.uid)
                      .then((value) async {
                    if (value == true) {
                      await firestoreService.openWhatsapp(
                          selectedDate!, note ?? '', widget.courseName);
                    } else {
                      Get.snackbar('Cannot make schedule',
                          'Already make schedule 5 times');
                    }
                  });
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(
                      horizontal: width * 0.015,
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                  shadowColor: MaterialStateProperty.all(Colors.transparent),
                ),
                child: Text(
                  'Confirm',
                  style: GoogleFonts.mulish(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: getValueForScreenType<double>(
                      context: context,
                      mobile: width * .018,
                      tablet: width * .015,
                      desktop: width * .01,
                    ),
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
