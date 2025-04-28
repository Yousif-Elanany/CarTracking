import 'package:flutter/material.dart';

class customSelectButton extends StatelessWidget {
  final String btnText;
  final Color borderColor;
  final IconData behindIcon;
  final Color iconColor;
  final Color btnTextColor;
  final VoidCallback ontap;
  final double btnheight;
  final double btnHorzontalWidth;

  const customSelectButton({
    Key? key,
    required this.btnText,
    required this.borderColor,
    required this.behindIcon,
    required this.iconColor,
    required this.btnTextColor,
    required this.ontap,
    this.btnheight = 50,
    this.btnHorzontalWidth = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: btnheight,
        padding: EdgeInsets.symmetric(horizontal: btnHorzontalWidth),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(behindIcon, color: iconColor, size: 20),
            SizedBox(width: 8),
            Text(
              btnText,
              style: TextStyle(
                color: btnTextColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
