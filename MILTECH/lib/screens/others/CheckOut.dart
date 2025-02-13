import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:miltech/help/custome-bar.dart';
import 'package:miltech/help/firebase_helpers/firebase_firestore.dart';

import 'package:miltech/help/primary_button.dart';
import 'package:miltech/help/routes.dart';
import 'package:miltech/models/product_model.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';

class CheckOut extends StatefulWidget {
  final ProductModel singleProduct;
  const CheckOut({super.key, required this.singleProduct});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  int groupValue = 1;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "C H E C K O U T",
          style: TextStyle(
              color: Color.fromARGB(255, 91, 46, 238),
              fontWeight: FontWeight.bold,
              fontSize: 22),
        ),
        centerTitle: true,
        leading: Container(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                      color: Color.fromARGB(255, 91, 46, 238), width: 3.0)),
              width: double.infinity,
              child: Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                  ),
                  const Icon(Icons.money),
                  const SizedBox(
                    width: 12.0,
                  ),
                  const Text(
                    "Cash on Delivery",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                      color: Color.fromARGB(255, 91, 46, 238), width: 3.0)),
              width: double.infinity,
              child: Row(
                children: [
                  Radio(
                    value: 2,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                  ),
                  const Icon(Icons.money),
                  const SizedBox(
                    width: 12.0,
                  ),
                  const Text(
                    "Pay Online",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            PrimaryButton(
              title: "Continues",
              onPressed: () async {
                appProvider.clearBuyProduct();
                appProvider.addBuyProduct(widget.singleProduct);

                bool value = await FirebaseFirestoreHelper.instance
                    .uploadOrderedProductFirebase(appProvider.getBuyProductList,
                        context, groupValue == 1 ? "cash on delivery" : "paid");
                if (value) {
                  Future.delayed(const Duration(seconds: 2), () {
                    Routes.instance.push(
                        widget: const CustomBottomBar(), context: context);
                  });
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
