import 'package:flutter/material.dart';

class Textfields extends StatelessWidget {
  final String placeholder;
  final double containWidth;
  final String fieldDescription;
  TextEditingController controller;
  FormFieldValidator validator;
  Textfields({super.key, required this.placeholder, required this.containWidth, required this.fieldDescription, required this.validator, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: containWidth,
      
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [ 
        Text(fieldDescription,
        style: const TextStyle(
          fontFamily: "Lexend",
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        )),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: controller,
          validator: validator,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w100, color: Colors.black,),
        decoration: InputDecoration(
                    hintText: placeholder,
                    //focusColor: Colors.amber,
                    focusedBorder: //InputBorder.none,
                    OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.amber)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Color.fromARGB(255, 228, 226, 226))
                    ), 
                    contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  ),
      )]
      )
    );
  }
}