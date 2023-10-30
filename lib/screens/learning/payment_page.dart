import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/components/loading.dart';
import 'package:project_tc/controllers/detail_controller.dart';
import 'package:project_tc/models/transaction.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/routes/routes.dart';
import 'package:project_tc/screens/dashboard/dashboard_app.dart';
import 'package:project_tc/services/firestore_service.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
  final UserModel? user;
  final String? title;
  final String? type;
  final String? price;
  const PaymentPage({
    super.key,
    this.user,
    this.title,
    this.type,
    this.price,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  Uint8List? image;
  String? downloadURL;
  String error = '';
  bool loading = false;

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

  String id = '';

  final DetailCourseController controller = Get.put(DetailCourseController());

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final user = Provider.of<UserModel?>(context);
    var route = Get.currentRoute;

    if (route.contains('/checkout/course')) {
      var argument = Get.parameters;
      id = argument['id']!;
      controller.fetchDocument(id);
      return Obx(() {
        final course = controller.documentSnapshot.value;

        if (course == null) {
          return const Loading();
        }

        return Scaffold(
          backgroundColor: CusColors.bg,
          body: _default(width,
              uid: user!.uid,
              courseId: id,
              isCourse: true,
              title: course.title,
              price: course.price,
              type: course.courseCategory),
        );
      });
    }
    return Container(
        width: width * .83,
        height: height - 60,
        color: CusColors.bg,
        child: _default(width, isCourse: false));
  }

  Widget _default(
    double width, {
    String? courseId,
    String? uid,
    bool? isCourse,
    String? title,
    String? type,
    String? price,
  }) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title == 'Membership'
                    ? 'Upgrade Membership'
                    : 'Buy Course',
                style: GoogleFonts.poppins(
                  fontSize: width * .014,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1F384C),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: width / 1.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      child: Column(children: [
                        Text(
                          'What you buy',
                          style: GoogleFonts.poppins(
                            fontSize: width * .011,
                            fontWeight: FontWeight.w600,
                            color: CusColors.title,
                          ),
                        ),
                        Text(
                          'Title : ${widget.title ?? title}',
                          style: GoogleFonts.poppins(
                            fontSize: width * .01,
                            fontWeight: FontWeight.w400,
                            color: CusColors.subHeader,
                          ),
                        ),
                        Text(
                          'Type : ${widget.type ?? type}',
                          style: GoogleFonts.poppins(
                            fontSize: width * .01,
                            fontWeight: FontWeight.w400,
                            color: CusColors.subHeader,
                          ),
                        ),
                        Text(
                          'Price : ${widget.price ?? price}',
                          style: GoogleFonts.poppins(
                            fontSize: width * .01,
                            fontWeight: FontWeight.w400,
                            color: CusColors.subHeader,
                          ),
                        ),
                      ]),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'How to buy',
                            style: GoogleFonts.poppins(
                              fontSize: width * .011,
                              fontWeight: FontWeight.w600,
                              color: CusColors.title,
                            ),
                          ),
                          Text(
                            'Please transfer to this account and send the invoice of your transaction with the button below',
                            style: GoogleFonts.poppins(
                              fontSize: width * .01,
                              fontWeight: FontWeight.w400,
                              color: CusColors.subHeader,
                            ),
                          ),
                          Text(
                            'Account Number : 7243485198\nBank Name : Bank BSI\nAmount : ${widget.price ?? price}',
                            style: GoogleFonts.poppins(
                              fontSize: width * .01,
                              fontWeight: FontWeight.w400,
                              color: CusColors.subHeader,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (image != null)
                      Image.memory(
                        image!,
                        height: 200,
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
                        'Upload Invoice',
                        style: GoogleFonts.poppins(
                          fontSize: width * .009,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      error,
                      style: const TextStyle(color: Colors.red),
                    ),
                    Container(
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
                                setState(() {
                                  loading = true;
                                });
                                final firestoreService = FirestoreService(
                                    uid: widget.user?.uid ?? uid!);

                                if (image != null) {
                                  await uploadToFirebase(image);
                                  dynamic data;
                                  if (isCourse == true) {
                                    data = TransactionModel(
                                      uid: uid,
                                      item: TransactionItem(
                                          id: courseId,
                                          title: title,
                                          subTitle: type),
                                      invoiceDate: DateTime.now(),
                                      date: DateTime.now(),
                                      price: price,
                                      status: 'Pending',
                                      invoice: downloadURL,
                                    );
                                  } else {
                                    data = TransactionModel(
                                      uid: widget.user!.uid,
                                      item: TransactionItem(
                                          title: 'Membership', subTitle: 'Pro'),
                                      invoiceDate: DateTime.now(),
                                      date: DateTime.now(),
                                      price: widget.price,
                                      status: 'Pending',
                                      invoice: downloadURL,
                                    );
                                  }
                                  final exist = await firestoreService
                                      .checkTransaction(widget.title ?? title);
                                  if (exist == true) {
                                    Get.snackbar('Error processing payment',
                                        'Duplicate payment process');
                                  } else {
                                    await firestoreService
                                        .createTransaction(data)
                                        .then((value) async {
                                      await firestoreService
                                          .updateUserTransaction(value);
                                    });
                                  }
                                  setState(() {
                                    loading = false;
                                  });
                                  Get.to(
                                      () =>
                                          DashboardApp(selected: 'Transaction'),
                                      routeName: routeLogin);
                                } else {
                                  setState(() {
                                    loading = false;
                                    error = 'Please put invoice';
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
                                    EdgeInsets.symmetric(
                                        vertical: width * .01,
                                        horizontal: width * .01)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                            shadowColor:
                                MaterialStateProperty.all(Colors.transparent)),
                        child: loading
                            ? const CircularProgressIndicator() // Show loading indicator while loading is true
                            : Text(
                                'Confirm',
                                style: GoogleFonts.mulish(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: width * .012,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
