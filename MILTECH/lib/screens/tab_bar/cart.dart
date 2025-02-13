import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miltech/constants/constants.dart';
import 'package:miltech/help/header.dart';
import 'package:miltech/help/routes.dart';
import 'package:miltech/models/cart_item.dart';

import 'package:provider/provider.dart';

import '../../help/primary_button.dart';
import '../../provider/app_provider.dart';
import '../others/cart_item_checkout.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 180,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "TOTAL",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "\$${appProvider.totalPrice().toString()}",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 12.0,
              ),
              PrimaryButton(
                title: "Checkout",
                onPressed: () {
                  appProvider.clearBuyProduct();
                  appProvider.addBuyProductCartList();
                  appProvider.clearCart();
                  if (appProvider.getBuyProductList.isEmpty) {
                    showMessage("Cart is empty");
                  } else {
                    Routes.instance.push(
                        widget: const CartItemCheckOut(), context: context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "C A R T",
          style: TextStyle(
            color: Color.fromARGB(255, 91, 46, 238),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: appProvider.getCartProductList.isEmpty
          ? const Center(
              child: Text("Empty"),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: appProvider.getCartProductList.length,
              itemBuilder: (ctx, index) {
                return SingleCartItem(
                  singleProduct: appProvider.getCartProductList[index],
                );
              }),
    );
  }
}
