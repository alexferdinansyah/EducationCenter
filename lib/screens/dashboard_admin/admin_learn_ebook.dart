import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/controllers/detail_controller.dart';
import 'package:project_tc/models/ebook.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/services/extension.dart';
import 'package:provider/provider.dart';

class AdminLearnEbook extends StatefulWidget {
  const AdminLearnEbook({super.key});

  @override
  State<AdminLearnEbook> createState() => _AdminLearnEbookState();
}

class _AdminLearnEbookState extends State<AdminLearnEbook> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _dateController = TextEditingController();

  String id = '';

  String imageUrl = '';
  bool showSave = true;
  bool loading = false;
  bool initArticle = false;

  Uint8List? image;
  String? downloadURL;
  DateTime? date;

  List<EbookContent>? ebookContent;

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
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
        showSave = true;
      });
    }
  }

  Future<String?> uploadFile(Uint8List image) async {
    String postId = DateTime.now().millisecondsSinceEpoch.toString();
    var contentType = lookupMimeType('', headerBytes: image);

    Reference ref = FirebaseStorage.instance
        .ref()
        .child("article")
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

        String fileName = fileUrl!.replaceFirst("ebook%2F", "");

        // Create a reference to the previous image in Firebase Storage
        final storageRef =
            FirebaseStorage.instance.ref().child("ebook").child(fileName);

        // Delete the previous image from Firebase Storage
        await storageRef.delete();
      } catch (e) {
        print('Error deleting previous image: $e');
      }
    }
  }

  final DetailEBookController controller = Get.put(DetailEBookController());

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final user = Provider.of<UserModel?>(context);

    var argument = Get.rootDelegate.parameters;
    id = argument['id']!;
    controller.fetchDocument(id);

    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: width * .045, vertical: height * .018),
                    color: CusColors.bg,
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
