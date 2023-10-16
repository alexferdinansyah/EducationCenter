import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/models/transaction.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/screens/dashboard/dashboard_app.dart';
import 'package:project_tc/services/firestore_service.dart';

class PaymentPage extends StatefulWidget {
  final UserModel user;
  const PaymentPage({super.key, required this.user});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  Uint8List? image;
  String? downloadURL;
  String error = '';

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
        .child("invoice")
        .child("invoive_$postId.jpg");
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
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Membership Upgrade',
                  style: GoogleFonts.poppins(
                    fontSize: width * .014,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1F384C),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: width / 1.7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 500,
                            height: 500,
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
                                  : const DecorationImage(
                                      image: AssetImage(
                                        'assets/images/micomet.jpg',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          const Spacer(),
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
                              'Upload Invoice',
                              style: GoogleFonts.poppins(
                                fontSize: width * .009,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        error,
                        style: const TextStyle(color: Colors.red),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            final firestoreService =
                                FirestoreService(uid: widget.user.uid);

                            if (image != null) {
                              await uploadToFirebase(image);
                              final data = TransactionModel(
                                uid: widget.user.uid,
                                item: TransactionItem(
                                    title: 'Membership', subTitle: 'Pro'),
                                invoiceDate: '28 August 2023',
                                date: DateTime.now(),
                                price: '100000',
                                status: 'Pending',
                                invoice: downloadURL,
                              );

                              await firestoreService
                                  .createTransaction(data)
                                  .then((value) async {
                                await firestoreService
                                    .updateUserTransaction(value);
                              });
                              Get.to(DashboardApp(selected: 'Transaction'));
                            } else {
                              setState(() {
                                error = 'Please put invoice';
                              });
                            }
                          },
                          child: const Text('Confirm'))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
