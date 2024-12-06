import 'package:flutter/material.dart';

class NavButtons extends StatelessWidget {
  final String btnName;
  final Color colour;
  final double containWidth;
  final double containHeight;
  final double radius;
  final VoidCallback onPressed;
  final Color textcolour;
  final Color bordercolour;
  const NavButtons(
      {super.key,
      required this.btnName,required this.colour,required this.textcolour,
      required this.bordercolour, required this.containWidth,required this.containHeight,
      required this.radius,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    // Calculate text width
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: btnName,
        style: TextStyle(
          fontFamily: "Lexend",
          fontSize: 30,
          fontWeight: FontWeight.w300,
        ),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();

    // Add padding to text width
    double calculatedWidth = textPainter.width + 40; // 20px padding on each side

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
        height: containHeight,
        constraints: BoxConstraints(
          minWidth: 100,
          maxWidth: 260,
          minHeight: 80,
          maxHeight: 80,
        ),
        width: calculatedWidth.clamp(100.0, 260.0), // Clamp between min and max
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(width: 2, color: bordercolour)
        ),
        child: Center(
          child: Text(
            btnName,
            style: TextStyle(
              fontFamily: "Lexend",
              fontSize: 30,
              fontWeight: FontWeight.w300,
              color: textcolour,
            ),
          ),
        )
      )
    );
  }
}
