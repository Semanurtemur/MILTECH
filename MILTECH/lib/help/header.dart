import 'package:flutter/material.dart';

//header kısımları için
Widget header(String title, context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 29),
      //geri ikonu
      GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: Color(0XFF0A1034), size: 27)),

      SizedBox(height: 20),

      Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      SizedBox(height: 20),
    ],
  );
}
