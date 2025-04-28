import 'package:flutter/material.dart';

Widget buildBox(String title, String value, String? percentage, Color iconColor) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontSize: 12, color: Colors.black,fontWeight: FontWeight.normal),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (percentage != null)
              Text(
                percentage,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
          ],
        ),
        Spacer(),
        Row(
          children: [
            Icon(Icons.bar_chart, size: 10, color: iconColor), // حط أيقونتك هنا
            SizedBox(width: 6),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    ),
  );}