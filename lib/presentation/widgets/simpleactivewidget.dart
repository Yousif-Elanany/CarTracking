import 'package:flutter/material.dart';

class UserActivationSwitch extends StatelessWidget {
  final String rightText;
  final bool isActivated;
  final bool isEnabled;
  final ValueChanged<bool> onChanged;

  const UserActivationSwitch({
    required this.rightText,
    required this.isActivated,
    required this.onChanged,
    this.isEnabled = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isEnabled ? 1.0 : 0.4, // لو السويتش غير مفعل يبقى شكله باهت
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            rightText,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          Switch(
            value: isActivated,
            onChanged: isEnabled ? onChanged : null, // لو مش مفعل بيبقى null
            activeColor: Colors.green,
            inactiveTrackColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
