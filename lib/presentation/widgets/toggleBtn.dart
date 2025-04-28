import 'package:flutter/material.dart';

class AlertToggleWidget extends StatefulWidget {
  @override
  _AlertToggleWidgetState createState() => _AlertToggleWidgetState();
}

class _AlertToggleWidgetState extends State<AlertToggleWidget> {
  bool isAlert = true; // true => صح, false => خطأ

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Is alert"),
        const SizedBox(width: 10),
        ToggleButtonOption(
          label: "✔️ True",
          value: true,
          groupValue: isAlert,
          onChanged: (val) {
            setState(() {
              isAlert = val;
            });
          },
        ),
        const SizedBox(width: 8),
        ToggleButtonOption(
          label: "❌ False",
          value: false,
          groupValue: isAlert,
          onChanged: (val) {
            setState(() {
              isAlert = val;
            });
          },
        ),
      ],
    );
  }
}

class ToggleButtonOption extends StatelessWidget {
  final String label;
  final bool value;
  final bool groupValue;
  final ValueChanged<bool> onChanged;

  const ToggleButtonOption({
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = value == groupValue;
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? Colors.blue.shade50 : Colors.transparent,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Radio<bool>(
              value: value,
              groupValue: groupValue,
              onChanged: (val) => onChanged(val!),
              activeColor: Colors.blue,
            ),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.blue : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
