import 'package:flutter/material.dart';

class DripDown extends StatelessWidget {
  final String label;
  final List<String> items;
  final String? value;
  final Function(String?) onChanged;
  final Function(String?) validator;
  final Icon icon;
  const DripDown({super.key, required this.label, required this.items, required this.value, required this.onChanged, required this.validator,required this.icon});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      //disabledHint: Text(value ?? ''),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: Colors.black54,
          fontFamily: 'Poppins',
          fontSize: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.amber, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
      //icon: const Icon(Icons.arrow_drop_down, color: Colors.amber),
      dropdownColor: Colors.white,
      icon: icon,
      //const Icon(Icons.more_vert, color: Colors.amber),
      style: const TextStyle(
        color: Colors.black87,
        fontSize: 16,
        fontFamily: 'Poppins',
      ),
      value: value,
      items: items
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e),
              ))
          .toList(),
      onChanged: onChanged,
      validator: (value) => validator(value) as String?,
    );
  }
}
