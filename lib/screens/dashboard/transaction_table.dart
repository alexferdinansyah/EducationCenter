import "package:data_table_2/data_table_2.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:google_fonts/google_fonts.dart";
import "package:project_tc/components/constants.dart";
import "package:project_tc/components/loading.dart";
import "package:project_tc/models/transaction.dart";
import "package:project_tc/models/user.dart";
import "package:project_tc/services/extension.dart";
import "package:project_tc/services/firestore_service.dart";
import "package:responsive_builder/responsive_builder.dart";

class TransactionTable extends StatefulWidget {
  final UserModel user;
  const TransactionTable({super.key, required this.user});

  @override
  State<TransactionTable> createState() => _TransactionTableState();
}

class _TransactionTableState extends State<TransactionTable> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    var deviceType = getDeviceType(MediaQuery.of(context).size);
    double title = 0;
    double subHeader = 0;

    switch (deviceType) {
      case DeviceScreenType.desktop:
        subHeader = width * .01;
        title = width * .014;
        break;
      case DeviceScreenType.tablet:
        subHeader = width * .015;
        title = width * .019;

        break;
      case DeviceScreenType.mobile:
        subHeader = width * .018;
        title = width * .022;
        break;
      default:
        subHeader = 0;
        title = 0;
    }
    return StreamBuilder(
        stream: FirestoreService(uid: widget.user.uid).userTransaction,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            List<DataRow2> dataRows =
                snapshot.data!.asMap().entries.map((entry) {
              final TransactionModel transaction = entry.value['transaction'];
              // You need to adjust this part to match your Firestore data structure
              int counter = entry.key + 1;

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
                  transaction.date!.formatDate(),
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
                DataCell(
                  transaction.reason != null
                      ? GestureDetector(
                          onTap: () {
                            showModalStatus(width, transaction.invoice,
                                transaction, subHeader, title);
                          },
                          child: Container(
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
                                        ? const Color(0xFFD6A243)
                                            .withOpacity(.12)
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
                                          mobile: 20,
                                          tablet: 22,
                                          desktop: 24,
                                        ),
                                      )
                                    : transaction.status == 'Pending'
                                        ? Icon(
                                            CupertinoIcons.rays,
                                            color: const Color(0xFFD6A243),
                                            size: getValueForScreenType<double>(
                                              context: context,
                                              mobile: 20,
                                              tablet: 22,
                                              desktop: 24,
                                            ),
                                          )
                                        : Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: getValueForScreenType<double>(
                                              context: context,
                                              mobile: 20,
                                              tablet: 22,
                                              desktop: 24,
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
                        )
                      : Container(
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
                                        mobile: 20,
                                        tablet: 22,
                                        desktop: 24,
                                      ),
                                    )
                                  : transaction.status == 'Pending'
                                      ? Icon(
                                          CupertinoIcons.rays,
                                          color: const Color(0xFFD6A243),
                                          size: getValueForScreenType<double>(
                                            context: context,
                                            mobile: 20,
                                            tablet: 22,
                                            desktop: 24,
                                          ),
                                        )
                                      : Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: getValueForScreenType<double>(
                                            context: context,
                                            mobile: 20,
                                            tablet: 22,
                                            desktop: 24,
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
                    showModalInvoice(
                        width, transaction.invoice, title, subHeader);
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
                          'Transactions',
                          style: GoogleFonts.poppins(
                            fontSize: title,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF1F384C),
                          ),
                        ),
                        SizedBox(
                          height: getValueForScreenType<double>(
                            context: context,
                            mobile: 25,
                            tablet: 40,
                            desktop: 70,
                          ),
                        ),
                        SizedBox(
                          height: height - 230,
                          child: DataTable2(
                              minWidth: getValueForScreenType<double>(
                                context: context,
                                mobile: 900,
                                tablet: 1000,
                                desktop: 1060,
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
              child: Text('No transaction available.'),
            );
          } else {
            return const Center(
              child: Text('kok iso.'),
            );
          }
        });
  }

  void showModalStatus(
      width, imageUrl, TransactionModel transaction, subHeader, title) {
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
                'Reason why your transaction is ${transaction.status}',
                style: GoogleFonts.poppins(
                  fontSize: title,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1F384C),
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 200,
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                    ),
                  ),
                ),
                Text(
                  transaction.reason!,
                  style: GoogleFonts.poppins(
                    fontSize: subHeader,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1F384C),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Padding(
                padding: const EdgeInsets.only(right: 25),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.poppins(
                    fontSize: subHeader,
                    fontWeight: FontWeight.w500,
                    color: CusColors.secondaryText,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showModalInvoice(width, imageUrl, title, subHeader) {
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
          title:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
              'Invoice',
              style: GoogleFonts.poppins(
                fontSize: title,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF1F384C),
              ),
            ),
          ]),
          content: SingleChildScrollView(
              child: Container(
            width: 200,
            height: 350,
            decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(imageUrl))),
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
          ],
        );
      },
    );
  }
}
