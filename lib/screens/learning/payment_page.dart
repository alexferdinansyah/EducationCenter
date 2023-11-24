import 'dart:async';
import 'dart:math';

import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/components/custom_list.dart';
import 'package:project_tc/components/loading.dart';
import 'package:project_tc/controllers/detail_controller.dart';
import 'package:project_tc/controllers/storage_controller.dart';
import 'package:project_tc/models/bank_model.dart';
import 'package:project_tc/models/transaction.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/routes/routes.dart';
import 'package:project_tc/screens/auth/confirm_email.dart';
import 'package:project_tc/screens/auth/login/sign_in_responsive.dart';
import 'package:project_tc/screens/dashboard/dashboard_app.dart';
import 'package:project_tc/services/firestore_service.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

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
  int? uniqueCode;
  bool? isVerify;
  Timer? timer;
  bool isOpen = true;

  @override
  void initState() {
    super.initState();

    var ran = Random.secure();
    uniqueCode = ran.nextInt(999);
  }

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

  final UserBankController bankController = Get.put(UserBankController());
  final DetailCourseController controller = Get.put(DetailCourseController());
  final DetailMembershipUser membershipUser = Get.put(DetailMembershipUser());

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final user = Provider.of<UserModel?>(context);
    var route = Get.currentRoute;

    checkEmailVerified() async {
      await FirebaseAuth.instance.currentUser?.reload();

      setState(() {
        isVerify = FirebaseAuth.instance.currentUser!.emailVerified;
      });

      if (isVerify!) {
        timer?.cancel();
      }
    }

    if (user == null) {
      return const ResponsiveSignIn();
    }

    if (isVerify == false) {
      timer = Timer(const Duration(seconds: 2), () => checkEmailVerified());
      return const ConfirmEmail();
    }

    membershipUser.fetchMembership(user.uid);

    return Obx(() {
      final membershipData = membershipUser.membershipData.value;

      if (membershipData == null) {
        return const Loading();
      }

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
            body: _default(
              width,
              height,
              uid: user.uid,
              courseId: id,
              isCourse: true,
              title: course.title,
              price: course.price,
              type: course.courseCategory,
              memberType: membershipData.memberType,
            ),
          );
        });
      }
      return Container(
        width: width * .83,
        height: height - 60,
        color: CusColors.bg,
        child: _default(width, height,
            isCourse: false, memberType: membershipData.memberType),
      );
    });
  }

  Widget _default(double width, double height,
      {String? courseId,
      String? uid,
      bool? isCourse,
      String? title,
      String? type,
      String? price,
      String? memberType,
      int discount = 10}) {
    String? normalPrice = widget.price ?? price;
    int parsedPrice = int.tryParse(normalPrice!.replaceAll(',', '')) ?? 0;
    int total = 0;

    if (isCourse! && memberType == 'Pro') {
      int discountPrice = parsedPrice * discount ~/ 100;
      total = (parsedPrice - discountPrice) + uniqueCode!;
    } else {
      total = parsedPrice + uniqueCode!;
    }

    String totalPrice = NumberFormat("#,###").format(total);

    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (widget.title == 'Membership')
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: GestureDetector(
                          onTap: () => Get.off(
                              DashboardApp(selected: 'Membership-Upgrade'),
                              routeName: routeMembershipUpgrade),
                          child: const Icon(Icons.arrow_back_rounded)),
                    ),
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
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 20),
                          padding: const EdgeInsets.only(bottom: 15),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(color: Colors.black12, width: 3),
                            ),
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'What you buy',
                                  style: GoogleFonts.poppins(
                                    fontSize: width * .012,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF1F384C),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Title',
                                          style: GoogleFonts.poppins(
                                            fontSize: width * .01,
                                            fontWeight: FontWeight.w400,
                                            color: CusColors.subHeader,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 3),
                                          child: Text(
                                            'Type',
                                            style: GoogleFonts.poppins(
                                              fontSize: width * .01,
                                              fontWeight: FontWeight.w400,
                                              color: CusColors.subHeader,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          'Price',
                                          style: GoogleFonts.poppins(
                                            fontSize: width * .01,
                                            fontWeight: FontWeight.w400,
                                            color: CusColors.subHeader,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${widget.title ?? title}',
                                          style: GoogleFonts.poppins(
                                            fontSize: width * .01,
                                            fontWeight: FontWeight.w500,
                                            color: CusColors.subHeader,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 3),
                                          child: Text(
                                            '${widget.type ?? type}',
                                            style: GoogleFonts.poppins(
                                              fontSize: width * .01,
                                              fontWeight: FontWeight.w500,
                                              color: CusColors.subHeader,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          'Rp ${widget.price ?? price}',
                                          style: GoogleFonts.poppins(
                                            fontSize: width * .01,
                                            fontWeight: FontWeight.w500,
                                            color: CusColors.subHeader,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ]),
                        ),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 40),
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'How to buy',
                                  style: GoogleFonts.poppins(
                                    fontSize: width * .012,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF1F384C),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 12),
                                  child: Text(
                                    'Please transfer to this account and send the invoice of your transaction with the button below',
                                    style: GoogleFonts.poppins(
                                      fontSize: width * .01,
                                      fontWeight: FontWeight.w400,
                                      color: CusColors.subHeader,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          'assets/banks/logo_BCA.png',
                                          height: 30,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 3),
                                          child: Text(
                                            'Account Number',
                                            style: GoogleFonts.poppins(
                                              fontSize: width * .01,
                                              fontWeight: FontWeight.w400,
                                              color: CusColors.subHeader,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          'Account Name',
                                          style: GoogleFonts.poppins(
                                            fontSize: width * .01,
                                            fontWeight: FontWeight.w400,
                                            color: CusColors.subHeader,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 30,
                                          child: Text(
                                            'Bank BCA',
                                            style: GoogleFonts.poppins(
                                              fontSize: width * .01,
                                              fontWeight: FontWeight.w500,
                                              color: CusColors.subHeader,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 3),
                                          child: Text(
                                            '4212518585',
                                            style: GoogleFonts.poppins(
                                              fontSize: width * .01,
                                              fontWeight: FontWeight.w500,
                                              color: CusColors.subHeader,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          'DAC SOLUTION INFORMATIKA',
                                          style: GoogleFonts.poppins(
                                            fontSize: width * .01,
                                            fontWeight: FontWeight.w500,
                                            color: CusColors.subHeader,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: width / 4,
                    margin: const EdgeInsets.only(top: 20, left: 50),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Payment summary',
                            style: GoogleFonts.poppins(
                              fontSize: width * .012,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF1F384C),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Payment method',
                                      style: GoogleFonts.poppins(
                                        fontSize: width * .01,
                                        fontWeight: FontWeight.w400,
                                        color: CusColors.subHeader,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 3),
                                      child: Text(
                                        widget.title == 'Membership'
                                            ? 'Membership Pro'
                                            : '$title! ',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                          fontSize: width * .01,
                                          fontWeight: FontWeight.w400,
                                          color: CusColors.subHeader,
                                        ),
                                      ),
                                    ),
                                    if (memberType == 'Pro')
                                      Text(
                                        'Discount for Being a Pro Member',
                                        style: GoogleFonts.poppins(
                                          fontSize: width * .01,
                                          fontWeight: FontWeight.w400,
                                          color: CusColors.subHeader,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (bankController.bankName == null)
                                    Text(
                                      'Select method first',
                                      style: GoogleFonts.poppins(
                                        fontSize: width * .01,
                                        fontWeight: FontWeight.w400,
                                        color: CusColors.subHeader,
                                      ),
                                    ),
                                  if (bankController.bankName != null)
                                    Row(
                                      children: [
                                        Text(
                                          bankController.bankName!,
                                          style: GoogleFonts.poppins(
                                            fontSize: width * .01,
                                            fontWeight: FontWeight.w400,
                                            color: CusColors.subHeader,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showBankListModal(
                                                width, totalPrice);
                                          },
                                          child: Text(
                                            'Change..',
                                            style: GoogleFonts.poppins(
                                              fontSize: width * .008,
                                              fontWeight: FontWeight.w400,
                                              color: CusColors.accentBlue,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 3),
                                    child: Text(
                                      'Rp ${widget.price ?? price}',
                                      style: GoogleFonts.poppins(
                                        fontSize: width * .01,
                                        fontWeight: FontWeight.w400,
                                        color: CusColors.subHeader,
                                      ),
                                    ),
                                  ),
                                  if (memberType == 'Pro')
                                    Text(
                                      '$discount%',
                                      style: GoogleFonts.poppins(
                                        fontSize: width * .01,
                                        fontWeight: FontWeight.w400,
                                        color: CusColors.subHeader,
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            height: 1,
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            color: Colors.grey,
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Total payment',
                                    style: GoogleFonts.poppins(
                                      fontSize: width * .01,
                                      fontWeight: FontWeight.w500,
                                      color: CusColors.text,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                children: [
                                  Text(
                                    'Rp $totalPrice',
                                    style: GoogleFonts.poppins(
                                      fontSize: width * .01,
                                      fontWeight: FontWeight.w500,
                                      color: CusColors.text,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            height: getValueForScreenType<double>(
                              context: context,
                              mobile: 28,
                              tablet: 35,
                              desktop: 40,
                            ),
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 10),
                            child: ElevatedButton(
                              onPressed: () {
                                bankController.bankName == null
                                    ? showBankListModal(width, totalPrice)
                                    : showBuyModal(
                                        width,
                                        height,
                                        courseId: courseId,
                                        discount: discount,
                                        isCourse: isCourse,
                                        memberType: memberType,
                                        price: normalPrice,
                                        totalPrice: totalPrice,
                                        title: title,
                                        type: type,
                                        uid: uid,
                                      );
                              },
                              style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all(
                                    const Color(0xFF4351FF),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                    const Color(0xFF4351FF),
                                  ),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  )),
                              child: Text(
                                bankController.bankName == null
                                    ? 'Select method'
                                    : 'Buy',
                                style: GoogleFonts.poppins(
                                  fontSize: width * .01,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ]),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget bankImageList(String image, double height) {
    return Padding(
      padding: const EdgeInsets.only(right: 14),
      child: Image.asset(
        image,
        height: height,
      ),
    );
  }

  Widget bankButtonList(BankModel bank, double height) {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          bankController.updateUserBank(bank.name!);
          Get.back();
          setState(() {});
        },
        style: ButtonStyle(
          padding: const MaterialStatePropertyAll(
            EdgeInsets.all(15),
          ),
          elevation: const MaterialStatePropertyAll(0),
          backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
          foregroundColor: const MaterialStatePropertyAll(Colors.black),
          overlayColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.focused)) {
              return CusColors.accentBlue.withOpacity(.5);
            }
            if (states.contains(MaterialState.hovered)) {
              return CusColors.accentBlue.withOpacity(.3);
            }
            if (states.contains(MaterialState.pressed)) {
              return CusColors.accentBlue;
            }
            return Colors.transparent;
          }),
          side: const MaterialStatePropertyAll(
            BorderSide(
              color: Colors.grey,
            ),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        child: Row(children: [
          Image.asset(
            bank.image!,
            height: height,
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 18,
          )
        ]),
      ),
    );
  }

  void showBankListModal(width, price) {
    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(builder: (context, setStateDialog) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Total',
                        style: GoogleFonts.poppins(
                          fontSize: width * .01,
                          fontWeight: FontWeight.w400,
                          color: CusColors.subHeader,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                          onTap: () => Get.back(),
                          child: const Icon(Icons.close))
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    'Rp $price',
                    style: GoogleFonts.poppins(
                      fontSize: width * .011,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1F384C),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 5),
                    child: Text(
                      'All payment method',
                      style: GoogleFonts.poppins(
                        fontSize: width * .01,
                        fontWeight: FontWeight.w400,
                        color: CusColors.subHeader,
                      ),
                    ),
                  ),
                  Text(
                    'Virtual account',
                    style: GoogleFonts.poppins(
                      fontSize: width * .01,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1F384C),
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setStateDialog(() {
                              isOpen = !isOpen;
                            });
                          },
                          child: Row(
                            children: [
                              Container(
                                width: width / 2.2,
                                height: 50,
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      Row(
                                        children: bankLists.map((bankImage) {
                                          return bankImageList(
                                              bankImage.image!, 25);
                                        }).toList(),
                                      )
                                    ]),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Icon(
                                isOpen
                                    ? IconlyLight.arrow_up_2
                                    : IconlyLight.arrow_down_2,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          height: isOpen ? 130 : 0,
                          width: width / 2,
                          child: isOpen
                              ? ScrollConfiguration(
                                  behavior: ScrollConfiguration.of(context)
                                      .copyWith(scrollbars: false),
                                  child: MasonryGridView.count(
                                    physics: const ScrollPhysics(
                                        parent: BouncingScrollPhysics()),
                                    crossAxisSpacing: 15,
                                    mainAxisSpacing: 15,
                                    crossAxisCount: 4,
                                    itemCount: bankLists.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return bankButtonList(
                                          bankLists[index], 25);
                                    },
                                  ),
                                )
                              : const SizedBox.shrink(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  void showBuyModal(double width, double height,
      {String? courseId,
      String? uid,
      bool? isCourse,
      String? title,
      String? type,
      String? price,
      String? totalPrice,
      String? memberType,
      int? discount}) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return StatefulBuilder(builder: (context, setStateDialog) {
          return Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cara pembelian di website DEC',
                              style: GoogleFonts.poppins(
                                fontSize: width * .013,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF1F384C),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            BulletList(
                              [
                                'Buka aplikasi bank / E-Wallet yang sudah kalian pilih (${bankController.bankName})',
                                'Masuk ke menu transfer di aplikasi tersebut',
                                'Masukkan nama bank kami, BCA',
                                'Masukkan nomor rekening kami, 7243485198',
                                'Masukan nominal sebesar, Rp $totalPrice',
                                'Screenshot bukti pembayaran yang telah dilakukan',
                                'Klik upload invoice dan pilih bukti transfer tadi',
                                'Klik confirm untuk menyelesaikan pembayaran',
                                'Pembayaran akan dikonfirmasi selama 1x24 jam'
                              ],
                              border: false,
                              fontSize: width * .011,
                              cusWidth: width / 1.7,
                              textColor: CusColors.title,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: width / 4,
                              margin: const EdgeInsets.only(top: 20, left: 50),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Payment Details',
                                      style: GoogleFonts.poppins(
                                        fontSize: width * .012,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF1F384C),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Payment method',
                                                style: GoogleFonts.poppins(
                                                  fontSize: width * .01,
                                                  fontWeight: FontWeight.w400,
                                                  color: CusColors.subHeader,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 3),
                                                child: Text(
                                                  'Title',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: width * .01,
                                                    fontWeight: FontWeight.w400,
                                                    color: CusColors.subHeader,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                'Type',
                                                style: GoogleFonts.poppins(
                                                  fontSize: width * .01,
                                                  fontWeight: FontWeight.w400,
                                                  color: CusColors.subHeader,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 3),
                                                child: Text(
                                                  'Price',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: width * .01,
                                                    fontWeight: FontWeight.w400,
                                                    color: CusColors.subHeader,
                                                  ),
                                                ),
                                              ),
                                              if (memberType == 'Pro')
                                                Text(
                                                  'Discount for Being a Pro Member',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: width * .01,
                                                    fontWeight: FontWeight.w400,
                                                    color: CusColors.subHeader,
                                                  ),
                                                ),
                                              SizedBox(
                                                height: getValueForScreenType<
                                                    double>(
                                                  context: context,
                                                  mobile: 26,
                                                  tablet: 33,
                                                  desktop:
                                                      image != null ? 100 : 38,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Invoice',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: width * .01,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            CusColors.subHeader,
                                                      ),
                                                    ),
                                                    if (image != null)
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 5),
                                                        child: GestureDetector(
                                                          onTap: () async {
                                                            await selectImageFromGallery();
                                                            setStateDialog(
                                                                () {});
                                                          },
                                                          child: Text(
                                                            'Change..',
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize:
                                                                  width * .009,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: CusColors
                                                                  .accentBlue,
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
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              bankController.bankName!,
                                              style: GoogleFonts.poppins(
                                                fontSize: width * .01,
                                                fontWeight: FontWeight.w400,
                                                color: CusColors.subHeader,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 3),
                                              child: Text(
                                                '${widget.title ?? title}',
                                                style: GoogleFonts.poppins(
                                                  fontSize: width * .01,
                                                  fontWeight: FontWeight.w400,
                                                  color: CusColors.subHeader,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              '${widget.type ?? type}',
                                              style: GoogleFonts.poppins(
                                                fontSize: width * .01,
                                                fontWeight: FontWeight.w400,
                                                color: CusColors.subHeader,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 3),
                                              child: Text(
                                                '$price',
                                                style: GoogleFonts.poppins(
                                                  fontSize: width * .01,
                                                  fontWeight: FontWeight.w400,
                                                  color: CusColors.subHeader,
                                                ),
                                              ),
                                            ),
                                            if (memberType == 'Pro')
                                              Text(
                                                '$discount%',
                                                style: GoogleFonts.poppins(
                                                  fontSize: width * .01,
                                                  fontWeight: FontWeight.w400,
                                                  color: CusColors.subHeader,
                                                ),
                                              ),
                                            image != null
                                                ? GestureDetector(
                                                    onTap: () {
                                                      final imageProvider =
                                                          Image.memory(image!)
                                                              .image;
                                                      showImageViewer(
                                                        context,
                                                        imageProvider,
                                                      );
                                                    },
                                                    child: Image.memory(
                                                      image!,
                                                      width: 70,
                                                      height: 100,
                                                    ),
                                                  )
                                                : SizedBox(
                                                    height:
                                                        getValueForScreenType<
                                                            double>(
                                                      context: context,
                                                      mobile: 26,
                                                      tablet: 33,
                                                      desktop: 38,
                                                    ),
                                                    child: ElevatedButton(
                                                      onPressed: () async {
                                                        await selectImageFromGallery();
                                                        setStateDialog(() {});
                                                      },
                                                      style: ButtonStyle(
                                                          padding:
                                                              MaterialStateProperty
                                                                  .all(
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 25),
                                                          ),
                                                          foregroundColor:
                                                              MaterialStateProperty
                                                                  .all(
                                                            const Color(
                                                                0xFF4351FF),
                                                          ),
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(
                                                            const Color(
                                                                0xFF4351FF),
                                                          ),
                                                          shape:
                                                              MaterialStateProperty
                                                                  .all(
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6),
                                                            ),
                                                          )),
                                                      child: Text(
                                                        'Upload Invoice',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize:
                                                              width * .009,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 1,
                                      width: double.infinity,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      color: Colors.grey,
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              'Total payment',
                                              style: GoogleFonts.poppins(
                                                fontSize: width * .01,
                                                fontWeight: FontWeight.w500,
                                                color: CusColors.text,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Column(
                                          children: [
                                            Text(
                                              'Rp $totalPrice',
                                              style: GoogleFonts.poppins(
                                                fontSize: width * .01,
                                                fontWeight: FontWeight.w500,
                                                color: CusColors.text,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ]),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 25, bottom: 10),
                              child: Text(
                                error,
                                style: const TextStyle(color: Colors.red),
                              ),
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
                                    : () {
                                        Get.defaultDialog(
                                            titleStyle: GoogleFonts.poppins(
                                              fontSize: width * .011,
                                              fontWeight: FontWeight.w600,
                                              color: CusColors.accentBlue,
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 15,
                                                    vertical: 10),
                                            content: Column(
                                              children: [
                                                Text(
                                                  'Pembelian akan dikonfirmasi dalam 1x24 jam, harap menunggu',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: width * .011,
                                                    fontWeight: FontWeight.w600,
                                                    color: CusColors.title,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 30,
                                                )
                                              ],
                                            ),
                                            actions: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.black
                                                              .withOpacity(.25),
                                                          spreadRadius: 0,
                                                          blurRadius: 20,
                                                          offset: const Offset(
                                                              0, 4))
                                                    ]),
                                                child: ElevatedButton(
                                                  style: const ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll(
                                                              Colors
                                                                  .redAccent)),
                                                  onPressed: () => Get.back(),
                                                  child: Text(
                                                    'Cancel',
                                                    style: GoogleFonts.mulish(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white,
                                                      fontSize: width * .01,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 10),
                                                decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                        begin: const Alignment(
                                                            -1.2, 0.0),
                                                        colors: [
                                                          const Color.fromARGB(
                                                              255, 24, 95, 202),
                                                          CusColors.mainColor,
                                                        ]),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.black
                                                              .withOpacity(.25),
                                                          spreadRadius: 0,
                                                          blurRadius: 20,
                                                          offset: const Offset(
                                                              0, 4))
                                                    ]),
                                                child: ElevatedButton(
                                                  onPressed: () async {
                                                    setState(() {
                                                      loading = true;
                                                    });
                                                    Get.back();
                                                    final firestoreService =
                                                        FirestoreService(
                                                            uid: widget.user
                                                                    ?.uid ??
                                                                uid!);

                                                    if (image != null) {
                                                      await uploadToFirebase(
                                                          image);
                                                      dynamic data;
                                                      if (isCourse == true) {
                                                        data = TransactionModel(
                                                            uid: uid,
                                                            item:
                                                                TransactionItem(
                                                                    id:
                                                                        courseId,
                                                                    title:
                                                                        title,
                                                                    subTitle:
                                                                        type),
                                                            invoiceDate:
                                                                DateTime.now(),
                                                            date: DateTime
                                                                .now(),
                                                            bankName:
                                                                bankController
                                                                    .bankName,
                                                            price: price,
                                                            status: 'Pending',
                                                            invoice:
                                                                downloadURL,
                                                            uniqueCode:
                                                                uniqueCode
                                                                    .toString(),
                                                            reason: null);
                                                      } else {
                                                        data = TransactionModel(
                                                            uid: widget
                                                                .user!.uid,
                                                            item: TransactionItem(
                                                                title:
                                                                    'Membership',
                                                                subTitle:
                                                                    'Pro'),
                                                            invoiceDate:
                                                                DateTime.now(),
                                                            date:
                                                                DateTime.now(),
                                                            bankName:
                                                                bankController
                                                                    .bankName,
                                                            price: widget.price,
                                                            status: 'Pending',
                                                            invoice:
                                                                downloadURL,
                                                            uniqueCode:
                                                                uniqueCode
                                                                    .toString(),
                                                            reason: null);
                                                      }
                                                      final exist =
                                                          await firestoreService
                                                              .checkTransaction(
                                                                  widget.title ??
                                                                      title);
                                                      if (exist == true) {
                                                        Get.snackbar(
                                                            'Error processing payment',
                                                            'Duplicate payment process');
                                                      } else {
                                                        await firestoreService
                                                            .createTransaction(
                                                                data)
                                                            .then(
                                                                (value) async {
                                                          await firestoreService
                                                              .updateUserTransaction(
                                                                  value);
                                                        });
                                                      }
                                                      setState(() {
                                                        loading = false;
                                                      });
                                                      Get.to(
                                                          () => DashboardApp(
                                                              selected:
                                                                  'Transaction'),
                                                          routeName:
                                                              routeLogin);
                                                    } else {
                                                      setStateDialog(() {
                                                        loading = false;
                                                        error =
                                                            'Please put invoice';
                                                      });
                                                    }
                                                  },
                                                  child: Text(
                                                    'Confirm',
                                                    style: GoogleFonts.mulish(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white,
                                                      fontSize: width * .01,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ]);
                                      },
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8))),
                                    padding:
                                        MaterialStateProperty.all<EdgeInsetsGeometry>(
                                            EdgeInsets.symmetric(
                                                vertical: height * .015,
                                                horizontal: width * .01)),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    shadowColor:
                                        MaterialStateProperty.all(Colors.transparent)),
                                child: loading
                                    ? const CircularProgressIndicator() // Show loading indicator while loading is true
                                    : Text(
                                        'Confirm',
                                        style: GoogleFonts.mulish(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          fontSize: width * .01,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        });
      },
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
    );
  }
}
