import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/models/course.dart';
import 'package:project_tc/services/firestore_service.dart';
import 'package:responsive_builder/responsive_builder.dart';

class BulletList extends StatelessWidget {
  final List<String> strings;
  final bool border;
  final double padding;
  final Color textColor;
  final FontWeight fontWeight;
  final double fontSize;

  const BulletList(this.strings,
      {super.key,
      required this.border,
      this.padding = 5,
      this.textColor = const Color(0xFF676767),
      this.fontWeight = FontWeight.w500,
      required this.fontSize});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.centerLeft,
      width: border
          ? width / 1.7
          : getValueForScreenType<double>(
              context: context,
              mobile: width * .3,
              tablet: width * .18,
              desktop: width * .13,
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: strings.map((str) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: padding),
            decoration: BoxDecoration(
              border: border
                  ? Border(
                      bottom: BorderSide(
                        color: CusColors.accentBlue,
                        width: 1,
                      ),
                    )
                  : const Border(
                      bottom: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    )),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (str != '')
                  Text(
                    '\u2022',
                    style: GoogleFonts.mulish(
                      color: textColor,
                      fontSize: width * .012,
                      fontWeight: fontWeight,
                    ),
                  ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      str,
                      textAlign: TextAlign.left,
                      softWrap: true,
                      style: GoogleFonts.mulish(
                        color: textColor,
                        fontSize: fontSize,
                        fontWeight: fontWeight,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class BorderList extends StatefulWidget {
  final List<ChapterList> chapterList;
  final double padding;
  final double subPadding;
  final Color textColor;
  final FontWeight fontWeight;
  final double fontSize;
  final double subFontSize;

  const BorderList({
    required this.chapterList,
    this.padding = 5,
    this.subPadding = 15,
    this.textColor = const Color(0xFF676767),
    this.fontWeight = FontWeight.w500,
    required this.fontSize,
    required this.subFontSize,
    Key? key,
  }) : super(key: key);

  @override
  State<BorderList> createState() => _BorderListState();
}

class _BorderListState extends State<BorderList> {
  Map<int, bool> expandStates = {}; // Store expand states for each item
  Map<int, bool> canExpand = {};

  @override
  void initState() {
    super.initState();

    // Initialize expandStates with default values for all indices
    for (int i = 0; i < widget.chapterList.length; i++) {
      expandStates[i] = false;
      if (widget.chapterList[i].subChapter!.isNotEmpty) {
        // Set the expand state to true for items that meet the condition
        canExpand[i] = true;
      } else {
        // Set the expand state to false for other items
        canExpand[i] = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.centerLeft,
      width: width / 1.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(widget.chapterList.length, (index) {
          final String chapter = widget.chapterList[index].chapter!;
          final List<String> subChapter = widget.chapterList[index].subChapter!;

          return canExpand[index]!
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      // Toggle the expand state for this item
                      expandStates[index] = !expandStates[index]!;
                    });
                  },
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.fastLinearToSlowEaseIn,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: widget.padding),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: CusColors.accentBlue,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: widget.padding),
                                  child: Text(
                                    chapter,
                                    textAlign: TextAlign.left,
                                    softWrap: true,
                                    style: GoogleFonts.mulish(
                                      color: expandStates[index]!
                                          ? CusColors.accentBlue
                                          : CusColors.subHeader,
                                      fontSize: widget.fontSize,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              expandStates[index]!
                                  ? const Icon(Icons.keyboard_arrow_up)
                                  : const Icon(Icons.keyboard_arrow_down)
                            ],
                          ),
                          if (expandStates[index]!)
                            Padding(
                              padding: EdgeInsets.only(
                                  top: widget.subPadding,
                                  left: widget.subPadding),
                              child: BulletList(
                                subChapter,
                                border: false,
                                padding: 2,
                                fontSize: widget.subFontSize,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                )
              : Container(
                  padding: EdgeInsets.symmetric(vertical: widget.padding),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: CusColors.accentBlue,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: widget.padding),
                              child: Text(
                                chapter,
                                textAlign: TextAlign.left,
                                softWrap: true,
                                style: GoogleFonts.mulish(
                                  color: CusColors.subHeader,
                                  fontSize: widget.fontSize,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
        }),
      ),
    );
  }
}

class BulletFormList extends StatefulWidget {
  final List<String> strings;
  final double padding;
  final Color textColor;
  final FontWeight fontWeight;
  final double fontSize;
  final String uid;
  final String courseId;

  const BulletFormList(this.strings,
      {super.key,
      this.padding = 5,
      this.textColor = const Color(0xFF676767),
      this.fontWeight = FontWeight.w500,
      required this.fontSize,
      required this.uid,
      required this.courseId});

  @override
  State<BulletFormList> createState() => _BulletFormListState();
}

class _BulletFormListState extends State<BulletFormList> {
  List<String> editedBenefits = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      editedBenefits = List.from(widget.strings);
    });
  }

  void deleteEditedList(int index, dynamic data) {
    setState(() {
      data.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.centerLeft,
      width: width / 1.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: editedBenefits.isNotEmpty
            ? editedBenefits.asMap().entries.map((entry) {
                int index = entry.key;
                String str = entry.value;
                return Container(
                  padding: EdgeInsets.symmetric(vertical: widget.padding),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: CusColors.accentBlue,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '\u2022',
                        style: GoogleFonts.mulish(
                          color: widget.textColor,
                          fontSize: width * .012,
                          fontWeight: widget.fontWeight,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Container(
                          child: TextFormField(
                            key: ValueKey(editedBenefits[index]),
                            initialValue: str,
                            textAlign: TextAlign.left,
                            style: GoogleFonts.mulish(
                              color: const Color(0xFF676767),
                              fontSize: widget.fontSize,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter a completion benefits',
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
                            keyboardType: TextInputType.text,
                            onChanged: (value) {
                              FirestoreService firestore =
                                  FirestoreService(uid: widget.uid);
                              editedBenefits[index] = value;
                              firestore.updateCourseEachField(
                                courseId: widget.courseId,
                                fieldName: 'completion_benefits',
                                data: editedBenefits,
                              );
                            },
                            onFieldSubmitted: (value) {
                              setState(() {
                                editedBenefits.add('');
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
                              editedBenefits.add('');
                            });
                          },
                          child: const Icon(IconlyLight.plus),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          FirestoreService firestore =
                              FirestoreService(uid: widget.uid);
                          setState(() {
                            editedBenefits.removeAt(index);
                          });
                          firestore.updateCourseEachField(
                            courseId: widget.courseId,
                            fieldName: 'completion_benefits',
                            data: editedBenefits,
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
                  padding: EdgeInsets.symmetric(vertical: widget.padding),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: CusColors.accentBlue,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '\u2022',
                        style: GoogleFonts.mulish(
                          color: widget.textColor,
                          fontSize: width * .012,
                          fontWeight: widget.fontWeight,
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
                              color: const Color(0xFF676767),
                              fontSize: widget.fontSize,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter a completion benefits',
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
                            keyboardType: TextInputType.text,
                            onChanged: (value) {
                              FirestoreService firestore =
                                  FirestoreService(uid: widget.uid);
                              setState(() {
                                editedBenefits = [value];
                              });
                              firestore.updateCourseEachField(
                                courseId: widget.courseId,
                                fieldName: 'completion_benefits',
                                data: editedBenefits,
                              );
                            },
                            onFieldSubmitted: (value) {
                              setState(() {
                                editedBenefits.add('');
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
    );
  }
}

class BorderFormList extends StatefulWidget {
  final List<ChapterList> chapterList;
  final double padding;
  final double subPadding;
  final Color textColor;
  final FontWeight fontWeight;
  final double fontSize;
  final double subFontSize;
  final String uid;
  final String courseId;

  const BorderFormList({
    required this.chapterList,
    this.padding = 5,
    this.subPadding = 15,
    this.textColor = const Color(0xFF676767),
    this.fontWeight = FontWeight.w500,
    required this.fontSize,
    required this.subFontSize,
    required this.uid,
    required this.courseId,
    Key? key,
  }) : super(key: key);

  @override
  State<BorderFormList> createState() => _BorderFormListState();
}

class _BorderFormListState extends State<BorderFormList> {
  Map<int, bool> expandStates = {}; // Store expand states for each item

  List<ChapterList> editedChapterList = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      editedChapterList = List.from(widget.chapterList);
    });

    // Initialize expandStates with default values for all indices
    for (int i = 0; i < editedChapterList.length; i++) {
      expandStates[i] = false;
    }
  }

  void deleteEditedList(int index, dynamic data) {
    setState(() {
      data.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.centerLeft,
      width: width / 1.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: editedChapterList.isEmpty
            ? [
                Container(
                  padding: EdgeInsets.symmetric(vertical: widget.padding),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: CusColors.accentBlue,
                        width: 1,
                      ),
                    ),
                  ),
                  child: SizedBox(
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding:
                                EdgeInsets.symmetric(vertical: widget.padding),
                            child: TextFormField(
                              initialValue: null,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.mulish(
                                color: CusColors.accentBlue,
                                fontSize: widget.fontSize,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                                hintText: 'Enter an chapter',
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
                              keyboardType: TextInputType.text,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Enter an chapter';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                FirestoreService firestore =
                                    FirestoreService(uid: widget.uid);
                                setState(() {
                                  editedChapterList.add(
                                    ChapterList(
                                      chapter: value,
                                      subChapter: [],
                                    ),
                                  );
                                });
                                firestore.updateCourseEachField(
                                  courseId: widget.courseId,
                                  fieldName: 'chapter_list',
                                  data: editedChapterList,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]
            : List.generate(editedChapterList.length, (index) {
                final String chapter = editedChapterList[index].chapter!;
                List<String> subChapter = editedChapterList[index].subChapter!;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      // Toggle the expand state for this item
                      expandStates[index] = !expandStates[index]!;
                    });
                  },
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.fastLinearToSlowEaseIn,
                    child: Container(
                      key: ValueKey(editedChapterList[index].chapter!),
                      padding: EdgeInsets.symmetric(vertical: widget.padding),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: CusColors.accentBlue,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: widget.padding),
                                    child: TextFormField(
                                      initialValue: chapter,
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.mulish(
                                        color: expandStates[index]!
                                            ? CusColors.accentBlue
                                            : CusColors.subHeader,
                                        fontSize: widget.fontSize,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.zero,
                                        hintText: 'Enter an chapter',
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
                                            height: 1.5),
                                      ),
                                      keyboardType: TextInputType.text,
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return 'Enter an chapter';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        FirestoreService firestore =
                                            FirestoreService(uid: widget.uid);
                                        editedChapterList[index].chapter =
                                            value;
                                        firestore.updateCourseEachField(
                                          courseId: widget.courseId,
                                          fieldName: 'chapter_list',
                                          data: editedChapterList,
                                        );
                                      },
                                      onFieldSubmitted: (value) {
                                        setState(() {
                                          editedChapterList.add(
                                            ChapterList(
                                              chapter: '',
                                              subChapter: [],
                                            ),
                                          );
                                          for (int i = 0;
                                              i < editedChapterList.length;
                                              i++) {
                                            expandStates[i] = false;
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                expandStates[index]!
                                    ? const Icon(Icons.keyboard_arrow_up)
                                    : const Icon(Icons.keyboard_arrow_down),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        editedChapterList.add(
                                          ChapterList(
                                            chapter: '',
                                            subChapter: [],
                                          ),
                                        );
                                        for (int i = 0;
                                            i < editedChapterList.length;
                                            i++) {
                                          expandStates[i] = false;
                                        }
                                      });
                                    },
                                    child: const Icon(IconlyLight.plus),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    FirestoreService firestore =
                                        FirestoreService(uid: widget.uid);
                                    deleteEditedList(index, editedChapterList);

                                    firestore.updateCourseEachField(
                                      courseId: widget.courseId,
                                      fieldName: 'chapter_list',
                                      data: editedChapterList,
                                    );
                                  },
                                  child: const Icon(IconlyLight.delete),
                                )
                              ],
                            ),
                          ),
                          if (expandStates[index]!)
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: subChapter.isNotEmpty
                                    ? subChapter.asMap().entries.map((entry) {
                                        int subIndex = entry.key;

                                        return Container(
                                          key: ValueKey(editedChapterList[index]
                                              .subChapter![subIndex]),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2),
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                            ),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                '\u2022',
                                                style: GoogleFonts.mulish(
                                                  color:
                                                      const Color(0xFF676767),
                                                  fontSize: width * .012,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              Expanded(
                                                child: Container(
                                                  child: TextFormField(
                                                    initialValue:
                                                        subChapter[subIndex],
                                                    textAlign: TextAlign.left,
                                                    style: GoogleFonts.mulish(
                                                      color: const Color(
                                                          0xFF676767),
                                                      fontSize:
                                                          widget.subFontSize,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText:
                                                          'Enter a subchapter',
                                                      hintStyle:
                                                          GoogleFonts.mulish(
                                                        color:
                                                            CusColors.inactive,
                                                        fontSize:
                                                            getValueForScreenType<
                                                                double>(
                                                          context: context,
                                                          mobile: width * .02,
                                                          tablet: width * .017,
                                                          desktop: width * .012,
                                                        ),
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        height: 1.5,
                                                      ),
                                                    ),
                                                    keyboardType:
                                                        TextInputType.text,
                                                    onChanged: (value) {
                                                      FirestoreService
                                                          firestore =
                                                          FirestoreService(
                                                              uid: widget.uid);
                                                      subChapter[subIndex] =
                                                          value;
                                                      firestore
                                                          .updateCourseEachField(
                                                        courseId:
                                                            widget.courseId,
                                                        fieldName:
                                                            'chapter_list',
                                                        data: editedChapterList,
                                                      );
                                                    },
                                                    onFieldSubmitted: (value) {
                                                      setState(() {
                                                        subChapter.add('');
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 5),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      subChapter.add('');
                                                    });
                                                  },
                                                  child: const Icon(
                                                      IconlyLight.plus),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  FirestoreService firestore =
                                                      FirestoreService(
                                                          uid: widget.uid);

                                                  deleteEditedList(
                                                      subIndex, subChapter);

                                                  firestore
                                                      .updateCourseEachField(
                                                    courseId: widget.courseId,
                                                    fieldName: 'chapter_list',
                                                    data: editedChapterList,
                                                  );
                                                },
                                                child: const Icon(
                                                    IconlyLight.delete),
                                              )
                                            ],
                                          ),
                                        );
                                      }).toList()
                                    : [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2),
                                          decoration: const BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            )),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                '\u2022',
                                                style: GoogleFonts.mulish(
                                                  color:
                                                      const Color(0xFF676767),
                                                  fontSize: width * .012,
                                                  fontWeight: FontWeight.w500,
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
                                                      color: const Color(
                                                          0xFF676767),
                                                      fontSize:
                                                          widget.subFontSize,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText:
                                                          'Enter an sub chapter',
                                                      hintStyle:
                                                          GoogleFonts.mulish(
                                                              color: CusColors
                                                                  .inactive,
                                                              fontSize:
                                                                  getValueForScreenType<
                                                                      double>(
                                                                context:
                                                                    context,
                                                                mobile:
                                                                    width * .02,
                                                                tablet: width *
                                                                    .017,
                                                                desktop: width *
                                                                    .012,
                                                              ),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              height: 1.5),
                                                    ),
                                                    keyboardType:
                                                        TextInputType.text,
                                                    onChanged: (value) {
                                                      FirestoreService
                                                          firestore =
                                                          FirestoreService(
                                                              uid: widget.uid);
                                                      setState(() {
                                                        editedChapterList[index]
                                                            .subChapter = [
                                                          value
                                                        ];
                                                      });
                                                      firestore
                                                          .updateCourseEachField(
                                                        courseId:
                                                            widget.courseId,
                                                        fieldName:
                                                            'chapter_list',
                                                        data: editedChapterList,
                                                      );
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
                        ],
                      ),
                    ),
                  ),
                );
              }),
      ),
    );
  }
}
