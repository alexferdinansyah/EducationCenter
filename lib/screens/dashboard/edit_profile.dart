import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/services/firestore_service.dart';

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
    return Container(
      width: width * .83,
      height: height - 60,
      color: CusColors.bg,
      child: ListView(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Profile',
                style: GoogleFonts.poppins(
                  fontSize: width * .014,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1F384C),
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              SizedBox(
                width: width / 1.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
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
                                fontSize: width * .011,
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
                                fontSize: width * .009,
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
                                  .updateUserData(
                                      widget.userData.name,
                                      'https://ui-avatars.com/api/?name=${widget.userData.name}&color=7F9CF5&background=EBF4FF', // Set this to the new image URL
                                      widget.userData.role,
                                      widget.userData.noWhatsapp,
                                      widget.userData.address,
                                      widget.userData.education,
                                      widget.userData.working,
                                      widget.userData.reason,
                                      widget.userData.membership
                                          .toFirestoreMap());
                            }
                          },
                          child: Text(
                            'Delete Photo',
                            style: GoogleFonts.poppins(
                              fontSize: width * .009,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF37373E),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                          onPressed: selectImageFromGallery,
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 18),
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
                              fontSize: width * .009,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 30),
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
                              fontSize: width * .009,
                              fontWeight: FontWeight.w600,
                              color: CusColors.subHeader.withOpacity(0.5),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            style: GoogleFonts.poppins(
                                fontSize: width * .009,
                                fontWeight: FontWeight.w500,
                                color: CusColors.subHeader),
                            initialValue: widget.userData.name,
                            onChanged: (value) {
                              name = value;
                            },
                            decoration: editProfileDecoration.copyWith(
                              hintText: 'Fullname',
                              hintStyle: GoogleFonts.poppins(
                                fontSize: width * .009,
                                fontWeight: FontWeight.w500,
                                color: CusColors.subHeader.withOpacity(0.5),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8, top: 37),
                            child: Text(
                              'No. Whatsapp',
                              style: GoogleFonts.poppins(
                                fontSize: width * .009,
                                fontWeight: FontWeight.w600,
                                color: CusColors.subHeader.withOpacity(0.5),
                              ),
                            ),
                          ),
                          TextFormField(
                            style: GoogleFonts.poppins(
                                fontSize: width * .009,
                                fontWeight: FontWeight.w500,
                                color: CusColors.subHeader),
                            initialValue: widget.userData.noWhatsapp,
                            onChanged: (value) {
                              noWhatsapp = value;
                            },
                            decoration: editProfileDecoration.copyWith(
                              hintText: 'Input your Whatsapp number',
                              hintStyle: GoogleFonts.poppins(
                                fontSize: width * .009,
                                fontWeight: FontWeight.w500,
                                color: CusColors.subHeader.withOpacity(0.5),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8, top: 37),
                            child: Text(
                              'Address',
                              style: GoogleFonts.poppins(
                                fontSize: width * .009,
                                fontWeight: FontWeight.w600,
                                color: CusColors.subHeader.withOpacity(0.5),
                              ),
                            ),
                          ),
                          TextFormField(
                            style: GoogleFonts.poppins(
                                fontSize: width * .009,
                                fontWeight: FontWeight.w500,
                                color: CusColors.subHeader),
                            initialValue: widget.userData.address,
                            onChanged: (value) {
                              address = value;
                            },
                            decoration: editProfileDecoration.copyWith(
                              hintText: 'Input your Address',
                              hintStyle: GoogleFonts.poppins(
                                fontSize: width * .009,
                                fontWeight: FontWeight.w500,
                                color: CusColors.subHeader.withOpacity(0.5),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8, top: 37),
                            child: Text(
                              'Last Education',
                              style: GoogleFonts.poppins(
                                fontSize: width * .009,
                                fontWeight: FontWeight.w600,
                                color: CusColors.subHeader.withOpacity(0.5),
                              ),
                            ),
                          ),
                          DropdownButtonFormField<String>(
                            value: widget.userData
                                .education, // Make sure to define 'selectedValue' as a state variable.
                            icon: const Icon(IconlyLight.arrow_down_2),
                            decoration: editProfileDecoration.copyWith(
                              hintText: 'Last Education',
                              hintStyle: GoogleFonts.poppins(
                                fontSize: width * .009,
                                fontWeight: FontWeight.w500,
                                color: CusColors.subHeader.withOpacity(0.5),
                              ),
                            ),
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
                                            fontSize: width * .009,
                                            fontWeight: FontWeight.w500,
                                            color: CusColors.subHeader
                                                .withOpacity(0.5)),
                                      )
                                    : Text(
                                        education,
                                        style: GoogleFonts.poppins(
                                            fontSize: width * .009,
                                            fontWeight: FontWeight.w500,
                                            color: CusColors.subHeader),
                                      ),
                              );
                            }).toList(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8, top: 37),
                            child: Text(
                              'Have been working?',
                              style: GoogleFonts.poppins(
                                fontSize: width * .009,
                                fontWeight: FontWeight.w600,
                                color: CusColors.subHeader.withOpacity(0.5),
                              ),
                            ),
                          ),
                          DropdownButtonFormField<String>(
                            value: widget.userData
                                .working, // Make sure to define 'selectedValue' as a state variable.
                            decoration: editProfileDecoration.copyWith(
                              hintText: 'Have been working?',
                              hintStyle: GoogleFonts.poppins(
                                fontSize: width * .009,
                                fontWeight: FontWeight.w500,
                                color: CusColors.subHeader.withOpacity(0.5),
                              ),
                              // suffixIcon:
                              //     const Icon(IconlyLight.arrow_down_2),
                            ),
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
                                            fontSize: width * .009,
                                            fontWeight: FontWeight.w500,
                                            color: CusColors.subHeader
                                                .withOpacity(0.5)),
                                      )
                                    : Text(
                                        work,
                                        style: GoogleFonts.poppins(
                                            fontSize: width * .009,
                                            fontWeight: FontWeight.w500,
                                            color: CusColors.subHeader),
                                      ),
                              );
                            }).toList(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8, top: 37),
                            child: Text(
                              'Reason why join our education center',
                              style: GoogleFonts.poppins(
                                fontSize: width * .009,
                                fontWeight: FontWeight.w600,
                                color: CusColors.subHeader.withOpacity(0.5),
                              ),
                            ),
                          ),
                          TextFormField(
                            style: GoogleFonts.poppins(
                                fontSize: width * .009,
                                fontWeight: FontWeight.w500,
                                color: CusColors.subHeader),
                            initialValue: widget.userData.reason,
                            onChanged: (value) {
                              reason = value;
                            },
                            decoration: editProfileDecoration.copyWith(
                              hintText: 'Feel free to input your reason',
                              hintStyle: GoogleFonts.poppins(
                                fontSize: width * .009,
                                fontWeight: FontWeight.w500,
                                color: CusColors.subHeader.withOpacity(0.5),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (image != null) {
                                await uploadToFirebase(image);
                                await deleteExistingPhoto();
                              }
                              if (_formKey.currentState!.validate()) {
                                String updatedName =
                                    name ?? widget.userData.name;
                                String updatedPhotoUrl =
                                    downloadURL ?? widget.userData.photoUrl;

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
                                await FirestoreService(uid: widget.user.uid)
                                    .updateUserData(
                                        updatedName,
                                        updatedPhotoUrl,
                                        'member',
                                        noWhatsapp ??
                                            widget.userData.noWhatsapp,
                                        address ?? widget.userData.address,
                                        lastEducation ??
                                            widget.userData.education,
                                        workingStatus ??
                                            widget.userData.working,
                                        reason ?? widget.userData.reason,
                                        widget.userData.membership
                                            .toFirestoreMap());
                                setState(() {
                                  image = null;
                                });
                              }
                            },
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                      horizontal: 60, vertical: 22),
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
                              'Save',
                              style: GoogleFonts.poppins(
                                fontSize: width * .01,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
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
