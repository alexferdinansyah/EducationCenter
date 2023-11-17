import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/components/loading.dart';
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
                    fontSize: width * .01,
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
                        fontSize: width * .01,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF121212)),
                  ),
                  Text(
                    transaction.item!.subTitle!,
                    style: GoogleFonts.poppins(
                        fontSize: width * .01,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF7D8398)),
                  ),
                ],
              )),
              DataCell(Text(
                transaction.invoiceDate!.formatDate(),
                style: GoogleFonts.poppins(
                    fontSize: width * .01,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF7D8398)),
              )),
              DataCell(Text(
                transaction.date!.formatDate(),
                style: GoogleFonts.poppins(
                    fontSize: width * .01,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF7D8398)),
              )),
              DataCell(Text(
                transaction.price!,
                style: GoogleFonts.poppins(
                    fontSize: width * .01,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF7D8398)),
              )),
              DataCell(Text(
                userData.name,
                style: GoogleFonts.poppins(
                    fontSize: width * .01,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF7D8398)),
              )),
              DataCell(Container(
                decoration: BoxDecoration(
                    color: transaction.status == 'Success'
                        ? const Color(0xFF91C561).withOpacity(.12)
                        : transaction.status == 'Pending'
                            ? const Color(0xFFD6A243).withOpacity(.12)
                            : Colors.red,
                    borderRadius: BorderRadius.circular(50)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    // mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      transaction.status == 'Success'
                          ? const Icon(
                              Icons.done,
                              color: Color(0xFF91C561),
                            )
                          : transaction.status == 'Pending'
                              ? const Icon(
                                  CupertinoIcons.rays,
                                  color: Color(0xFFD6A243),
                                )
                              : const Icon(Icons.close, color: Colors.white),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(transaction.status!,
                          style: GoogleFonts.poppins(
                              fontSize: width * .01,
                              fontWeight: FontWeight.w400,
                              color: transaction.status == 'Success'
                                  ? const Color(0xFF91C561)
                                  : transaction.status == 'Pending'
                                      ? const Color(0xFFD6A243)
                                      : Colors.white))
                    ],
                  ),
                ),
              )),
              DataCell(GestureDetector(
                onTap: () {
                  showModalInvoice(width, transaction.invoice, userData,
                      transactionId, transaction);
                },
                child: Container(
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
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.remove_red_eye_outlined,
                          color: Color(0xFF121212),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'View Invoice',
                          style: GoogleFonts.poppins(
                              fontSize: width * .01,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF121212)),
                        )
                      ],
                    ),
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
                          fontSize: width * .014,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF1F384C),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
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
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      const SizedBox(
                        height: 50,
                      ),

                      SizedBox(
                        width: double.infinity,
                        height: height - 230,
                        child: DataTable2(
                            minWidth: getValueForScreenType<double>(
                              context: context,
                              mobile: 900,
                              tablet: 1000,
                              desktop: 1300,
                            ),
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
                                        fontSize: width * .01,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xFF7D8398)),
                                  ),
                                ),
                              ],
                            ),
                            dataRowHeight: 90,
                            dividerThickness: .5,
                            headingRowHeight: 70,
                            dataRowColor: const MaterialStatePropertyAll(
                                Color(0xFFfcfcfc)),
                            border: TableBorder.symmetric(
                                outside: BorderSide(
                              color: const Color(0xFF55565A).withOpacity(.12),
                            )),
                            showBottomBorder: false,
                            headingTextStyle: GoogleFonts.poppins(
                                fontSize: width * .01,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF121212)),
                            columns: const [
                              DataColumn2(
                                  fixedWidth: 50,
                                  label: Text(
                                    'No',
                                  )),
                              DataColumn2(
                                  size: ColumnSize.L,
                                  label: Text(
                                    'Name',
                                  )),
                              DataColumn2(
                                  label: Text(
                                'Invoice Date',
                              )),
                              DataColumn2(
                                  label: Text(
                                'Date',
                              )),
                              DataColumn2(
                                  size: ColumnSize.S,
                                  label: Text(
                                    'Price',
                                  )),
                              DataColumn2(
                                  label: Text(
                                'User',
                              )),
                              DataColumn2(
                                  label: Text(
                                'Status',
                              )),
                              DataColumn2(
                                  label: Text(
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

  void showModalInvoice(width, imageUrl, UserData user, transactionId,
      TransactionModel transaction) {
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
                  fontSize: width * .014,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1F384C),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => Get.back(),
                child: const Icon(Icons.close),
              )
            ],
          ),
          content: SingleChildScrollView(
              child: Column(
            children: [
              Text(
                'Unique code : ${transaction.uniqueCode}',
                style: GoogleFonts.poppins(
                  fontSize: width * .014,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1F384C),
                ),
              ),
              Container(
                width: 200,
                height: 350,
                decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(imageUrl))),
              ),
            ],
          )),
          actions: [
            ElevatedButton(
              onPressed: () {
                Get.back();
                showCancelTransaction(width, user, transactionId, transaction);
              },
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
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
                  fontSize: width * .01,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Get.back();
                showConfirmTransaction(width, user, transactionId, transaction);
              },
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
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
                  fontSize: width * .01,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showConfirmTransaction(
      width, UserData user, transactionId, TransactionModel transaction) {
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
                      fontSize: width * .014,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1F384C),
                    ),
                  ),
                ]),
            content: SingleChildScrollView(
                child: SizedBox(
              height: 500,
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
                    fontSize: width * .01,
                    fontWeight: FontWeight.w500,
                    color: CusColors.secondaryText,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final FirestoreService firestoreService =
                      FirestoreService(uid: user.uid);

                  await firestoreService.confirmTransactionUser(
                      transactionId, user, transaction);

                  Get.back();
                },
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
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
                    fontSize: width * .01,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        });
  }

  void showCancelTransaction(
      width, UserData user, transactionId, TransactionModel transaction) {
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
                      fontSize: width * .014,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1F384C),
                    ),
                  ),
                ]),
            content: SingleChildScrollView(
                child: SizedBox(
              height: 500,
              width: 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${user.name}'),
                  Text('Item: ${transaction.item!.title}'),
                  Text('Item Type: ${transaction.item!.subTitle}'),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Image.network(
                      transaction.invoice!,
                      height: 100,
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
                            desktop: width * .01,
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
                              desktop: width * .01,
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
                    fontSize: width * .01,
                    fontWeight: FontWeight.w500,
                    color: CusColors.secondaryText,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final FirestoreService firestoreService =
                      FirestoreService(uid: user.uid);

                  await firestoreService.cancelTransactionUser(
                      transactionId, user, transaction, reason!);

                  Get.back();
                },
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
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
                    fontSize: width * .01,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        });
  }
}
