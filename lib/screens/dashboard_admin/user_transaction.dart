import 'package:data_table_2/data_table_2.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/components/loading.dart';
import 'package:project_tc/models/coupons.dart';
import 'package:project_tc/models/transaction.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/services/extension.dart';
import 'package:project_tc/services/firestore_service.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class UserTransaction extends StatefulWidget {
  const UserTransaction({super.key});

  @override
  State<UserTransaction> createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final _formKey = GlobalKey<FormState>();
  String? reason;
  // Add a variable to hold the selected status
  String selectedStatus = 'Pending';
// Add a list of possible statuses
  List<String> statusOptions = ['All', 'Pending', 'Success', 'Failed'];
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    final FirestoreService firestoreService = FirestoreService(uid: user!.uid);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    var deviceType = getDeviceType(MediaQuery.of(context).size);
    double title = 0;
    double subHeader = 0;
    double fixedWidthStatus = 0;

    switch (deviceType) {
      case DeviceScreenType.desktop:
        subHeader = width * .01;
        title = width * .014;
        fixedWidthStatus = 180;
        break;
      case DeviceScreenType.tablet:
        subHeader = width * .015;
        title = width * .019;
        fixedWidthStatus = 170;

        break;
      case DeviceScreenType.mobile:
        subHeader = width * .018;
        title = width * .022;
        fixedWidthStatus = 140;
        break;
      default:
        subHeader = 0;
        title = 0;
    }
    return StreamBuilder(
      stream: firestoreService.userRequestTransaction,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          List<DataRow2> dataRows =
              snapshot.data!.asMap().entries.where((entry) {
            final TransactionModel transaction = entry.value['transaction'];
            return selectedStatus == 'All' ||
                transaction.status == selectedStatus;
          }).map((entry) {
            final TransactionModel transaction = entry.value['transaction'];
            final String transactionId = entry.value['id'];
            final UserData userData = entry.value['user'];
            int counter = entry.key + 1;
            // You need to adjust this part to match your Firestore data structure

            return DataRow2(cells: [
              DataCell(Text(
                counter.toString(),
                style: GoogleFonts.poppins(
                    fontSize: subHeader,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF121212)),
              )),
              DataCell(Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    transaction.item!.title!,
                    style: GoogleFonts.poppins(
                        fontSize: subHeader,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF121212)),
                  ),
                  Text(
                    transaction.item!.subTitle!,
                    style: GoogleFonts.poppins(
                        fontSize: subHeader,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF7D8398)),
                  ),
                ],
              )),
              DataCell(Text(
                transaction.invoiceDate!.formatDate(),
                style: GoogleFonts.poppins(
                    fontSize: subHeader,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF7D8398)),
              )),
              DataCell(Text(
                transaction.date!.formatDateAndTime(),
                style: GoogleFonts.poppins(
                    fontSize: subHeader,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF7D8398)),
              )),
              DataCell(Text(
                transaction.price!,
                style: GoogleFonts.poppins(
                    fontSize: subHeader,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF7D8398)),
              )),
              DataCell(Text(
                userData.name,
                style: GoogleFonts.poppins(
                    fontSize: subHeader,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF7D8398)),
              )),
              DataCell(
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: getValueForScreenType<double>(
                      context: context,
                      mobile: 2,
                      tablet: 5,
                      desktop: 8,
                    ),
                    vertical: getValueForScreenType<double>(
                      context: context,
                      mobile: 2,
                      tablet: 4,
                      desktop: 6,
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: transaction.status == 'Success'
                          ? const Color(0xFF91C561).withOpacity(.12)
                          : transaction.status == 'Pending'
                              ? const Color(0xFFD6A243).withOpacity(.12)
                              : Colors.red,
                      borderRadius: BorderRadius.circular(50)),
                  child: Row(
                    // mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      transaction.status == 'Success'
                          ? Icon(
                              Icons.done,
                              color: const Color(0xFF91C561),
                              size: getValueForScreenType<double>(
                                context: context,
                                mobile: 18,
                                tablet: 20,
                                desktop: 22,
                              ),
                            )
                          : transaction.status == 'Pending'
                              ? Icon(
                                  CupertinoIcons.rays,
                                  color: const Color(0xFFD6A243),
                                  size: getValueForScreenType<double>(
                                    context: context,
                                    mobile: 18,
                                    tablet: 20,
                                    desktop: 22,
                                  ),
                                )
                              : Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: getValueForScreenType<double>(
                                    context: context,
                                    mobile: 18,
                                    tablet: 20,
                                    desktop: 22,
                                  ),
                                ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          transaction.status!,
                          style: GoogleFonts.poppins(
                            fontSize: subHeader,
                            fontWeight: FontWeight.w400,
                            color: transaction.status == 'Success'
                                ? const Color(0xFF91C561)
                                : transaction.status == 'Pending'
                                    ? const Color(0xFFD6A243)
                                    : Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              DataCell(GestureDetector(
                onTap: () {
                  showModalInvoice(width, transaction.invoice, subHeader, title,
                      userData, transactionId, transaction);
                },
                child: Container(
                  padding: EdgeInsets.all(
                    getValueForScreenType<double>(
                      context: context,
                      mobile: 2,
                      tablet: 5,
                      desktop: 8,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0xFF121212).withOpacity(.03),
                          offset: const Offset(0, 3),
                          blurRadius: 6)
                    ],
                    border: Border.all(
                      color: const Color(0xFF7D8398).withOpacity(.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Icon(
                          Icons.remove_red_eye_outlined,
                          color: const Color(0xFF121212),
                          size: getValueForScreenType<double>(
                            context: context,
                            mobile: 20,
                            tablet: 22,
                            desktop: 24,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'View Invoice',
                          style: GoogleFonts.poppins(
                              fontSize: subHeader,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF121212)),
                        ),
                      )
                    ],
                  ),
                ),
              )),
            ]);
          }).toList();
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
            child: ListView(
              children: [
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
                      Text(
                        'User Transactions',
                        style: GoogleFonts.poppins(
                          fontSize: title,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF1F384C),
                        ),
                      ),

                      SizedBox(
                        height: getValueForScreenType<double>(
                          context: context,
                          mobile: 10,
                          tablet: 15,
                          desktop: 20,
                        ),
                      ),
                      // Add a dropdown for status filtering
                      DropdownButton<String>(
                        value: selectedStatus,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedStatus = newValue!;
                          });
                        },
                        items: statusOptions
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: GoogleFonts.poppins(
                                  fontSize: subHeader,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF7D8398)),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        height: getValueForScreenType<double>(
                          context: context,
                          mobile: 20,
                          tablet: 30,
                          desktop: 50,
                        ),
                      ),

                      SizedBox(
                        width: double.infinity,
                        height: height - 230,
                        child: DataTable2(
                            minWidth: getValueForScreenType<double>(
                              context: context,
                              mobile: 1000,
                              tablet: 1200,
                              desktop: 1300,
                            ),
                            isHorizontalScrollBarVisible: false,
                            empty: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 70,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFCFCFC),
                                    border: Border.all(
                                      color: const Color(0xFF55565A)
                                          .withOpacity(.12),
                                    ),
                                  ),
                                  child: Text(
                                    'No transation data',
                                    style: GoogleFonts.poppins(
                                        fontSize: subHeader,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xFF7D8398)),
                                  ),
                                ),
                              ],
                            ),
                            dataRowHeight: getValueForScreenType<double>(
                              context: context,
                              mobile: 60,
                              tablet: 70,
                              desktop: 90,
                            ),
                            dividerThickness: .5,
                            headingRowHeight: getValueForScreenType<double>(
                              context: context,
                              mobile: 40,
                              tablet: 50,
                              desktop: 70,
                            ),
                            dataRowColor: const MaterialStatePropertyAll(
                                Color(0xFFfcfcfc)),
                            border: TableBorder.symmetric(
                                outside: BorderSide(
                              color: const Color(0xFF55565A).withOpacity(.12),
                            )),
                            showBottomBorder: false,
                            headingTextStyle: GoogleFonts.poppins(
                                fontSize: subHeader,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF121212)),
                            columns: [
                              const DataColumn2(
                                  fixedWidth: 50,
                                  label: Text(
                                    'No',
                                  )),
                              const DataColumn2(
                                  size: ColumnSize.L,
                                  label: Text(
                                    'Name',
                                  )),
                              const DataColumn2(
                                  label: Text(
                                'Invoice Date',
                              )),
                              const DataColumn2(
                                  label: Text(
                                'Date',
                              )),
                              const DataColumn2(
                                  size: ColumnSize.S,
                                  label: Text(
                                    'Price',
                                  )),
                              const DataColumn2(
                                  label: Text(
                                'User',
                              )),
                              DataColumn2(
                                  fixedWidth: fixedWidthStatus,
                                  label: const Text(
                                    'Status',
                                  )),
                              DataColumn2(
                                  fixedWidth: fixedWidthStatus,
                                  label: const Text(
                                    'Actions',
                                  )),
                            ],
                            rows: dataRows),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No courses available.'),
          );
        } else {
          return const Center(
            child: Text('kok iso.'),
          );
        }
      },
    );
  }

  void showModalInvoice(width, imageUrl, subHeader, title, UserData user,
      transactionId, TransactionModel transaction) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Color(0xFFCCCCCC),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Invoice',
                style: GoogleFonts.poppins(
                  fontSize: title,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1F384C),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => Get.back(),
                child: Icon(
                  Icons.close,
                  size: getValueForScreenType<double>(
                    context: context,
                    mobile: 20,
                    tablet: 22,
                    desktop: 24,
                  ),
                ),
              )
            ],
          ),
          content: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Unique code : ${transaction.uniqueCode}',
                style: GoogleFonts.poppins(
                  fontSize: subHeader,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1F384C),
                ),
              ),
              Text(
                'User bank name : ${transaction.bankName}',
                style: GoogleFonts.poppins(
                  fontSize: subHeader,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1F384C),
                ),
              ),
              if (transaction.discount != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Discount :',
                      style: GoogleFonts.poppins(
                        fontSize: subHeader,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF1F384C),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: transaction.discount!.map((discount) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Row(
                            children: [
                              Text(
                                '\u2022',
                                style: GoogleFonts.mulish(
                                  fontSize: subHeader,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF1F384C),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Code : ${discount.code}',
                                    style: GoogleFonts.poppins(
                                      fontSize: subHeader,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF1F384C),
                                    ),
                                  ),
                                  if (discount.couponType == null)
                                    Text(
                                      'Amount : ${discount.amount}%',
                                      style: GoogleFonts.poppins(
                                        fontSize: subHeader,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF1F384C),
                                      ),
                                    ),
                                  if (discount.couponType != null)
                                    Text(
                                      'Amount : ${getCouponFormatName(discount.couponType!, discount.amount!)}',
                                      style: GoogleFonts.poppins(
                                        fontSize: subHeader,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF1F384C),
                                      ),
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Text(
                                      'Discounted price : Rp ${discount.discountedPrice}',
                                      style: GoogleFonts.poppins(
                                        fontSize: subHeader,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF1F384C),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    )
                  ],
                ),
              GestureDetector(
                onTap: () {
                  final imageProvider = Image.network(imageUrl!).image;
                  showImageViewer(
                    context,
                    imageProvider,
                  );
                },
                child: Container(
                  width: 200,
                  height: 350,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(imageUrl))),
                ),
              ),
            ],
          )),
          actions: [
            if (transaction.status == 'Pending' ||
                transaction.status == 'Failed')
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: getValueForScreenType<double>(
                      context: context,
                      mobile: 28,
                      tablet: 35,
                      desktop: 40,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        showCancelTransaction(width, user, subHeader, title,
                            transactionId, transaction);
                      },
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(
                              horizontal: getValueForScreenType<double>(
                                context: context,
                                mobile: 10,
                                tablet: 20,
                                desktop: 40,
                              ),
                            ),
                          ),
                          foregroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 234, 47, 47),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 234, 47, 47),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          )),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.poppins(
                          fontSize: subHeader,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                    height: getValueForScreenType<double>(
                      context: context,
                      mobile: 28,
                      tablet: 35,
                      desktop: 40,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        showConfirmTransaction(width, user, subHeader, title,
                            transactionId, transaction);
                      },
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(
                              horizontal: getValueForScreenType<double>(
                                context: context,
                                mobile: 10,
                                tablet: 20,
                                desktop: 40,
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
                        'Confirm',
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
          ],
        );
      },
    );
  }

  void showConfirmTransaction(width, UserData user, subHeader, title,
      transactionId, TransactionModel transaction) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                color: Color(0xFFCCCCCC),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            title: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Detail',
                    style: GoogleFonts.poppins(
                      fontSize: title,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1F384C),
                    ),
                  ),
                ]),
            content: SingleChildScrollView(
                child: SizedBox(
              width: 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${user.name}'),
                  Text('Item: ${transaction.item!.title}'),
                  Text('Item Type: ${transaction.item!.subTitle}'),
                  const SizedBox(
                    height: 100,
                  ),
                  Text(
                      'Dengan mengkonfirmasi ini user bernama ${user.name} akan mendapatkan ${transaction.item!.title} dengan type ${transaction.item!.subTitle}'),
                ],
              ),
            )),
            actions: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.poppins(
                    fontSize: subHeader,
                    fontWeight: FontWeight.w500,
                    color: CusColors.secondaryText,
                  ),
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
                  onPressed: () async {
                    final FirestoreService firestoreService =
                        FirestoreService(uid: user.uid);

                    await firestoreService.confirmTransactionUser(
                        transactionId, user, transaction);

                    Get.back();
                  },
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(
                          horizontal: getValueForScreenType<double>(
                            context: context,
                            mobile: 10,
                            tablet: 20,
                            desktop: 40,
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
                    'Confirm',
                    style: GoogleFonts.poppins(
                      fontSize: subHeader,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  void showCancelTransaction(width, UserData user, subHeader, title,
      transactionId, TransactionModel transaction) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                color: Color(0xFFCCCCCC),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            title: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Detail',
                    style: GoogleFonts.poppins(
                      fontSize: title,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1F384C),
                    ),
                  ),
                ]),
            content: SingleChildScrollView(
                child: SizedBox(
              width: 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${user.name}'),
                  Text('Item: ${transaction.item!.title}'),
                  Text('Item Type: ${transaction.item!.subTitle}'),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: GestureDetector(
                      onTap: () {
                        final imageProvider =
                            Image.network(transaction.invoice!).image;
                        showImageViewer(
                          context,
                          imageProvider,
                        );
                      },
                      child: Image.network(
                        transaction.invoice!,
                        height: 100,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        style: GoogleFonts.poppins(
                          fontSize: getValueForScreenType<double>(
                            context: context,
                            mobile: width * .018,
                            tablet: width * .015,
                            desktop: subHeader,
                          ),
                          fontWeight: FontWeight.w500,
                          color: CusColors.text,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        decoration: editProfileDecoration.copyWith(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: getValueForScreenType<double>(
                                context: context,
                                mobile: 13,
                                tablet: 15,
                                desktop: 16,
                              ),
                              horizontal: 18),
                          hintText: 'Enter an reason',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: getValueForScreenType<double>(
                              context: context,
                              mobile: width * .018,
                              tablet: width * .015,
                              desktop: subHeader,
                            ),
                            fontWeight: FontWeight.w500,
                            color: CusColors.secondaryText,
                          ),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Enter an reason';
                          }
                          return null;
                        },
                        onChanged: (val) {
                          setState(() => reason = val);
                        },
                      ),
                    ),
                  ),
                  Text(
                      'Dengan mengkonfirmasi ini user bernama ${user.name} akan gagal dalam pembelian dikarenakan alasan yang ditulis'),
                ],
              ),
            )),
            actions: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.poppins(
                    fontSize: subHeader,
                    fontWeight: FontWeight.w500,
                    color: CusColors.secondaryText,
                  ),
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
                  onPressed: () async {
                    final FirestoreService firestoreService =
                        FirestoreService(uid: user.uid);

                    await firestoreService.cancelTransactionUser(
                        transactionId, user, transaction, reason!);

                    Get.back();
                  },
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(
                          horizontal: getValueForScreenType<double>(
                            context: context,
                            mobile: 10,
                            tablet: 20,
                            desktop: 40,
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
                    'Confirm',
                    style: GoogleFonts.poppins(
                      fontSize: subHeader,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
