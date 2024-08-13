import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:project_tc/models/Bootcamp.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:project_tc/models/user.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:project_tc/routes/routes.dart';
import 'package:project_tc/components/inputStringFrom.dart';
import 'package:project_tc/services/firestore_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:project_tc/services/firestore_service.dart';

class CreateBootcamp extends StatefulWidget {
  const CreateBootcamp({super.key});

  @override
  State<CreateBootcamp> createState() => _CreateBootcampState();
}

class _CreateBootcampState extends State<CreateBootcamp> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _price = '';
  String _description = '';
  Uint8List? image;
  String? _imagePath;

  selectImageFromGallery() async {
    final picker = ImagePicker();
    XFile? imageFile = await picker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      var file = await imageFile.readAsBytes();
      var tes = imageFile as XFile;
      print(tes.name);
      print(tes.path);
      setState(() {
        _imagePath = tes.name;
        image = file;
      });
    }
  }

  void _updateName(String newValue) {
    setState(() {
      _name = newValue;
    });
  }

  void _updatePrice(String newValue) {
    setState(() {
      _price = newValue;
    });
  }

  void _updateDescription(String newValue) {
    setState(() {
      _description = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    double width = MediaQuery.of(context).size.width;

    void _submitForm() async {
      String? downloadURL;
      String postId = DateTime.now().millisecondsSinceEpoch.toString();
      if (image != null) {
        var contentType = lookupMimeType('', headerBytes: image);
        Reference ref = FirebaseStorage.instance
            .ref()
            .child("bootcamp-pictures")
            .child("post_$postId.jpg");
          downloadURL = await ref.getDownloadURL();
          print(downloadURL);
      }

      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Processing Data')),
        );
        if (_name.isNotEmpty && _price.isNotEmpty && _description.isNotEmpty) {
          print('Name: $_name');
          print('price: $_price');
          print('desc: $_description');
          print('image: $image');
          final FirestoreService firestore = FirestoreService(uid: user!.uid);
          final bootcampData = Bootcamp(name: _name, price: _price, image: downloadURL, description: _description);
          final res = await firestore.createBootcamp(bootcampData);
          print(res!);
        }
      }
    }

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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
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
                    _imagePath == null
                        ? Text('No image selected.')
                        : SizedBox(
                            height: 100, width: 100, child: Text(_imagePath!)),
                    const SizedBox(height: 10),
                    InputStringForm(label: "Name", onSaved: _updateName),
                    const SizedBox(height: 10),
                    InputStringForm(label: "Price", onSaved: _updatePrice),
                    const SizedBox(height: 10),
                    InputStringForm(
                        label: "Description", onSaved: _updateDescription),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ))
        ]));
  }
}
