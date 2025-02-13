import 'package:flutter/material.dart';
import 'package:miltech/models/cart_item.dart';
import 'package:miltech/models/favorite_item.dart';
import 'package:miltech/provider/app_provider.dart';
import 'package:provider/provider.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "F A V O R I T E",
          style: TextStyle(
              color: Color.fromARGB(255, 91, 46, 238),
              fontWeight: FontWeight.bold,
              fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: appProvider.getFavouriteProductList.isEmpty
          ? const Center(
              child: Text("Empty"),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: appProvider.getFavouriteProductList.length,
              itemBuilder: (ctx, index) {
                return SingFavoriteItem(
                  singleProduct: appProvider.getFavouriteProductList[index],
                );
              }),
    );
  }
}
