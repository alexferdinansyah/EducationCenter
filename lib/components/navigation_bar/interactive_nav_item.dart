import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_tc/components/constants.dart';
import 'package:universal_html/html.dart' as html;

class InteractiveNavItem extends MouseRegion {
  static final appContainer =
      html.window.document.querySelectorAll('flt-glass-pane')[0];

  InteractiveNavItem(
      {super.key,
      required String text,
      required String routeName,
      required bool selected})
      : super(
          onHover: (PointerHoverEvent evt) {
            appContainer.style.cursor = 'pointer';
          },
          onExit: (PointerExitEvent evt) {
            appContainer.style.cursor = 'default';
          },
          child: InteractiveText(
            text: text,
            routeName: routeName,
            selected: selected,
          ),
        );
}

class InteractiveText extends StatefulWidget {
  final String text;
  final String routeName;
  final bool selected;

  const InteractiveText({
    super.key,
    required this.text,
    required this.routeName,
    required this.selected,
  });

  @override
  InteractiveTextState createState() => InteractiveTextState();
}

class InteractiveTextState extends State<InteractiveText> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return MouseRegion(
        onHover: (_) => _hovered(true),
        onExit: (_) => _hovered(false),
        child: Text(widget.text,
            style: GoogleFonts.mulish(
              color: _hovering
                  ? CusColors.subHeader.withOpacity(0.5)
                  : (widget.selected)
                      ? CusColors.subHeader.withOpacity(0.5)
                      : CusColors.inactive.withOpacity(0.4),
              fontSize: width * 0.01,
              fontWeight: FontWeight.bold,
            )));
  }

  _hovered(bool hovered) {
    setState(() {
      _hovering = hovered;
    });
  }
}
