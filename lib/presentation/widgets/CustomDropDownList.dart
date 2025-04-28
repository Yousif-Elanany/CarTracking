import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String hint;
  final T? value;
  final List<T> items;
  final String Function(T) itemAsString;
  final Function(T?) onChanged;

  const CustomDropdown({
    required this.hint,
    required this.value,
    required this.items,
    required this.itemAsString,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<T>(
        value: value,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(),
        ),
        items: items
            .map((item) => DropdownMenuItem<T>(
          value: item,
          child: Text(itemAsString(item)),
        ))
            .toList(),
        onChanged: onChanged,
        validator: (value) {
          if (value == null) return 'Required';
          return null;
        },
      ),
    );
  }
}
