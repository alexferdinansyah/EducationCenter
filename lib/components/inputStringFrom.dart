import 'package:flutter/material.dart';

class InputStringForm extends StatelessWidget {
  final String label;
  final Function(String) onSaved;

  const InputStringForm(
      {super.key, required this.label, required this.onSaved});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey), // Grey border
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none, // Remove default border
          labelText: label,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter the $label';
          }
          return null;
        },
        onSaved: (newValue) {
          onSaved(newValue ?? '');
        },
      ),
    );
  }
}
