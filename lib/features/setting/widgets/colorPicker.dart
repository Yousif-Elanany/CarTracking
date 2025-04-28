import 'package:flutter/material.dart';

class ColorPickerDropdown extends StatefulWidget {
  @override
  _ColorPickerDropdownState createState() => _ColorPickerDropdownState();
}

class _ColorPickerDropdownState extends State<ColorPickerDropdown> {
  Color selectedColor = Colors.green;

  final List<Color> colors = [Colors.green, Colors.red, Colors.yellow];

  void _showColorPicker() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: colors.map((color) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedColor = color;
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: selectedColor == color ? 3 : 1,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showColorPicker,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("color", style: TextStyle(color: Colors.grey)),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: selectedColor,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
