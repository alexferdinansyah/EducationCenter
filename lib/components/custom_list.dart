import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/constants.dart';
import 'package:project_tc/models/course.dart';
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
