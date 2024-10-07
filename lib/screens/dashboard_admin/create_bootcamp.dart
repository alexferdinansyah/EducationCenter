import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/controllers/detail_controller.dart';
import 'package:project_tc/models/bootcamp.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/routes/routes.dart';
import 'package:project_tc/screens/dashboard_admin/dashboard_admin.dart';
import 'package:project_tc/services/extension.dart';
import 'package:project_tc/services/firestore_service.dart';
import 'package:project_tc/services/function.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CreateBootcamp extends StatefulWidget {
  final Bootcamp? bootcamp;
  final String? bootcampId;
  const CreateBootcamp({super.key, this.bootcamp, this.bootcampId});

  @override
  State<CreateBootcamp> createState() => _CreateBootcampState();
}

class _CreateBootcampState extends State<CreateBootcamp> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _dateController = TextEditingController();

  String imageUrl = '';
  bool showSave = true;
  bool loading = false;
  bool initBootcamp = false;

  Uint8List? image;
  String? downloadURL;
  DateTime? date;
  String? title;
  String? description;
  String? category;
  String? time;
  String? place;
  String? speaker;
  String? link;

  List bootcampCatagories = ['Online Bootcamp', 'Offline Bootcamp'];

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2024, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        date = picked;
        _dateController.text = date?.formatDate() ?? '';
      });
    }
  }

  selectImageFromGallery() async {
    final picker = ImagePicker();
    XFile? imageFile = await picker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      var file = await imageFile.readAsBytes();
      setState(() {
        image = file;
        // showSave = true;
      });
    }
  }

  Future<String?> uploadFile(Uint8List image) async {
    String postId = DateTime.now().millisecondsSinceEpoch.toString();
    var contentType = lookupMimeType('', headerBytes: image);

    Reference ref = FirebaseStorage.instance
        .ref()
        .child("bootcamp")
        .child("post_$postId.jpg");
    await ref.putData(image, SettableMetadata(contentType: contentType));
    downloadURL = await ref.getDownloadURL();
    return downloadURL;
  }

  uploadToFirebase(image) async {
    await uploadFile(image).then((value) {
      setState(() {
        showSave = false;
      });
    }); // this will upload the file and store url in the variable 'url'
  }

  Future<void> deleteExistingPhoto() async {
    if (imageUrl != '' || downloadURL != null) {
      try {
        // Define a regular expression to match the filename
        RegExp regExp = RegExp(r'[^\/]+(?=\?)');

        // Use the regular expression to extract the filename
        String? fileUrl = regExp.firstMatch(downloadURL ?? imageUrl)?.group(0);

        String fileName = fileUrl!.replaceFirst("bootcamp%2f", "");

        // Create a reference to the previous image in Firebase Storage
        final storageRef =
            FirebaseStorage.instance.ref().child("bootcamp").child(fileName);

        // Delete the previous image from Firebase Storage
        await storageRef.delete();
      } catch (e) {
        print('Error deleting previous image: $e');
      }
    }
  }

  final DetailBootcampController controller = Get.put(DetailBootcampController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final user = Provider.of<UserModel?>(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(
          getValueForScreenType<double>(
            context: context,
            mobile: 15,
            tablet: 15,
            desktop: 40,
          ),
          getValueForScreenType<double>(
            context: context,
            mobile: 15,
            tablet: 15,
            desktop: 40,
          ),
          getValueForScreenType<double>(
            context: context,
            mobile: 15,
            tablet: 15,
            desktop: 40,
          ),
          10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: GestureDetector(
                    onTap: () => Get.rootDelegate.offNamed(routeBootcamp),
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
              const Text('Create Bootcamp',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            width: width * 0.7,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
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
                      'Upload Image',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  //title
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      'Title',
                      style: GoogleFonts.poppins(
                        fontSize: width * .009,
                        fontWeight: FontWeight.w600,
                        color: CusColors.subHeader.withOpacity(0.5),
                      ),
                    ),
                  ),
                  TextFormField(
                    initialValue:
                        widget.bootcampId != null ? widget.bootcamp?.title : '',
                    style: GoogleFonts.poppins(
                      fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .018,
                        tablet: width * .015,
                        desktop: width * .009,
                      ),
                      fontWeight: FontWeight.w500,
                      color: CusColors.text,
                    ),
                    keyboardType: TextInputType.text,
                    decoration: editProfileDecoration.copyWith(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: getValueForScreenType<double>(
                            context: context,
                            mobile: 13,
                            tablet: 15,
                            desktop: 16,
                          ),
                          horizontal: 18),
                      hintText: 'Enter an title',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: getValueForScreenType<double>(
                          context: context,
                          mobile: width * .018,
                          tablet: width * .015,
                          desktop: width * .009,
                        ),
                        fontWeight: FontWeight.w500,
                        color: CusColors.secondaryText,
                      ),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Enter an title';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      title = val;
                    },
                  ),
                  //catagory
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8, top: 15),
                    child: Text(
                      'Category',
                      style: GoogleFonts.poppins(
                        fontSize: width * .009,
                        fontWeight: FontWeight.w600,
                        color: CusColors.subHeader.withOpacity(0.5),
                      ),
                    ),
                  ),
                  DropdownButtonFormField<String>(
                    value: widget.bootcampId != null
                        ? widget.bootcamp!.category
                        : null,
                    icon: const Icon(IconlyLight.arrow_down_2),
                    decoration: editProfileDecoration.copyWith(
                      hintText: 'Bootcamp Category',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: width * .009,
                        fontWeight: FontWeight.w500,
                        color: CusColors.subHeader.withOpacity(0.5),
                      ),
                    ),
                    validator: (val) => val == null ||
                            val.isEmpty ||
                            val == 'Select last Bootcamp category'
                        ? 'Please select a bootcamp category'
                        : null,
                    onChanged: (val) {
                      setState(() {
                        category = val!; // Update the selected value
                      });
                    },
                    items: bootcampCatagories.map((category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(
                          category,
                          style: GoogleFonts.poppins(
                            fontSize: width * .009,
                            fontWeight: FontWeight.w500,
                            color: CusColors.text,
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  //date
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8, top: 15),
                    child: Text(
                      'Date',
                      style: GoogleFonts.poppins(
                        fontSize: width * .009,
                        fontWeight: FontWeight.w600,
                        color: CusColors.subHeader.withOpacity(0.5),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: TextFormField(
                      controller: _dateController,
                      enabled: false,
                      style: GoogleFonts.poppins(
                        fontSize: getValueForScreenType<double>(
                          context: context,
                          mobile: width * .018,
                          tablet: width * .015,
                          desktop: width * .009,
                        ),
                        fontWeight: FontWeight.w500,
                        color: CusColors.text,
                      ),
                      keyboardType: TextInputType.text,
                      decoration: editProfileDecoration.copyWith(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: getValueForScreenType<double>(
                              context: context,
                              mobile: 13,
                              tablet: 15,
                              desktop: 16,
                            ),
                            horizontal: 18),
                        hintText: 'Select date',
                        hintStyle: GoogleFonts.poppins(
                          fontSize: getValueForScreenType<double>(
                            context: context,
                            mobile: width * .018,
                            tablet: width * .015,
                            desktop: width * .009,
                          ),
                          fontWeight: FontWeight.w500,
                          color: CusColors.secondaryText,
                        ),
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Enter an date';
                        }
                        return null;
                      },
                    ),
                  ),
                  //time
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8, top: 15),
                    child: Text(
                      'time',
                      style: GoogleFonts.poppins(
                        fontSize: width * .009,
                        fontWeight: FontWeight.w600,
                        color: CusColors.subHeader.withOpacity(0.5),
                      ),
                    ),
                  ),
                  TextFormField(
                    initialValue:
                        widget.bootcampId != null ? widget.bootcamp!.time : '',
                    style: GoogleFonts.poppins(
                      fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .018,
                        tablet: width * .015,
                        desktop: width * .009,
                      ),
                      fontWeight: FontWeight.w500,
                      color: CusColors.text,
                    ),
                    keyboardType: TextInputType.text,
                    decoration: editProfileDecoration.copyWith(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: getValueForScreenType<double>(
                            context: context,
                            mobile: 13,
                            tablet: 15,
                            desktop: 16,
                          ),
                          horizontal: 18),
                      hintText: 'Enter an time',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: getValueForScreenType<double>(
                          context: context,
                          mobile: width * .018,
                          tablet: width * .015,
                          desktop: width * .009,
                        ),
                        fontWeight: FontWeight.w500,
                        color: CusColors.secondaryText,
                      ),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Enter an time';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      time = val;
                    },
                  ),
                  //place
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8, top: 15),
                    child: Text(
                      'place',
                      style: GoogleFonts.poppins(
                        fontSize: width * .009,
                        fontWeight: FontWeight.w600,
                        color: CusColors.subHeader.withOpacity(0.5),
                      ),
                    ),
                  ),
                  TextFormField(
                    initialValue:
                        widget.bootcampId != null ? widget.bootcamp!.place : '',
                    style: GoogleFonts.poppins(
                      fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .018,
                        tablet: width * .015,
                        desktop: width * .009,
                      ),
                      fontWeight: FontWeight.w500,
                      color: CusColors.text,
                    ),
                    keyboardType: TextInputType.text,
                    decoration: editProfileDecoration.copyWith(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: getValueForScreenType<double>(
                            context: context,
                            mobile: 13,
                            tablet: 15,
                            desktop: 16,
                          ),
                          horizontal: 18),
                      hintText: 'Enter an place',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: getValueForScreenType<double>(
                          context: context,
                          mobile: width * .018,
                          tablet: width * .015,
                          desktop: width * .009,
                        ),
                        fontWeight: FontWeight.w500,
                        color: CusColors.secondaryText,
                      ),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Enter an place';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      place = val;
                    },
                  ),
                  //speaker
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8, top: 15),
                    child: Text(
                      'speaker',
                      style: GoogleFonts.poppins(
                        fontSize: width * .009,
                        fontWeight: FontWeight.w600,
                        color: CusColors.subHeader.withOpacity(0.5),
                      ),
                    ),
                  ),
                  TextFormField(
                    initialValue: widget.bootcampId != null
                        ? widget.bootcamp!.speaker
                        : '',
                    style: GoogleFonts.poppins(
                      fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .018,
                        tablet: width * .015,
                        desktop: width * .009,
                      ),
                      fontWeight: FontWeight.w500,
                      color: CusColors.text,
                    ),
                    keyboardType: TextInputType.text,
                    decoration: editProfileDecoration.copyWith(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: getValueForScreenType<double>(
                            context: context,
                            mobile: 13,
                            tablet: 15,
                            desktop: 16,
                          ),
                          horizontal: 18),
                      hintText: 'Enter an speaker',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: getValueForScreenType<double>(
                          context: context,
                          mobile: width * .018,
                          tablet: width * .015,
                          desktop: width * .009,
                        ),
                        fontWeight: FontWeight.w500,
                        color: CusColors.secondaryText,
                      ),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Enter an speaker';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      speaker = val;
                    },
                  ),

                  //link
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8, top: 15),
                    child: Text(
                      'Link',
                      style: GoogleFonts.poppins(
                        fontSize: width * .009,
                        fontWeight: FontWeight.w600,
                        color: CusColors.subHeader.withOpacity(0.5),
                      ),
                    ),
                  ),
                  TextFormField(
                    initialValue:
                        widget.bootcampId != null ? widget.bootcamp!.link : '',
                    style: GoogleFonts.poppins(
                      fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .018,
                        tablet: width * .015,
                        desktop: width * .009,
                      ),
                      fontWeight: FontWeight.w500,
                      color: CusColors.text,
                    ),
                    keyboardType: TextInputType.url,
                    decoration: editProfileDecoration.copyWith(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: getValueForScreenType<double>(
                          context: context,
                          mobile: 13,
                          tablet: 15,
                          desktop: 16,
                        ),
                        horizontal: 18,
                      ),
                      hintText: 'Enter a URL',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: getValueForScreenType<double>(
                          context: context,
                          mobile: width * .018,
                          tablet: width * .015,
                          desktop: width * .009,
                        ),
                        fontWeight: FontWeight.w500,
                        color: CusColors.secondaryText,
                      ),
                    ),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please enter a valid URL';
                      } else if (!Uri.tryParse(val)!.isAbsolute) {
                        return 'Please enter a valid URL format';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      link = val;
                    },
                    onFieldSubmitted: (val) {
                      if (Uri.tryParse(val)!.isAbsolute) {
                        launchLink(val);
                      } else {
                        print('Please enter a valid URL');
                      }
                    },
                  ),
                  //desc
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8, top: 15),
                    child: Text(
                      'Description',
                      style: GoogleFonts.poppins(
                        fontSize: width * .009,
                        fontWeight: FontWeight.w600,
                        color: CusColors.subHeader.withOpacity(0.5),
                      ),
                    ),
                  ),
                  TextFormField(
                    initialValue: widget.bootcampId != null
                        ? widget.bootcamp!.description?.replaceAll('\\n', '\n')
                        : '',
                    minLines: 4,
                    maxLines: null,
                    style: GoogleFonts.poppins(
                      fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .018,
                        tablet: width * .015,
                        desktop: width * .009,
                      ),
                      fontWeight: FontWeight.w500,
                      color: CusColors.text,
                    ),
                    textInputAction: TextInputAction.newline,
                    decoration: editProfileDecoration.copyWith(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: getValueForScreenType<double>(
                            context: context,
                            mobile: 13,
                            tablet: 15,
                            desktop: 16,
                          ),
                          horizontal: 18),
                      hintText: 'Enter an description',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: getValueForScreenType<double>(
                          context: context,
                          mobile: width * .018,
                          tablet: width * .015,
                          desktop: width * .009,
                        ),
                        fontWeight: FontWeight.w500,
                        color: CusColors.secondaryText,
                      ),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Enter an description';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      description = val;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await uploadToFirebase(image);
                            final FirestoreService firestore =
                                FirestoreService(uid: user!.uid);

                            var model = Bootcamp(
                                image: downloadURL,
                                title: title,
                                category: category,
                                date: date,
                                time: time,
                                place: place,
                                speaker: speaker,
                                link: link,
                                description: description);
                            await firestore.CreateBootcamp(model);
                            Get.to(
                                () => DashboardAdmin(
                                      selected: 'Bootcamps',
                                    ),
                                routeName: '/login');
                          }
                        },
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
                          'submit',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
