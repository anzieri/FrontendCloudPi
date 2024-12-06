import "package:flutter/material.dart";

class GestureButton extends StatelessWidget {
  final String describe;
  final bool clicked;
  //final String navigationPath;
  final VoidCallback tapped;
  //VoidCallback onTap;

  const GestureButton({super.key, required this.describe, required this.clicked, required this.tapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      
        onTap: tapped,
        child: Container(
        margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: (clicked)? Colors.black : const Color.fromARGB(0, 231, 231, 231),
            ),
        child: Text(describe,
        style: TextStyle(
          color: (clicked)? Colors.white: Colors.black,
        ),),
      ),
      
      
      );
  }
}
