import 'package:flutter/material.dart';
import 'package:miltech/help/header.dart';
import 'package:miltech/help/custome-bar.dart';

import 'package:miltech/screens/categoriPages/computers.dart';
import 'package:miltech/screens/categoriPages/smartphones.dart';
import 'package:miltech/screens/categoriPages/tablet.dart';
import 'package:miltech/screens/categoriPages/watch.dart';
import 'package:miltech/screens/categoriPages/accessories.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "C A T E G O R Y",
          style: TextStyle(
              color: Color.fromARGB(255, 91, 46, 238),
              fontWeight: FontWeight.bold,
              fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //header

                  SizedBox(
                    height: 16,
                  ),

                  //kategoriler

                  buildCategory("Computer", context, Computers()),
                  buildCategory("Smartphone", context, SmartPhones()),
                  buildCategory("Tablet", context, Tablets()),
                  buildCategory("Watch", context, Watches()),
                  buildCategory("Accessory", context, Accessories()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildCategory(String title, BuildContext context, Widget page) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return page;
        }),
      );
    },
    child: Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(24),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xff0a1034),
        ),
      ),
    ),
  );
}
