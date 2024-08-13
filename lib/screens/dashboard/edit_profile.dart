import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/components/custom_alert.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/routes/routes.dart';
import 'package:project_tc/services/firestore_service.dart';
import 'package:responsive_builder/responsive_builder.dart';

class EditProfile extends StatefulWidget {
  final UserData userData;
  final UserModel user;
  const EditProfile({super.key, required this.userData, required this.user});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  bool isDone = false;

  // text field state
  String? name;
  String? email;
  String? password;
  String? noWhatsapp;
  String? address;
  String? lastEducation;
  List lastEducations = [
    'Select last education',
    'SMA/SMK',
    'D3',
    'S1',
  ];
  String? workingStatus;
  List working = [
    'Have been working?',
    'Yes',
    'No',
  ];
  String? reason;
  String error = '';
  Uint8List? image;
  String? downloadURL;

  selectImageFromGallery() async {
    final picker = ImagePicker();
    XFile? imageFile = await picker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      var file = await imageFile.readAsBytes();
      setState(() {
        image = file;
      });
    }
  }

  Future<String?> uploadFile(Uint8List image) async {
    String postId = DateTime.now().millisecondsSinceEpoch.toString();
    var contentType = lookupMimeType('', headerBytes: image);

    Reference ref = FirebaseStorage.instance
        .ref()
        .child("profile-pictures")
        .child("post_$postId.jpg");
    await ref.putData(image, SettableMetadata(contentType: contentType));
    downloadURL = await ref.getDownloadURL();
    return downloadURL;
  }

  uploadToFirebase(image) async {
    await uploadFile(image).then((value) {
      setState(() {});
    }); // this will upload the file and store url in the variable 'url'
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    var deviceType = getDeviceType(MediaQuery.of(context).size);
    double title = 0;
    double subHeader = 0;
    double text = 0;
    double subText = 0;

    switch (deviceType) {
      case DeviceScreenType.desktop:
        subHeader = width * .01;
        title = width * .014;
        text = width * .011;
        subText = width * .009;
        break;
      case DeviceScreenType.tablet:
        subHeader = width * .015;
        title = width * .019;
        text = width * .016;
        subText = width * .014;

        break;
      case DeviceScreenType.mobile:
        subHeader = width * .018;
        title = width * .022;
        text = width * .019;
        subText = width * .017;
        break;
      default:
        subHeader = 0;
        title = 0;
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
      child: ListView(children: [
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
                        onTap: () => Get.rootDelegate.offNamed(routeSettings),
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
                    'My Profile',
                    style: GoogleFonts.poppins(
                      fontSize: title,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1F384C),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: getValueForScreenType<double>(
                  context: context,
                  mobile: 40,
                  tablet: 55,
                  desktop: 70,
                ),
              ),
              SizedBox(
                width: getValueForScreenType<double>(
                  context: context,
                  mobile: double.infinity,
                  tablet: width / 1.5,
                  desktop: width / 1.7,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: getValueForScreenType<double>(
                            context: context,
                            mobile: 35,
                            tablet: 40,
                            desktop: 50,
                          ),
                          height: getValueForScreenType<double>(
                            context: context,
                            mobile: 35,
                            tablet: 40,
                            desktop: 50,
                          ),
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                            image: image != null
                                ? DecorationImage(
                                    image: MemoryImage(
                                      image!,
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                : DecorationImage(
                                    image: NetworkImage(
                                      widget.userData.photoUrl,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.userData.name,
                              style: GoogleFonts.poppins(
                                fontSize: text,
                                fontWeight: FontWeight.w600,
                                color: CusColors.text,
                              ),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              widget.user.email,
                              style: GoogleFonts.poppins(
                                fontSize: subText,
                                fontWeight: FontWeight.w500,
                                color: CusColors.subHeader.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () async {
                            if (!widget.userData.photoUrl.contains(
                                'https://lh3.googleusercontent.com')) {
                              await deleteExistingPhoto();
                              await FirestoreService(uid: widget.user.uid)
                                  .updateUserPhoto(
                                      'https://ui-avatars.com/api/?name=${widget.userData.name}&color=7F9CF5&background=EBF4FF');
                            }
                          },
                          child: Text(
                            'Delete Photo',
                            style: GoogleFonts.poppins(
                              fontSize: subText,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF37373E),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: getValueForScreenType<double>(
                            context: context,
                            mobile: 10,
                            tablet: 15,
                            desktop: 20,
                          ),
                        ),
                        SizedBox(
                          height: getValueForScreenType<double>(
                            context: context,
                            mobile: 26,
                            tablet: 33,
                            desktop: 40,
                          ),
                          child: ElevatedButton(
                            onPressed: selectImageFromGallery,
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                    horizontal: getValueForScreenType<double>(
                                      context: context,
                                      mobile: 15,
                                      tablet: 20,
                                      desktop: 25,
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
                              'Upload New',
                              style: GoogleFonts.poppins(
                                fontSize: subText,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(
                        vertical: getValueForScreenType<double>(
                          context: context,
                          mobile: 15,
                          tablet: 20,
                          desktop: 30,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: CusColors.bg,
                        border: const Border(
                          bottom: BorderSide(
                            width: 0.5,
                            color: Color(0xFFC8CBD9),
                          ),
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Fullname',
                            style: GoogleFonts.poppins(
                              fontSize: subText,
                              fontWeight: FontWeight.w600,
                              color: CusColors.subHeader.withOpacity(0.5),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            style: GoogleFonts.poppins(
                                fontSize: subText,
                                fontWeight: FontWeight.w500,
                                color: CusColors.subHeader),
                            initialValue: widget.userData.name,
                            onChanged: (value) {
                              name = value;
                            },
                            decoration: editProfileDecoration.copyWith(
                              hintText: 'Fullname',
                              hintStyle: GoogleFonts.poppins(
                                fontSize: subText,
                                fontWeight: FontWeight.w500,
                                color: CusColors.subHeader.withOpacity(0.5),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: 8,
                              top: getValueForScreenType<double>(
                                context: context,
                                mobile: 17,
                                tablet: 27,
                                desktop: 37,
                              ),
                            ),
                            child: Text(
                              'No. Whatsapp',
                              style: GoogleFonts.poppins(
                                fontSize: subText,
                                fontWeight: FontWeight.w600,
                                color: CusColors.subHeader.withOpacity(0.5),
                              ),
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^[0-9\-\+\s()]*$')),
                            ],
                            style: GoogleFonts.poppins(
                                fontSize: subText,
                                fontWeight: FontWeight.w500,
                                color: CusColors.subHeader),
                            initialValue: widget.userData.noWhatsapp,
                            onChanged: (value) {
                              noWhatsapp = value;
                            },
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Enter a No. Whatsapp';
                              } else if (val.length < 11 || val.length > 15) {
                                return 'Number should be between 11 and 15 characters';
                              } else if (!val.startsWith('08')) {
                                return 'Number is invalid, example 08xxxxxxxx';
                              }
                              return null;
                            },
                            decoration: editProfileDecoration.copyWith(
                              hintText: 'Input your Whatsapp number',
                              hintStyle: GoogleFonts.poppins(
                                fontSize: subText,
                                fontWeight: FontWeight.w500,
                                color: CusColors.subHeader.withOpacity(0.5),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: 8,
                              top: getValueForScreenType<double>(
                                context: context,
                                mobile: 17,
                                tablet: 27,
                                desktop: 37,
                              ),
                            ),
                            child: Text(
                              'Address',
                              style: GoogleFonts.poppins(
                                fontSize: subText,
                                fontWeight: FontWeight.w600,
                                color: CusColors.subHeader.withOpacity(0.5),
                              ),
                            ),
                          ),
                          TextFormField(
                            style: GoogleFonts.poppins(
                                fontSize: subText,
                                fontWeight: FontWeight.w500,
                                color: CusColors.subHeader),
                            initialValue: widget.userData.address,
                            onChanged: (value) {
                              address = value;
                            },
                            decoration: editProfileDecoration.copyWith(
                              hintText: 'Input your Address',
                              hintStyle: GoogleFonts.poppins(
                                fontSize: subText,
                                fontWeight: FontWeight.w500,
                                color: CusColors.subHeader.withOpacity(0.5),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: 8,
                              top: getValueForScreenType<double>(
                                context: context,
                                mobile: 17,
                                tablet: 27,
                                desktop: 37,
                              ),
                            ),
                            child: Text(
                              'Last Education',
                              style: GoogleFonts.poppins(
                                fontSize: subText,
                                fontWeight: FontWeight.w600,
                                color: CusColors.subHeader.withOpacity(0.5),
                              ),
                            ),
                          ),
                          DropdownButtonFormField<String>(
                            value: widget.userData
                                .education, // Make sure to define 'selectedValue' as a state variable.
                            icon: Icon(
                              IconlyLight.arrow_down_2,
                              size: getValueForScreenType<double>(
                                context: context,
                                mobile: 18,
                                tablet: 22,
                                desktop: 24,
                              ),
                            ),
                            decoration: editProfileDecoration.copyWith(
                                hintText: 'Last Education',
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: subText,
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
                            validator: (val) => val == null ||
                                    val.isEmpty ||
                                    val == 'Select last education'
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
                                child: education == 'Select last education'
                                    ? Text(
                                        education,
                                        style: GoogleFonts.poppins(
                                            fontSize: subText,
                                            fontWeight: FontWeight.w500,
                                            color: CusColors.subHeader
                                                .withOpacity(0.5)),
                                      )
                                    : Text(
                                        education,
                                        style: GoogleFonts.poppins(
                                            fontSize: subText,
                                            fontWeight: FontWeight.w500,
                                            color: CusColors.subHeader),
                                      ),
                              );
                            }).toList(),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: 8,
                              top: getValueForScreenType<double>(
                                context: context,
                                mobile: 17,
                                tablet: 27,
                                desktop: 37,
                              ),
                            ),
                            child: Text(
                              'Have been working?',
                              style: GoogleFonts.poppins(
                                fontSize: subText,
                                fontWeight: FontWeight.w600,
                                color: CusColors.subHeader.withOpacity(0.5),
                              ),
                            ),
                          ),
                          DropdownButtonFormField<String>(
                            value: widget.userData
                                .working, // Make sure to define 'selectedValue' as a state variable.
                            icon: Icon(
                              IconlyLight.arrow_down_2,
                              size: getValueForScreenType<double>(
                                context: context,
                                mobile: 18,
                                tablet: 22,
                                desktop: 24,
                              ),
                            ),
                            decoration: editProfileDecoration.copyWith(
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: subText,
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
                            validator: (val) => val == null ||
                                    val.isEmpty ||
                                    val == 'Have been working?'
                                ? 'Please select working status'
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
                                child: work == 'Have been working?'
                                    ? Text(
                                        work,
                                        style: GoogleFonts.poppins(
                                            fontSize: subText,
                                            fontWeight: FontWeight.w500,
                                            color: CusColors.subHeader
                                                .withOpacity(0.5)),
                                      )
                                    : Text(
                                        work,
                                        style: GoogleFonts.poppins(
                                            fontSize: subText,
                                            fontWeight: FontWeight.w500,
                                            color: CusColors.subHeader),
                                      ),
                              );
                            }).toList(),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: 8,
                              top: getValueForScreenType<double>(
                                context: context,
                                mobile: 17,
                                tablet: 27,
                                desktop: 37,
                              ),
                            ),
                            child: Text(
                              'Reason why join our education center',
                              style: GoogleFonts.poppins(
                                fontSize: subText,
                                fontWeight: FontWeight.w600,
                                color: CusColors.subHeader.withOpacity(0.5),
                              ),
                            ),
                          ),
                          TextFormField(
                            style: GoogleFonts.poppins(
                                fontSize: subText,
                                fontWeight: FontWeight.w500,
                                color: CusColors.subHeader),
                            initialValue: widget.userData.reason,
                            onChanged: (value) {
                              reason = value;
                            },
                            decoration: editProfileDecoration.copyWith(
                              hintText: 'Feel free to input your reason',
                              hintStyle: GoogleFonts.poppins(
                                fontSize: subText,
                                fontWeight: FontWeight.w500,
                                color: CusColors.subHeader.withOpacity(0.5),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: getValueForScreenType<double>(
                              context: context,
                              mobile: 20,
                              tablet: 30,
                              desktop: 40,
                            ),
                          ),
                          SizedBox(
                            height: getValueForScreenType<double>(
                              context: context,
                              mobile: 28,
                              tablet: 35,
                              desktop: 40,
                            ),
                            child: ElevatedButton(
                              onPressed: loading
                                  ? null
                                  : () async {
                                      setState(() {
                                        loading = true;
                                      });
                                      if (image != null) {
                                        await uploadToFirebase(image);
                                        await deleteExistingPhoto();
                                      }
                                      if (_formKey.currentState!.validate()) {
                                        String updatedName =
                                            name ?? widget.userData.name;
                                        String updatedPhotoUrl = downloadURL ??
                                            widget.userData.photoUrl;

                                        // // Check if the name changed and no image URL is provided
                                        // if (name != null &&
                                        //     name != widget.userData.name &&
                                        //     downloadURL == null &&
                                        //     !widget.userData.photoUrl.contains(
                                        //         'https://lh3.googleusercontent.com')) {
                                        //   // Set a default image URL here
                                        //   updatedPhotoUrl =
                                        //       'https://ui-avatars.com/api/?name=$name&color=7F9CF5&background=EBF4FF';
                                        // }
                                        await FirestoreService(
                                                uid: widget.user.uid)
                                            .updateUserData(
                                                updatedName,
                                                updatedPhotoUrl,
                                                'member',
                                                noWhatsapp ??
                                                    widget.userData.noWhatsapp,
                                                address ??
                                                    widget.userData.address,
                                                lastEducation ??
                                                    widget.userData.education,
                                                workingStatus ??
                                                    widget.userData.working,
                                                reason ??
                                                    widget.userData.reason,
                                                widget.userData.membership
                                                    .toFirestore());
                                        setState(() {
                                          image = null;
                                          loading = false;
                                        });
                                        if (context.mounted) {
                                          showDialog(
                                              context: context,
                                              builder: (_) {
                                                return CustomAlert(
                                                    onPressed: () => Get
                                                        .rootDelegate
                                                        .offNamed(
                                                            routeSettings),
                                                    title: 'Success',
                                                    message:
                                                        'Your profile has been successfully updated',
                                                    animatedIcon:
                                                        'assets/animations/check.json');
                                              });
                                        }
                                      }
                                    },
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(
                                      horizontal: getValueForScreenType<double>(
                                        context: context,
                                        mobile: 28,
                                        tablet: 40,
                                        desktop: 60,
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
                              child: loading
                                  ? const CircularProgressIndicator()
                                  : Text(
                                      'Save',
                                      style: GoogleFonts.poppins(
                                        fontSize: subHeader,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ]),
    );
  }

  Future<void> deleteExistingPhoto() async {
    // Check if the previous image URL is not the default URL and contains a specific string
    if (widget.userData.photoUrl !=
            'https://ui-avatars.com/api/?name=${widget.userData.name}&color=7F9CF5&background=EBF4FF' &&
        !widget.userData.photoUrl
            .contains('https://lh3.googleusercontent.com')) {
      try {
        // Define a regular expression to match the filename
        RegExp regExp = RegExp(r'[^\/]+(?=\?)');

        // Use the regular expression to extract the filename
        String? fileUrl = regExp.firstMatch(widget.userData.photoUrl)?.group(0);

        String fileName = fileUrl!.replaceFirst("profile-pictures%2F", "");

        // Create a reference to the previous image in Firebase Storage
        final storageRef = FirebaseStorage.instance
            .ref()
            .child("profile-pictures")
            .child(fileName);

        // Delete the previous image from Firebase Storage
        await storageRef.delete();
      } catch (e) {
        print('Error deleting previous image: $e');
      }
    } else {
      print('default google');
    }
  }
}
