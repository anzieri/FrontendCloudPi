import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  final String btnName;
  final Color colour;
  final double containWidth;
  final double containHeight;
  final double radius;
  final VoidCallback onPressed;
  final Color textcolour;
  final Color bordercolour;
  const Buttons(
      {super.key,
      required this.btnName,required this.colour,required this.textcolour,
      required this.bordercolour, required this.containWidth,required this.containHeight,
      required this.radius,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Container(
            padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
            width: containWidth,
            height: containHeight,
            decoration: BoxDecoration(
                color: colour,
                borderRadius: BorderRadius.circular(radius),
                border: Border.all(width: 2, color: bordercolour)),
            child: Center(
              child: Text(
                btnName,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: textcolour,
                ),
              ),
            )));
  }
}
