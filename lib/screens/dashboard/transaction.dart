import "package:data_table_2/data_table_2.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:project_tc/components/constants.dart";

class TransactionTable extends StatefulWidget {
  const TransactionTable({super.key});

  @override
  State<TransactionTable> createState() => _TransactionTableState();
}

class _TransactionTableState extends State<TransactionTable> {
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
                  'Transactions',
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
                  width: double.infinity,
                  height: height - 230,
                  child: DataTable2(
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
                                color: const Color(0xFF55565A).withOpacity(.12),
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
                      dataRowColor:
                          const MaterialStatePropertyAll(Color(0xFFfcfcfc)),
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
                          'Status',
                        )),
                        DataColumn2(
                            label: Text(
                          'Actions',
                        )),
                      ],
                      rows: [
                        DataRow2(cells: [
                          DataCell(Text(
                            '1.',
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
                                'Membership',
                                style: GoogleFonts.poppins(
                                    fontSize: width * .01,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF121212)),
                              ),
                              Text(
                                'Pro',
                                style: GoogleFonts.poppins(
                                    fontSize: width * .01,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF7D8398)),
                              ),
                            ],
                          )),
                          DataCell(Text(
                            '31. Dec. 2022',
                            style: GoogleFonts.poppins(
                                fontSize: width * .01,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF7D8398)),
                          )),
                          DataCell(Text(
                            '15 Jan. 2023',
                            style: GoogleFonts.poppins(
                                fontSize: width * .01,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF7D8398)),
                          )),
                          DataCell(Text(
                            'Rp. 53,18',
                            style: GoogleFonts.poppins(
                                fontSize: width * .01,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF7D8398)),
                          )),
                          DataCell(Container(
                            decoration: BoxDecoration(
                                color: const Color(0xFF91C561).withOpacity(.12),
                                borderRadius: BorderRadius.circular(50)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Row(
                                // mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.done,
                                    color: Color(0xFF91C561),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text('Success',
                                      style: GoogleFonts.poppins(
                                          fontSize: width * .01,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF91C561)))
                                ],
                              ),
                            ),
                          )),
                          DataCell(Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                    color: const Color(0xFF121212)
                                        .withOpacity(.03),
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
                          )),
                        ]),
                        DataRow2(cells: [
                          DataCell(Text(
                            '2.',
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
                                'Membership',
                                style: GoogleFonts.poppins(
                                    fontSize: width * .01,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF121212)),
                              ),
                              Text(
                                'Pro',
                                style: GoogleFonts.poppins(
                                    fontSize: width * .01,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF7D8398)),
                              ),
                            ],
                          )),
                          DataCell(Text(
                            '31. Dec. 2022',
                            style: GoogleFonts.poppins(
                                fontSize: width * .01,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF7D8398)),
                          )),
                          DataCell(Text(
                            '15 Jan. 2023',
                            style: GoogleFonts.poppins(
                                fontSize: width * .01,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF7D8398)),
                          )),
                          DataCell(Text(
                            'Rp. 53,18',
                            style: GoogleFonts.poppins(
                                fontSize: width * .01,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF7D8398)),
                          )),
                          DataCell(Container(
                            decoration: BoxDecoration(
                                color: const Color(0xFF91C561).withOpacity(.12),
                                borderRadius: BorderRadius.circular(50)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Row(
                                // mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.done,
                                    color: Color(0xFF91C561),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text('Success',
                                      style: GoogleFonts.poppins(
                                          fontSize: width * .01,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF91C561)))
                                ],
                              ),
                            ),
                          )),
                          DataCell(Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                    color: const Color(0xFF121212)
                                        .withOpacity(.03),
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
                          )),
                        ])
                      ]),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
