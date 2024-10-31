import 'package:flutter/material.dart';
import 'package:project_tc/components/custom_alert.dart';
import 'package:project_tc/services/firestore_service.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:project_tc/routes/routes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:project_tc/models/faq.dart';
import 'package:project_tc/models/user.dart';
import 'package:provider/provider.dart';

class AdminFaq extends StatefulWidget {
  const AdminFaq({super.key});

  @override
  State<AdminFaq> createState() => _AdminFaqState();
}

class _AdminFaqState extends State<AdminFaq> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
        10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('FAQ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              const SizedBox(width: 10),
              ElevatedButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(
                    const Color(0xFF4351FF),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    Colors.white,
                  ),
                  elevation: MaterialStateProperty.all(0),
                  side: MaterialStateProperty.all(BorderSide(
                    color: Color(0xFF4351FF),
                  )),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                onPressed: () {
                  Get.rootDelegate.toNamed(routeCreateFAQ);
                },
                child: Text(
                  'Add FAQ',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF4351FF),
                  ),
                ),
              )
            ],
          ),
          StreamBuilder(
            stream: FirestoreService.withoutUID().allFaqs,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                    child: Text('An error occurred while loading data.'));
              } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
                return Center(child: Text('No data available.'));
              }

              final List<Map<String, dynamic>> dataMaps =
                  List<Map<String, dynamic>>.from(snapshot.data as List);
              final dataFaq = dataMaps.asMap().entries.map((entry) {
                final index = entry.key + 1;
                final data = entry.value;
                final String faqId = entry.value['id'];
                final fek = data["faq"] as Faq;
                return DataRow2(cells: [
                  DataCell(Text('$index')),
                  DataCell(Text(fek.question as String)),
                  DataCell(Text(fek.answer as String)),
                  DataCell(Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Handle edit action
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF121212).withOpacity(.03),
                                offset: const Offset(0, 3),
                                blurRadius: 6,
                              )
                            ],
                            border: Border.all(
                              color: const Color(0xFF7D8398).withOpacity(.3),
                              width: 1,
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8),
                            child: Icon(
                              Icons.edit,
                              color: Color(0xFF121212),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Handle delete action
                          showDialog(
                              context: context,
                              builder: (_) {
                                return CustomAlert(
                                  cancelButton: true,
                                  title: 'Warning',
                                  message: 'Are you sure want to delete this?',
                                  animatedIcon: 'assets/animations/alert.json',
                                  onPressed: () async {
                                    Get.back();
                                    final result =
                                        await FirestoreService(uid: user!.uid)
                                            .deleteFaq(faqId);

                                            if (result == 'Success deleting coupon') {
                                  if (context.mounted) {
                                    showDialog(
                                      context: context,
                                      builder: (_) {
                                        return CustomAlert(
                                          onPressed: () => Get.back(),
                                          title: 'Success',
                                          message: result,
                                          animatedIcon:
                                              'assets/animations/check.json',
                                        );
                                      },
                                    );
                                  }
                                } else {
                                  if (context.mounted) {
                                    showDialog(
                                      context: context,
                                      builder: (_) {
                                        return CustomAlert(
                                          onPressed: () => Get.back(),
                                          title: 'Failed',
                                          message: result,
                                          animatedIcon:
                                              'assets/animations/failed.json',
                                        );
                                      },
                                    );
                                  }
                                }
                                      },
                                );
                              });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF121212).withOpacity(.03),
                                offset: const Offset(0, 3),
                                blurRadius: 6,
                              )
                            ],
                            border: Border.all(
                              color: Colors.red,
                              width: 1,
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8),
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
                ]);
              });
              return Container(
                margin: EdgeInsets.only(top: 10),
                width: width * 0.7,
                height: height,
                child: DataTable2(
                  dataRowColor: MaterialStateProperty.all(Color(0xFFfcfcfc)),
                  border: TableBorder.symmetric(
                    outside: BorderSide(
                      color: const Color(0xFF55565A).withOpacity(.12),
                    ),
                  ),
                  showBottomBorder: false,
                  headingTextStyle: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF121212),
                  ),
                  columns: const [
                    DataColumn2(label: Text('No')),
                    DataColumn2(label: Text('Pertanyaan')),
                    DataColumn2(label: Text('Jawaban')),
                    DataColumn2(label: Text('Action')),
                  ],
                  rows: dataFaq.toList(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
