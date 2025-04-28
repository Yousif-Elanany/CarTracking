import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? text;  // جعلها اختيارية
  final Widget? child; // دعم أي ويدجت بدل النص
  final Function()? onPressed;
  final Color? backGroundColor;
  final Color? TextColor;
  final double? paddingYouNeed;
  final double? heightYouNeed;

  const CustomButton({
    Key? key,
    this.text,  // لم يعد مطلوبًا
    this.child, // إضافة دعم للويدجت
    this.TextColor,
    this.backGroundColor,
    this.onPressed,
    this.paddingYouNeed = 8.0,
    this.heightYouNeed = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(paddingYouNeed!),
      child: SizedBox(
        height: heightYouNeed!,
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backGroundColor ?? Colors.blue, // لون افتراضي
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: onPressed,
          child: child ??
              Text(
                text ?? "", // عرض النص لو لم يكن هناك `child`
                style: TextStyle(
                  fontSize: 16,
                  color: TextColor ?? Colors.white, // لون افتراضي
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
    );
  }
}
