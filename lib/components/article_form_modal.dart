import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/models/article.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/routes/routes.dart';
import 'package:project_tc/services/firestore_service.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:project_tc/services/extension.dart';

class ArticleFormModal extends StatefulWidget {
  final Article? article;
  final String? articleId;
  const ArticleFormModal({super.key, this.article, this.articleId});

  @override
  State<ArticleFormModal> createState() => _ArticleFormModalState();
}

class _ArticleFormModalState extends State<ArticleFormModal> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();

  String error = '';
  String? title;
  String? category;
  String? description;
  DateTime? date;
  String image = '';
  List articleCategories = [];
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

  Future<void> fetchData() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('categories').get();
    final List<String> data =
        snapshot.docs.map((doc) => doc['name'] as String).toList();
    setState(() {
      articleCategories = data;
    });
  }

  @override
  void initState() {
    fetchData();
    if (widget.articleId != null) {
      setState(() {
        _dateController.text = widget.article!.date?.formatDate() ?? '';
        image = widget.article!.image!;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final user = Provider.of<UserModel?>(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Color(0xFFCCCCCC),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Text(
              widget.article == null ? 'Add Article' : 'Edit Article',
              style: GoogleFonts.poppins(
                fontSize: getValueForScreenType<double>(
                  context: context,
                  mobile: width * .022,
                  tablet: width * .019,
                  desktop: width * .014,
                ),
                fontWeight: FontWeight.w500,
                color: const Color(0xFF1F384C),
              ),
            ),
            const Spacer(),
            GestureDetector(
                onTap: () => Get.back(result: false),
                child: const Icon(Icons.close))
          ],
        ),
        const SizedBox(
          height: 10,
          width: 400,
        ),
      ]),
      content: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Title',
                    style: GoogleFonts.poppins(
                      fontSize: width * .009,
                      fontWeight: FontWeight.w600,
                      color: CusColors.subHeader.withOpacity(0.5),
                    ),
                  ),
                ),
                TextFormField(
                  initialValue:
                      widget.articleId != null ? widget.article!.title : '',
                  style: GoogleFonts.poppins(
                    fontSize: getValueForScreenType<double>(
                      context: context,
                      mobile: width * .018,
                      tablet: width * .015,
                      desktop: width * .009,
                    ),
                    fontWeight: FontWeight.w500,
                    color: CusColors.text,
                  ),
                  keyboardType: TextInputType.text,
                  decoration: editProfileDecoration.copyWith(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: getValueForScreenType<double>(
                          context: context,
                          mobile: 13,
                          tablet: 15,
                          desktop: 16,
                        ),
                        horizontal: 18),
                    hintText: 'Enter an title',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .018,
                        tablet: width * .015,
                        desktop: width * .009,
                      ),
                      fontWeight: FontWeight.w500,
                      color: CusColors.secondaryText,
                    ),
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Enter an title';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    title = val;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8, top: 15),
                  child: Text(
                    'Description',
                    style: GoogleFonts.poppins(
                      fontSize: width * .009,
                      fontWeight: FontWeight.w600,
                      color: CusColors.subHeader.withOpacity(0.5),
                    ),
                  ),
                ),
                TextFormField(
                  initialValue: widget.articleId != null
                      ? widget.article!.description?.replaceAll('\\n', '\n')
                      : '',
                  minLines: 4,
                  maxLines: null,
                  style: GoogleFonts.poppins(
                    fontSize: getValueForScreenType<double>(
                      context: context,
                      mobile: width * .018,
                      tablet: width * .015,
                      desktop: width * .009,
                    ),
                    fontWeight: FontWeight.w500,
                    color: CusColors.text,
                  ),
                  textInputAction: TextInputAction.newline,
                  decoration: editProfileDecoration.copyWith(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: getValueForScreenType<double>(
                          context: context,
                          mobile: 13,
                          tablet: 15,
                          desktop: 16,
                        ),
                        horizontal: 18),
                    hintText: 'Enter an description',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .018,
                        tablet: width * .015,
                        desktop: width * .009,
                      ),
                      fontWeight: FontWeight.w500,
                      color: CusColors.secondaryText,
                    ),
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Enter an description';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    description = val;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8, top: 15),
                  child: Text(
                    'Article Category',
                    style: GoogleFonts.poppins(
                      fontSize: width * .009,
                      fontWeight: FontWeight.w600,
                      color: CusColors.subHeader.withOpacity(0.5),
                    ),
                  ),
                ),
                DropdownButtonFormField<String>(
                  value: widget.articleId != null
                      ? widget.article!.category
                      : null,
                  icon: const Icon(IconlyLight.arrow_down_2),
                  decoration: editProfileDecoration.copyWith(
                    hintText: 'Course Category',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: width * .009,
                      fontWeight: FontWeight.w500,
                      color: CusColors.subHeader.withOpacity(0.5),
                    ),
                  ),
                  validator: (val) => val == null || val.isEmpty
                      ? 'Please select a article category'
                      : null,
                  onChanged: (val) {
                    category = val!; // Update the selected value
                  },
                  items: articleCategories.map((category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(
                        category,
                        style: GoogleFonts.poppins(
                          fontSize: width * .009,
                          fontWeight: FontWeight.w500,
                          color: CusColors.text,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8, top: 15),
                  child: Text(
                    'Date',
                    style: GoogleFonts.poppins(
                      fontSize: width * .009,
                      fontWeight: FontWeight.w600,
                      color: CusColors.subHeader.withOpacity(0.5),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: TextFormField(
                    controller: _dateController,
                    enabled: false,
                    style: GoogleFonts.poppins(
                      fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .018,
                        tablet: width * .015,
                        desktop: width * .009,
                      ),
                      fontWeight: FontWeight.w500,
                      color: CusColors.text,
                    ),
                    keyboardType: TextInputType.text,
                    decoration: editProfileDecoration.copyWith(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: getValueForScreenType<double>(
                            context: context,
                            mobile: 13,
                            tablet: 15,
                            desktop: 16,
                          ),
                          horizontal: 18),
                      hintText: 'Select date',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: getValueForScreenType<double>(
                          context: context,
                          mobile: width * .018,
                          tablet: width * .015,
                          desktop: width * .009,
                        ),
                        fontWeight: FontWeight.w500,
                        color: CusColors.secondaryText,
                      ),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Enter an date';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        SizedBox(
          height: getValueForScreenType<double>(
            context: context,
            mobile: 26,
            tablet: 33,
            desktop: 38,
          ),
          child: ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final FirestoreService firestore =
                    FirestoreService(uid: user!.uid);
                if (widget.article != null) {
                  await firestore.updateArticleFewField(
                    articleId: widget.articleId,
                    title: title ?? widget.article!.title,
                    category: category ?? widget.article!.category,
                    date: date ?? widget.article!.date,
                    description: description ?? widget.article!.description,
                    image: image,
                  );
                } else {
                  final Article data = Article(
                    image: image,
                    category: category,
                    title: title,
                    description: description,
                    date: date,
                    isDraft: true,
                  );

                  await firestore.addArticle(data);
                }
                Get.back(result: false);
              }
            },
            style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(
                    horizontal: getValueForScreenType<double>(
                      context: context,
                      mobile: 20,
                      tablet: 25,
                      desktop: 30,
                    ),
                  ),
                ),
                foregroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 23, 221, 1),
                ),
                backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 23, 221, 1),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                )),
            child: Text(
              widget.article != null ? 'Save' : 'Save as draf',
              style: GoogleFonts.poppins(
                fontSize: getValueForScreenType<double>(
                  context: context,
                  mobile: width * .018,
                  tablet: width * .015,
                  desktop: width * .01,
                ),
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        SizedBox(
          height: getValueForScreenType<double>(
            context: context,
            mobile: 26,
            tablet: 33,
            desktop: 38,
          ),
          child: ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final FirestoreService firestore =
                    FirestoreService(uid: user!.uid);
                if (widget.article != null) {
                  await firestore.updateArticleFewField(
                    articleId: widget.articleId,
                    title: title ?? widget.article!.title,
                    category: category ?? widget.article!.category,
                    date: date ?? widget.article!.date,
                    description: description ?? widget.article!.description,
                    image: image,
                  );
                } else {
                  final Article data = Article(
                    image: image,
                    category: category,
                    title: title,
                    description: description,
                    date: date,
                    isDraft: true,
                  );

                  final result = await firestore.addArticle(data);
                  Get.rootDelegate.toNamed(routeAdminDetailArticle,
                      parameters: {'id': result});
                }
                if (widget.articleId != null) {
                  Get.rootDelegate.toNamed(routeAdminDetailArticle,
                      parameters: {'id': widget.articleId!});
                }
              }
            },
            style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(
                    horizontal: getValueForScreenType<double>(
                      context: context,
                      mobile: 20,
                      tablet: 25,
                      desktop: 30,
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
              'Continue',
              style: GoogleFonts.poppins(
                fontSize: getValueForScreenType<double>(
                  context: context,
                  mobile: width * .018,
                  tablet: width * .015,
                  desktop: width * .01,
                ),
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }
}
