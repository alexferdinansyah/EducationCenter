import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/models/transaction.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/services/auth_service.dart';
import 'package:project_tc/services/extension.dart';
import 'package:project_tc/services/firestore_service.dart';
import 'package:provider/provider.dart';

class DashboardAdmin extends StatefulWidget {
  const DashboardAdmin({super.key});

  @override
  State<DashboardAdmin> createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardAdmin> {
  int counter = 1;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context, listen: false);
    final FirestoreService firestoreService = FirestoreService(uid: user!.uid);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      body: StreamBuilder(
        stream: firestoreService.userRequestTransaction,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            List<DataRow2> dataRows = snapshot.data!.map((doc) {
              final TransactionModel transaction = doc['transaction'];
              final String transactionId = doc['id'];
              final UserData userData = doc['user'];
              // You need to adjust this part to match your Firestore data structure

              return DataRow2(cells: [
                DataCell(Text(
                  (counter++).toString(),
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
              width: double.infinity,
              height: height - 60,
              color: CusColors.bg,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 35),
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
                  ElevatedButton(
                      onPressed: () async {
                        final AuthService auth = AuthService();
                        auth.signOut();
                      },
                      child: const Text('LOGUT'))
                ],
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
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
      ),
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
          title:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
              'Invoice',
              style: GoogleFonts.poppins(
                fontSize: width * .014,
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
                  fontSize: width * .01,
                  fontWeight: FontWeight.w500,
                  color: CusColors.secondaryText,
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
          title:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
      },
    );
  }
}

// final List<Map> dataMaps = snapshot.data!;

// final List<Map> bundleCourses = dataMaps
//     .where((courseMap) {
//       final dynamic data = courseMap['course'];
//       return data is Course && data.isBundle == true;
//     })
//     .map((courseMap) {
//       final Course course = courseMap['course'];
//       final String id = courseMap['id'];
//       return {'course': course, 'id': id};
//     })
//     .take(3)
//     .toList();

// final List<Map> nonBundleCourses = dataMaps
//     .where((courseMap) {
//       final dynamic data = courseMap['course'];
//       return data is Course && data.isBundle == false;
//     })
//     .map((courseMap) {
//       final Course course = courseMap['course'];
//       final String id = courseMap['id'];
//       return {'course': course, 'id': id};
//     })
//     .take(6)
//     .toList();

// final List<Map> articles = dataMaps.where((articleData) {
//   final dynamic data = articleData['article'];
//   return data is Article;
// }).map((articleData) {
//   final Article article = articleData['article'];
//   final String id = articleData['id'];
//   return {'article': article, 'id': id};
// }).toList();
// SizedBox(
//                   height: height / 1.9,
//                   width: width / 1.7,
//                   child: LiveGrid(
//                       itemCount: bundleCourses.length,
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         mainAxisExtent: height * .51,
//                         crossAxisCount: 3, // Number of items per row
//                         crossAxisSpacing: width *
//                             .02, // Adjust spacing between items horizontally
//                         mainAxisSpacing:
//                             16.0, // Adjust spacing between rows vertically
//                       ),
//                       itemBuilder: animationBuilder((index) => Courses(
//                             course: bundleCourses[index]['course'],
//                             id: bundleCourses[index]['id'],
//                           ))),
//                 ),
//                 SizedBox(
//                   height: height / 1.9,
//                   width: width / 1.7,
//                   child: LiveGrid(
//                       itemCount: nonBundleCourses.length,
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         mainAxisExtent: height * .51,
//                         crossAxisCount: 3, // Number of items per row
//                         crossAxisSpacing: width *
//                             .02, // Adjust spacing between items horizontally
//                         mainAxisSpacing:
//                             16.0, // Adjust spacing between rows vertically
//                       ),
//                       itemBuilder: animationBuilder((index) => Courses(
//                             course: nonBundleCourses[index]['course'],
//                             id: nonBundleCourses[index]['id'],
//                           ))),
//                 ),
//                 SizedBox(
//                   height: height / 1.9,
//                   width: width / 1.7,
//                   child: LiveGrid(
//                       itemCount: articles.length,
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         mainAxisExtent: height * .51,
//                         crossAxisCount: 3, // Number of items per row
//                         crossAxisSpacing: width *
//                             .02, // Adjust spacing between items horizontally
//                         mainAxisSpacing:
//                             16.0, // Adjust spacing between rows vertically
//                       ),
//                       itemBuilder: animationBuilder((index) => Articles(
//                             article: articles[index]['article'],
//                             id: articles[index]['id'],
//                           ))),
//                 ),
//                 ElevatedButton(
//                     onPressed: () async {
//                       final firestoreService = FirestoreService.withoutUID();

//                       final newCourse = Course(
//                           image: 'assets/images/web_dev.jpeg',
//                           courseCategory: 'Online course',
//                           title: 'Junior web developer',
//                           description:
//                               'Prepare your skills to become a Web Developer by following this course bundle. You will learn through case studies and projects that you can put into practice.',
//                           isBundle: true,
//                           price: '400.000',
//                           totalCourse: '5 Courses',
//                           listCourse: [
//                             ListCourse(
//                               image: '',
//                               title: 'Basic HTML',
//                               description: 'Hyper Text Markup Language',
//                               price: '100.000',
//                             ),
//                             ListCourse(
//                               image: '',
//                               title: 'Basic CSS',
//                               description: 'For styling website',
//                               price: '100.000',
//                             ),
//                             ListCourse(
//                               image: '',
//                               title: 'Basic Javascript',
//                               description:
//                                   'To make the website more lively, dynamic, and interactive',
//                               price: '100.000',
//                             ),
//                             ListCourse(
//                               image: '',
//                               title: 'Basic PHP',
//                               description:
//                                   'PHP is a general-purpose scripting language widely used as a server-side language',
//                               price: '100.000',
//                             ),
//                             ListCourse(
//                               image: '',
//                               title: 'Basic MySql',
//                               description:
//                                   'MySQL is a widely used relational database management system (RDBMS).',
//                               price: '100.000',
//                             ),
//                           ],
//                           completionBenefits: [
//                             'Be able to understand HTML, CSS and Javascript languages',
//                             'Be able to create a web with a responsive appearance',
//                             'Understanding PHP Syntax',
//                             'Understanding Basic of Database',
//                             'Can Design Database Systems',
//                           ],
//                           courseType: 'Premium',
//                           discount: '10');

//                       await firestoreService.addCourse(newCourse);
//                     },
//                     child: const Text('ADD COURSE')),
//                 ElevatedButton(
//                     onPressed: () async {
//                       final firestoreService = FirestoreService.withoutUID();

//                       final newArticle = Article(
//                           image: 'assets/images/micomet.jpg',
//                           category: 'UI/UX',
//                           title: 'Tips to learn Figma from Profesional',
//                           description:
//                               "Figma has rapidly emerged as one of the premier design and prototyping tools in the digital industry. Its collaborative features, versatility, and user-friendly interface have made it a favorite among professionals across the globe. If you're looking to harness the power of Figma and learn from the best, these expert tips will guide you on your journey to becoming a Figma pro.",
//                           date: '20 August 2023',
//                           articleContent: [
//                             ArticleContent(
//                                 subTitle: '1. Start with the Basics:',
//                                 subTitleDescription:
//                                     "No matter how experienced you are in design or other tools, it's always a good idea to start with the basics. Familiarize yourself with Figma's user interface, tools, and shortcuts. Understanding the layout and core functionalities will set a strong foundation for your learning journey."),
//                             ArticleContent(
//                                 subTitle:
//                                     '2. Leverage Official Documentation and Tutorials:',
//                                 subTitleDescription:
//                                     'Figma offers comprehensive official documentation and tutorials. These resources are designed to help users of all levels understand and master the tool. From understanding layers and components to working with plugins, the official guides provide step-by-step instructions and explanations.'),
//                             ArticleContent(
//                                 subTitle: 'Learn Keyboard Shortcuts:',
//                                 image: '',
//                                 subTitleDescription:
//                                     'Efficiency is key in the fast-paced world of design. Learning keyboard shortcuts can significantly speed up your workflow. Memorize shortcuts for frequently used tools and actions, such as creating shapes, grouping elements, and zooming in and out'),
//                             ArticleContent(
//                                 subTitle: 'Conclusion',
//                                 subTitleDescription:
//                                     "In conclusion, learning Figma from professionals involves a combination of mastering the tool's features and understanding the broader principles of design. By starting with the basics, leveraging official resources, and embracing collaboration and feedback, you can rapidly progress from a novice to a proficient Figma user. Remember that patience and persistence are key, and as you refine your skills, you'll find yourself creating stunning designs with ease and confidence.")
//                           ]);

//                       await firestoreService.addArticle(newArticle);
//                     },
//                     child: const Text(' ADD ARTICLE')),
