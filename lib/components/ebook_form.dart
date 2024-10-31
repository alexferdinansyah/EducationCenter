import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/models/ebook.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/routes/routes.dart';
import 'package:project_tc/services/extension.dart';
import 'package:project_tc/services/firestore_service.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class EbookFormModal extends StatefulWidget {
  final EbookModel? ebook ;
  final String? ebookId;

  const EbookFormModal({super.key, this.ebook, this.ebookId});

  @override
  State<EbookFormModal> createState() => _EbookFormModalState();
}

class _EbookFormModalState extends State<EbookFormModal> {
  final _formKey= GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();

String error ='';
String? title;
String? price;
String? ebookLimit;
String? ebookCategory;
String? description;
DateTime? date;
String image ='';
List ebookCategories = [];
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

Future <void> fetchData() async {
  final snapshot =
  await FirebaseFirestore.instance.collection('ebook_categories').get();
  final List<String>data=snapshot.docs.map((doc) => doc['name'] as String).toList();
  setState(() {
    ebookCategories = data;
  });
}

  @override
  void initState() {
    fetchData();
    if (widget.ebookId != null) {
      setState(() {
        _dateController.text = widget.ebook!.date?.formatDate() ?? '';
        image = widget.ebook!.image!;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final user = Provider.of<UserModel?> (context);

    return AlertDialog(
      shape: RoundedRectangleBorder(
         side: const BorderSide(
        color:  Color(0xFFCCCCCC),
          width: 1,
      ),
      borderRadius:  BorderRadius.circular(20),
      ), title:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.ebook == null ? 'Add E-Book' : 'Edit E-Book',
                style: GoogleFonts.poppins(
                  fontSize: getValueForScreenType<double>(context: context, mobile: width * .022,
                  tablet: width * .019,
                  desktop: width * .014,
                  ),
                  fontWeight: FontWeight.w500,
                  color:  const Color(0xFF1F384C),
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
        ],
      ),
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
                      widget.ebookId != null ? widget.ebook!.title : '',
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
                  initialValue: widget.ebookId!= null
                      ? widget.ebook!.description?.replaceAll('\\n', '\n')
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
                    'Ebook limit for basic user',
                    style: GoogleFonts.poppins(
                      fontSize: width * .009,
                      fontWeight: FontWeight.w600,
                      color: CusColors.subHeader.withOpacity(0.5),
                    ),
                  ),
                ),
                TextFormField(
                  initialValue:
                      widget.ebookId != null ? widget.ebook!.ebookLimit : '3',
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
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*')),
                  ],
                  decoration: editProfileDecoration.copyWith(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: getValueForScreenType<double>(
                          context: context,
                          mobile: 13,
                          tablet: 15,
                          desktop: 16,
                        ),
                        horizontal: 18),
                    hintText: 'Enter an learn limit',
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
                      return 'Enter an learn limit';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    ebookLimit = val;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8, top: 15),
                  child: Text(
                    'Price',
                    style: GoogleFonts.poppins(
                      fontSize: width * .009,
                      fontWeight: FontWeight.w600,
                      color: CusColors.subHeader.withOpacity(0.5),
                    ),
                  ),
                ),
                TextFormField(
                  initialValue:
                      widget.ebookId != null ? widget.ebook!.price : '',
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
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    ThousandsFormatter(),
                  ],
                  decoration: editProfileDecoration.copyWith(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: getValueForScreenType<double>(
                          context: context,
                          mobile: 13,
                          tablet: 15,
                          desktop: 16,
                        ),
                        horizontal: 18),
                    hintText: 'Enter an price',
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
                      return 'Enter an price';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    price = val;
                  },
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
        if (widget.ebook != null)
          SizedBox(
            height: getValueForScreenType<double>(
              context: context,
              mobile: 26,
              tablet: 33,
              desktop: 38,
            ),
            child: ElevatedButton(
              onPressed: () => Get.rootDelegate.toNamed(routeAdminLearnCourse,
                  parameters: {'id': widget.ebookId!}),
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
                    const Color.fromARGB(255, 255, 230, 0),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 255, 230, 0),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  )),
              child: Text(
                'Edit learn course',
                style: GoogleFonts.poppins(
                  fontSize: getValueForScreenType<double>(
                    context: context,
                    mobile: width * .018,
                    tablet: width * .015,
                    desktop: width * .01,
                  ),
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
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
                if (widget.ebook!= null) {
                  await firestore.updateEbookFewField(
                    ebookId: widget.ebookId,
                    title: title ?? widget.ebook!.title,
                    date: date ?? widget.ebook!.date,
                    ebookLimit: ebookLimit ?? widget.ebook!.ebookLimit,
                    price: price ?? widget.ebook!.price,
                    description: description ?? widget.ebook!.description,
                    image: image,
                  );
                } else {
                  final EbookModel data = EbookModel(
                    image: image,
                    title: title,
                    description: description,
                    date: date,
                    isDraft: true, 
                    price: price, 
                    ebookLimit: ebookLimit ?? '3',
                    completionBenefits: [],
                  );

                  // await firestore.addArticle(data);
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
              widget.ebook!= null ? 'Save' : 'Save as draf',
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
                if (widget.ebook!= null) {
                  await firestore.updateEbookFewField(
                    ebookId: widget.ebookId,
                    title: title ?? widget.ebook!.title,
                    ebookLimit: ebookLimit ?? widget.ebook!.ebookLimit,
                    // ebookCategory: ebookCategory ?? widget.ebook!.ebookCategory,
                    date: date ?? widget.ebook!.date,
                    description: description ?? widget.ebook!.description,
                    image: image,
                  );
                } else {
                  final EbookModel data = EbookModel(
                    image: image,
                    ebookLimit: ebookLimit ?? '3',
                    title: title,
                    description: description,
                    date: date,
                    isDraft: true, 
                    price: price, 
                    completionBenefits: [],
                  );

                  final result = await firestore.addEbook(data);
                  Get.rootDelegate.toNamed(routeAdminDetailArticle,
                      parameters: {'id': result});
                }
                if (widget.ebookId != null) {
                  Get.rootDelegate.toNamed(routeAdminDetailArticle,
                      parameters: {'id': widget.ebookId!});
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