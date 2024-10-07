import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/controllers/detail_controller.dart';
import 'package:project_tc/models/article.dart';
import 'package:project_tc/models/user.dart';
import 'package:project_tc/screens/dashboard_admin/dashboard_admin.dart';
import 'package:project_tc/services/firestore_service.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:project_tc/services/extension.dart';

class AdminDetailArticle extends StatefulWidget {
  const AdminDetailArticle({super.key});

  @override
  State<AdminDetailArticle> createState() => _AdminDetailArticleState();
}

class _AdminDetailArticleState extends State<AdminDetailArticle> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _dateController = TextEditingController();

  String id = '';

  String imageUrl = '';
  bool showSave = true;
  bool loading = false;
  bool initArticle = false;

  Uint8List? image;
  String? downloadURL;
  DateTime? date;

  List<ArticleContent>? articleContents;

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

  selectImageFromGallery() async {
    final picker = ImagePicker();
    XFile? imageFile = await picker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      var file = await imageFile.readAsBytes();
      setState(() {
        image = file;
        showSave = true;
      });
    }
  }

  Future<String?> uploadFile(Uint8List image) async {
    String postId = DateTime.now().millisecondsSinceEpoch.toString();
    var contentType = lookupMimeType('', headerBytes: image);

    Reference ref = FirebaseStorage.instance
        .ref()
        .child("article")
        .child("post_$postId.jpg");
    await ref.putData(image, SettableMetadata(contentType: contentType));
    downloadURL = await ref.getDownloadURL();
    return downloadURL;
  }

  uploadToFirebase(image) async {
    await uploadFile(image).then((value) {
      setState(() {
        showSave = false;
      });
    }); // this will upload the file and store url in the variable 'url'
  }

  Future<void> deleteExistingPhoto() async {
    if (imageUrl != '' || downloadURL != null) {
      try {
        // Define a regular expression to match the filename
        RegExp regExp = RegExp(r'[^\/]+(?=\?)');

        // Use the regular expression to extract the filename
        String? fileUrl = regExp.firstMatch(downloadURL ?? imageUrl)?.group(0);

        String fileName = fileUrl!.replaceFirst("article%2F", "");

        // Create a reference to the previous image in Firebase Storage
        final storageRef =
            FirebaseStorage.instance.ref().child("article").child(fileName);

        // Delete the previous image from Firebase Storage
        await storageRef.delete();
      } catch (e) {
        print('Error deleting previous image: $e');
      }
    }
  }

  final DetailArticleController controller = Get.put(DetailArticleController());

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final user = Provider.of<UserModel?>(context);

    var argument = Get.rootDelegate.parameters;
    id = argument['id']!;
    controller.fetchDocument(id);

    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: width * .045, vertical: height * .018),
                color: CusColors.bg,
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      final article = controller.documentSnapshot.value;

                      if (article == null) {
                        return const Center(child: Text('Loading...'));
                      }

                      if (!initArticle) {
                        imageUrl = article.image!;
                        _dateController.text = article.date?.formatDate() ?? '';
                        articleContents = article.articleContent;
                      }

                      initArticle = true;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: getValueForScreenType<double>(
                                context: context,
                                mobile: 25,
                                tablet: 40,
                                desktop: 100,
                              ),
                              bottom: getValueForScreenType<double>(
                                context: context,
                                mobile: 5,
                                tablet: 10,
                                desktop: 20,
                              ),
                            ),
                            child: TextFormField(
                              initialValue: article.title,
                              style: GoogleFonts.mulish(
                                  color: CusColors.header,
                                  fontSize: getValueForScreenType<double>(
                                    context: context,
                                    mobile: width * .035,
                                    tablet: width * .024,
                                    desktop: width * .023,
                                  ),
                                  fontWeight: FontWeight.bold),
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero),
                              keyboardType: TextInputType.text,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Enter an title';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                FirestoreService firestore =
                                    FirestoreService(uid: user!.uid);

                                firestore.updateArticleEachField(
                                  articleId: id,
                                  fieldName: 'title',
                                  data: value,
                                );
                              },
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'Created by ',
                                style: GoogleFonts.mulish(
                                  color: CusColors.inactive,
                                  fontSize: getValueForScreenType<double>(
                                    context: context,
                                    mobile: width * .019,
                                    tablet: width * .016,
                                    desktop: width * .011,
                                  ),
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  initialValue: article.createdBy ?? '',
                                  style: GoogleFonts.mulish(
                                    color: CusColors.inactive,
                                    fontSize: getValueForScreenType<double>(
                                      context: context,
                                      mobile: width * .019,
                                      tablet: width * .016,
                                      desktop: width * .011,
                                    ),
                                    fontWeight: FontWeight.w300,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.zero,
                                    hintText: 'Input who created',
                                    hintStyle: GoogleFonts.mulish(
                                      color: CusColors.inactive,
                                      fontSize: getValueForScreenType<double>(
                                        context: context,
                                        mobile: width * .019,
                                        tablet: width * .016,
                                        desktop: width * .011,
                                      ),
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  keyboardType: TextInputType.text,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'Enter an author';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    FirestoreService firestore =
                                        FirestoreService(uid: user!.uid);

                                    firestore.updateArticleEachField(
                                      articleId: id,
                                      fieldName: 'created_by',
                                      data: value,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () => _selectDate(context),
                            child: TextFormField(
                              controller: _dateController,
                              enabled: false,
                              style: GoogleFonts.mulish(
                                color: CusColors.inactive,
                                fontSize: getValueForScreenType<double>(
                                  context: context,
                                  mobile: width * .019,
                                  tablet: width * .016,
                                  desktop: width * .011,
                                ),
                                fontWeight: FontWeight.w300,
                              ),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                                hintText: 'Select date',
                                hintStyle: GoogleFonts.mulish(
                                  color: CusColors.inactive,
                                  fontSize: getValueForScreenType<double>(
                                    context: context,
                                    mobile: width * .019,
                                    tablet: width * .016,
                                    desktop: width * .011,
                                  ),
                                  fontWeight: FontWeight.w300,
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
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            width: double.infinity,
                            height: 1,
                            color: CusColors.accentBlue,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: image != null
                                ? GestureDetector(
                                    onTap: selectImageFromGallery,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Image.memory(image!,
                                                height: getValueForScreenType<
                                                    double>(
                                                  context: context,
                                                  mobile: height / 3.7,
                                                  tablet: height / 2.7,
                                                  desktop: height / 1.6,
                                                )),
                                            if (showSave)
                                              Container(
                                                width: width * .09,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFF00C8FF),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            80),
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
                                                  onPressed: loading
                                                      ? null
                                                      : () async {
                                                          await deleteExistingPhoto();
                                                          await uploadToFirebase(
                                                              image);
                                                          FirestoreService
                                                              firestore =
                                                              FirestoreService(
                                                                  uid: user!
                                                                      .uid);
                                                          firestore
                                                              .updateArticleEachField(
                                                                  articleId: id,
                                                                  fieldName:
                                                                      'image',
                                                                  data:
                                                                      downloadURL);
                                                        },
                                                  style: ButtonStyle(
                                                    shape: MaterialStateProperty
                                                        .all<
                                                            RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                    ),
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors
                                                                .transparent),
                                                    shadowColor:
                                                        MaterialStateProperty
                                                            .all(Colors
                                                                .transparent),
                                                  ),
                                                  child: loading
                                                      ? const CircularProgressIndicator()
                                                      : Text(
                                                          'Save Image',
                                                          style: GoogleFonts
                                                              .mulish(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors.white,
                                                            fontSize:
                                                                width * 0.01,
                                                          ),
                                                        ),
                                                ),
                                              ),
                                          ],
                                        )),
                                  )
                                : article.image != ''
                                    ? GestureDetector(
                                        onTap: selectImageFromGallery,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: FadeInImage.memoryNetwork(
                                            placeholder: kTransparentImage,
                                            image: article.image!,
                                            height:
                                                getValueForScreenType<double>(
                                              context: context,
                                              mobile: height / 3.7,
                                              tablet: height / 2.7,
                                              desktop: height / 1.6,
                                            ),
                                          ),
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: selectImageFromGallery,
                                        child: Container(
                                          width: 300,
                                          height: 300,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey,
                                                  style: BorderStyle.solid),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: const Icon(
                                            Icons.camera_alt_outlined,
                                            color: Colors.grey,
                                            size: 72,
                                          ),
                                        ),
                                      ),
                          ),
                          TextFormField(
                            initialValue: article.description ?? '',
                            maxLines: null,
                            textInputAction: TextInputAction.newline,
                            style: GoogleFonts.mulish(
                              color: CusColors.inactive,
                              fontSize: getValueForScreenType<double>(
                                context: context,
                                mobile: width * .02,
                                tablet: width * .017,
                                desktop: width * .012,
                              ),
                              fontWeight: FontWeight.w300,
                              height: 1.5,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              hintText: 'Input an description',
                              hintStyle: GoogleFonts.mulish(
                                color: CusColors.inactive,
                                fontSize: getValueForScreenType<double>(
                                  context: context,
                                  mobile: width * .02,
                                  tablet: width * .017,
                                  desktop: width * .012,
                                ),
                                fontWeight: FontWeight.w300,
                                height: 1.5,
                              ),
                            ),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Enter an description';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              FirestoreService firestore =
                                  FirestoreService(uid: user!.uid);

                              firestore.updateArticleEachField(
                                articleId: id,
                                fieldName: 'description',
                                data: value,
                              );
                            },
                          ),
                          if (articleContents != null &&
                              articleContents!.isNotEmpty)
                            ArticleContentWidget(
                              articleContent: articleContents!,
                              id: id,
                            ),
                          if (articleContents == null)
                            Container(
                              width: width * .09,
                              height: 40,
                              margin: const EdgeInsets.only(top: 20),
                              decoration: BoxDecoration(
                                  color: const Color(0xFF00C8FF),
                                  borderRadius: BorderRadius.circular(80),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(.25),
                                        spreadRadius: 0,
                                        blurRadius: 20,
                                        offset: const Offset(0, 4))
                                  ]),
                              child: ElevatedButton(
                                onPressed: () async {
                                  FirestoreService firestore =
                                      FirestoreService(uid: user!.uid);

                                  setState(() {
                                    articleContents = [
                                      ArticleContent(
                                        articleId: 1,
                                        subTitle: '',
                                        subTitleDescription: '',
                                        textUnderList: '',
                                        bulletList: [],
                                      )
                                    ];
                                  });
                                  await firestore.updateArticleEachField(
                                    articleId: id,
                                    fieldName: 'article_content',
                                    data: [
                                      ArticleContent(
                                        articleId: 1,
                                        subTitle: '',
                                        subTitleDescription: '',
                                        textUnderList: '',
                                        bulletList: [],
                                      )
                                    ],
                                  );
                                },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  shadowColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                ),
                                child: Text(
                                  'Add content',
                                  style: GoogleFonts.mulish(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: width * 0.01,
                                  ),
                                ),
                              ),
                            ),
                          const SizedBox(
                            height: 100,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 40, right: 100),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (article.isDraft != false)
                                  SizedBox(
                                    height: getValueForScreenType<double>(
                                      context: context,
                                      mobile: 26,
                                      tablet: 33,
                                      desktop: 38,
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        Get.to(
                                            () => DashboardAdmin(
                                                  selected: 'Articles',
                                                ),
                                            routeName: '/login');
                                      },
                                      style: ButtonStyle(
                                          padding: MaterialStateProperty.all(
                                            EdgeInsets.symmetric(
                                              horizontal:
                                                  getValueForScreenType<double>(
                                                context: context,
                                                mobile: 20,
                                                tablet: 25,
                                                desktop: 30,
                                              ),
                                            ),
                                          ),
                                          foregroundColor:
                                              MaterialStateProperty.all(
                                            const Color.fromARGB(
                                                255, 23, 221, 1),
                                          ),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                            const Color.fromARGB(
                                                255, 23, 221, 1),
                                          ),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                          )),
                                      child: Text(
                                        'Save as draft',
                                        style: GoogleFonts.poppins(
                                          fontSize:
                                              getValueForScreenType<double>(
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
                                        if (article.isDraft!) {
                                          await firestore.updateCourseEachField(
                                              courseId: id,
                                              fieldName: 'is_draft',
                                              data: false);
                                        }

                                        Get.to(
                                            () => DashboardAdmin(
                                                  selected: 'Articles',
                                                ),
                                            routeName: '/login');
                                      }
                                    },
                                    style: ButtonStyle(
                                        padding: MaterialStateProperty.all(
                                          EdgeInsets.symmetric(
                                            horizontal:
                                                getValueForScreenType<double>(
                                              context: context,
                                              mobile: 20,
                                              tablet: 25,
                                              desktop: 30,
                                            ),
                                          ),
                                        ),
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                          const Color(0xFF4351FF),
                                        ),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          const Color(0xFF4351FF),
                                        ),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        )),
                                    child: Text(
                                      article.isDraft! ? 'Publish' : 'Save',
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
                              ],
                            ),
                          )
                        ],
                      );
                    })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ArticleContentWidget extends StatefulWidget {
  final List<ArticleContent> articleContent;
  final String id;
  const ArticleContentWidget({
    super.key,
    required this.articleContent,
    required this.id,
  });

  @override
  State<ArticleContentWidget> createState() => _ArticleContentWidgetState();
}

class _ArticleContentWidgetState extends State<ArticleContentWidget> {
  List<ArticleContent> editedContents = [];

  String imageUrl = '';
  bool showSave = true;
  bool loading = false;

  Uint8List? image;
  String? downloadURL;

  @override
  void initState() {
    editedContents = List.from(widget.articleContent);
    super.initState();
  }

  selectImageFromGallery() async {
    final picker = ImagePicker();
    XFile? imageFile = await picker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      var file = await imageFile.readAsBytes();
      setState(() {
        image = file;
        showSave = true;
      });
    }
  }

  Future<String?> uploadFile(Uint8List image) async {
    String postId = DateTime.now().millisecondsSinceEpoch.toString();
    var contentType = lookupMimeType('', headerBytes: image);

    Reference ref = FirebaseStorage.instance
        .ref()
        .child("article")
        .child("article_content")
        .child("post_$postId.jpg");
    await ref.putData(image, SettableMetadata(contentType: contentType));
    downloadURL = await ref.getDownloadURL();
    return downloadURL;
  }

  uploadToFirebase(image) async {
    await uploadFile(image).then((value) {
      setState(() {
        showSave = false;
      });
    }); // this will upload the file and store url in the variable 'url'
  }

  Future<void> deleteExistingPhoto() async {
    if (imageUrl != '' || downloadURL != null) {
      try {
        // Define a regular expression to match the filename
        RegExp regExp = RegExp(r'[^\/]+(?=\?)');

        // Use the regular expression to extract the filename
        String? fileUrl = regExp.firstMatch(downloadURL ?? imageUrl)?.group(0);

        String fileName =
            fileUrl!.replaceFirst("article%2Farticle_content%2F", "");

        // Create a reference to the previous image in Firebase Storage
        final storageRef = FirebaseStorage.instance
            .ref()
            .child("article")
            .child("article_content")
            .child(fileName);

        // Delete the previous image from Firebase Storage
        await storageRef.delete();
      } catch (e) {
        print('Error deleting previous image: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final user = Provider.of<UserModel?>(context);

    return Column(
      children: List.generate(editedContents.length, (index) {
        bool isLastIndex = index == editedContents.length - 1;
        final ArticleContent content = editedContents[index];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: getValueForScreenType<double>(
                  context: context,
                  mobile: 15,
                  tablet: 20,
                  desktop: 40,
                ),
                bottom: getValueForScreenType<double>(
                  context: context,
                  mobile: 8,
                  tablet: 10,
                  desktop: 20,
                ),
              ),
              child: TextFormField(
                initialValue: content.subTitle ?? '',
                maxLines: null,
                textInputAction: TextInputAction.newline,
                style: GoogleFonts.mulish(
                    color: CusColors.header,
                    fontSize: getValueForScreenType<double>(
                      context: context,
                      mobile: width * .024,
                      tablet: width * .021,
                      desktop: width * .016,
                    ),
                    fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  hintText: 'Input an sub title',
                  hintStyle: GoogleFonts.mulish(
                      color: CusColors.header,
                      fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .024,
                        tablet: width * .021,
                        desktop: width * .016,
                      ),
                      fontWeight: FontWeight.bold),
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Enter an sub title';
                  }
                  return null;
                },
                onChanged: (value) {
                  FirestoreService firestore = FirestoreService(uid: user!.uid);

                  content.subTitle = value;

                  firestore.updateArticleEachField(
                    articleId: widget.id,
                    fieldName: 'article_content',
                    data: editedContents,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: image != null
                  ? Row(
                      children: [
                        GestureDetector(
                          onTap: selectImageFromGallery,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.memory(
                                    image!,
                                    height: getValueForScreenType<double>(
                                      context: context,
                                      mobile: height / 4.6,
                                      tablet: height / 3.6,
                                      desktop: height / 2.5,
                                    ),
                                  ),
                                  if (showSave)
                                    Container(
                                      width: width * .09,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF00C8FF),
                                          borderRadius:
                                              BorderRadius.circular(80),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(.25),
                                                spreadRadius: 0,
                                                blurRadius: 20,
                                                offset: const Offset(0, 4))
                                          ]),
                                      child: ElevatedButton(
                                        onPressed: loading
                                            ? null
                                            : () async {
                                                setState(() {
                                                  loading = true;
                                                });
                                                await deleteExistingPhoto();
                                                await uploadToFirebase(image);
                                                FirestoreService firestore =
                                                    FirestoreService(
                                                        uid: user!.uid);
                                                content.image = downloadURL;
                                                await firestore
                                                    .updateArticleEachField(
                                                        articleId: widget.id,
                                                        fieldName:
                                                            'article_content',
                                                        data: editedContents);
                                                setState(() {
                                                  loading = false;
                                                });
                                              },
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent),
                                          shadowColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent),
                                        ),
                                        child: loading
                                            ? const CircularProgressIndicator()
                                            : Text(
                                                'Save Image',
                                                style: GoogleFonts.mulish(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                  fontSize: width * 0.01,
                                                ),
                                              ),
                                      ),
                                    ),
                                ],
                              )),
                        ),
                        if (!showSave)
                          Container(
                            width: width * .09,
                            height: 40,
                            margin: const EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 232, 34, 34),
                                borderRadius: BorderRadius.circular(80),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(.25),
                                      spreadRadius: 0,
                                      blurRadius: 20,
                                      offset: const Offset(0, 4))
                                ]),
                            child: ElevatedButton(
                              onPressed: loading
                                  ? null
                                  : () async {
                                      setState(() {
                                        loading = true;
                                      });
                                      await deleteExistingPhoto();
                                      FirestoreService firestore =
                                          FirestoreService(uid: user!.uid);
                                      content.image = null;
                                      await firestore.updateArticleEachField(
                                        articleId: widget.id,
                                        fieldName: 'article_content',
                                        data: editedContents,
                                      );
                                      setState(() {
                                        image = null;
                                        loading = false;
                                      });
                                    },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                shadowColor: MaterialStateProperty.all(
                                    Colors.transparent),
                              ),
                              child: loading
                                  ? const CircularProgressIndicator()
                                  : Text(
                                      'Delete Image',
                                      style: GoogleFonts.mulish(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                        fontSize: width * 0.01,
                                      ),
                                    ),
                            ),
                          ),
                      ],
                    )
                  : editedContents[index].image != null
                      ? Row(
                          children: [
                            GestureDetector(
                              onTap: selectImageFromGallery,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image: content.image!,
                                  height: getValueForScreenType<double>(
                                    context: context,
                                    mobile: height / 4.6,
                                    tablet: height / 3.6,
                                    desktop: height / 2.5,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: width * .09,
                              height: 40,
                              margin: const EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 232, 34, 34),
                                  borderRadius: BorderRadius.circular(80),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(.25),
                                        spreadRadius: 0,
                                        blurRadius: 20,
                                        offset: const Offset(0, 4))
                                  ]),
                              child: ElevatedButton(
                                onPressed: loading
                                    ? null
                                    : () async {
                                        setState(() {
                                          loading = true;
                                        });
                                        await deleteExistingPhoto();
                                        FirestoreService firestore =
                                            FirestoreService(uid: user!.uid);
                                        content.image = null;
                                        await firestore.updateArticleEachField(
                                          articleId: widget.id,
                                          fieldName: 'article_content',
                                          data: editedContents,
                                        );
                                        setState(() {
                                          loading = false;
                                        });
                                      },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  shadowColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                ),
                                child: loading
                                    ? const CircularProgressIndicator()
                                    : Text(
                                        'Delete Image',
                                        style: GoogleFonts.mulish(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                          fontSize: width * 0.01,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        )
                      : GestureDetector(
                          onTap: selectImageFromGallery,
                          child: Container(
                            width: 300,
                            height: 300,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.grey,
                                  size: 72,
                                ),
                                Text(
                                  'Image is optional',
                                  style: GoogleFonts.mulish(
                                      color: CusColors.inactive,
                                      fontSize: getValueForScreenType<double>(
                                        context: context,
                                        mobile: width * .02,
                                        tablet: width * .017,
                                        desktop: width * .012,
                                      ),
                                      fontWeight: FontWeight.w300,
                                      height: 1.5),
                                )
                              ],
                            ),
                          ),
                        ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: TextFormField(
                initialValue: content.subTitleDescription ?? '',
                maxLines: null,
                textInputAction: TextInputAction.newline,
                style: GoogleFonts.mulish(
                    color: CusColors.inactive,
                    fontSize: getValueForScreenType<double>(
                      context: context,
                      mobile: width * .02,
                      tablet: width * .017,
                      desktop: width * .012,
                    ),
                    fontWeight: FontWeight.w300,
                    height: 1.5),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  hintText: 'Input an sub title description',
                  hintStyle: GoogleFonts.mulish(
                      color: CusColors.inactive,
                      fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .02,
                        tablet: width * .017,
                        desktop: width * .012,
                      ),
                      fontWeight: FontWeight.w300,
                      height: 1.5),
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Enter an sub title description';
                  }
                  return null;
                },
                onChanged: (value) {
                  FirestoreService firestore = FirestoreService(uid: user!.uid);

                  content.subTitleDescription = value;

                  firestore.updateArticleEachField(
                    articleId: widget.id,
                    fieldName: 'article_content',
                    data: editedContents,
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: width,
              child: Container(
                alignment: Alignment.centerLeft,
                width: width / 1.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: content.bulletList!.isNotEmpty
                      ? content.bulletList!.asMap().entries.map((entry) {
                          int subIndex = entry.key;
                          String str = entry.value;
                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '\u2022',
                                  style: GoogleFonts.mulish(
                                    color: CusColors.inactive,
                                    fontWeight: FontWeight.w300,
                                    fontSize: getValueForScreenType<double>(
                                      context: context,
                                      mobile: width * .02,
                                      tablet: width * .017,
                                      desktop: width * .012,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Container(
                                    child: TextFormField(
                                      key: ValueKey(
                                          content.bulletList![subIndex]),
                                      initialValue: str,
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.mulish(
                                        color: CusColors.inactive,
                                        fontWeight: FontWeight.w300,
                                        fontSize: getValueForScreenType<double>(
                                          context: context,
                                          mobile: width * .02,
                                          tablet: width * .017,
                                          desktop: width * .012,
                                        ),
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText:
                                            'Enter a bullet list (Optional)',
                                        hintStyle: GoogleFonts.mulish(
                                          color: CusColors.inactive,
                                          fontSize:
                                              getValueForScreenType<double>(
                                            context: context,
                                            mobile: width * .02,
                                            tablet: width * .017,
                                            desktop: width * .012,
                                          ),
                                          fontWeight: FontWeight.w300,
                                          height: 1.5,
                                        ),
                                      ),
                                      keyboardType: TextInputType.text,
                                      onChanged: (value) {
                                        FirestoreService firestore =
                                            FirestoreService(uid: user!.uid);
                                        content.bulletList![subIndex] = value;
                                        firestore.updateArticleEachField(
                                          articleId: widget.id,
                                          fieldName: 'article_content',
                                          data: editedContents,
                                        );
                                      },
                                      onFieldSubmitted: (value) {
                                        setState(() {
                                          content.bulletList!.add('');
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        content.bulletList!.add('');
                                      });
                                    },
                                    child: const Icon(IconlyLight.plus),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    FirestoreService firestore =
                                        FirestoreService(uid: user!.uid);
                                    setState(() {
                                      content.bulletList!.removeAt(subIndex);
                                    });
                                    firestore.updateArticleEachField(
                                      articleId: widget.id,
                                      fieldName: 'article_content',
                                      data: editedContents,
                                    );
                                  },
                                  child: const Icon(IconlyLight.delete),
                                )
                              ],
                            ),
                          );
                        }).toList()
                      : [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '\u2022',
                                  style: GoogleFonts.mulish(
                                    color: CusColors.inactive,
                                    fontWeight: FontWeight.w300,
                                    fontSize: getValueForScreenType<double>(
                                      context: context,
                                      mobile: width * .02,
                                      tablet: width * .017,
                                      desktop: width * .012,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Container(
                                    child: TextFormField(
                                      initialValue: null,
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.mulish(
                                        color: CusColors.inactive,
                                        fontWeight: FontWeight.w300,
                                        fontSize: getValueForScreenType<double>(
                                          context: context,
                                          mobile: width * .02,
                                          tablet: width * .017,
                                          desktop: width * .012,
                                        ),
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText:
                                            'Enter a bullet list (Optional)',
                                        hintStyle: GoogleFonts.mulish(
                                          color: CusColors.inactive,
                                          fontSize:
                                              getValueForScreenType<double>(
                                            context: context,
                                            mobile: width * .02,
                                            tablet: width * .017,
                                            desktop: width * .012,
                                          ),
                                          fontWeight: FontWeight.w300,
                                          height: 1.5,
                                        ),
                                      ),
                                      keyboardType: TextInputType.text,
                                      onChanged: (value) {
                                        FirestoreService firestore =
                                            FirestoreService(uid: user!.uid);
                                        setState(() {
                                          content.bulletList = [value];
                                        });
                                        firestore.updateArticleEachField(
                                          articleId: widget.id,
                                          fieldName: 'article_content',
                                          data: editedContents,
                                        );
                                      },
                                      onFieldSubmitted: (value) {
                                        setState(() {
                                          content.bulletList!.add('');
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: TextFormField(
                initialValue: content.textUnderList ?? '',
                maxLines: null,
                textInputAction: TextInputAction.newline,
                style: GoogleFonts.mulish(
                    color: CusColors.inactive,
                    fontSize: getValueForScreenType<double>(
                      context: context,
                      mobile: width * .02,
                      tablet: width * .017,
                      desktop: width * .012,
                    ),
                    fontWeight: FontWeight.w300,
                    height: 1.5),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  hintText: 'Enter an text under list (Optional)',
                  hintStyle: GoogleFonts.mulish(
                      color: CusColors.inactive,
                      fontSize: getValueForScreenType<double>(
                        context: context,
                        mobile: width * .02,
                        tablet: width * .017,
                        desktop: width * .012,
                      ),
                      fontWeight: FontWeight.w300,
                      height: 1.5),
                ),
                onChanged: (value) {
                  FirestoreService firestore = FirestoreService(uid: user!.uid);

                  content.textUnderList = value;

                  firestore.updateArticleEachField(
                    articleId: widget.id,
                    fieldName: 'article_content',
                    data: editedContents,
                  );
                },
              ),
            ),
            if (isLastIndex)
              Container(
                width: width * .09,
                height: 40,
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    color: const Color(0xFF00C8FF),
                    borderRadius: BorderRadius.circular(80),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(.25),
                          spreadRadius: 0,
                          blurRadius: 20,
                          offset: const Offset(0, 4))
                    ]),
                child: ElevatedButton(
                  onPressed: () async {
                    FirestoreService firestore =
                        FirestoreService(uid: user!.uid);

                    setState(() {
                      editedContents.add(ArticleContent(
                        articleId: index + 1,
                        subTitle: '',
                        subTitleDescription: '',
                        textUnderList: '',
                        bulletList: [],
                      ));
                    });
                    await firestore.updateArticleEachField(
                        articleId: widget.id,
                        fieldName: 'article_content',
                        data: editedContents);
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                    shadowColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  child: Text(
                    'Add content',
                    style: GoogleFonts.mulish(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: width * 0.01,
                    ),
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
}