import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller; // إجباري
  final String? hintText;
  final String? labelText;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final OutlineInputBorder? border;
  final OutlineInputBorder? focusedBorder;
  final OutlineInputBorder? enabledBorder;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final int? maxLines;
  final String? Function(String?)? validator; // 💥 هنا الإضافة الجديدة
  final bool readOnly;

  const CustomTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.labelText,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.hintStyle,
    this.labelStyle,
    this.border,
    this.focusedBorder,
    this.enabledBorder,
    this.keyboardType,
    this.onChanged,
    this.maxLines = 1,
    this.validator,
    this.readOnly = false
// 🧠 ودي كمان
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      readOnly: readOnly,

      keyboardType: keyboardType,
      maxLines: maxLines,
      onChanged: onChanged,
      validator: validator, // 👈 الاستخدام هنا
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        hintStyle: hintStyle ?? const TextStyle(color: Color(0xff6C6C89)),
        labelStyle: labelStyle ?? const TextStyle(color: Colors.grey),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: border ?? OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: Colors.grey),
            ),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: Colors.black38),
            ),
      ),
    );
  }
}
