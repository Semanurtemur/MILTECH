import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:miltech/constants/constants.dart';
import 'package:miltech/help/header.dart';
import 'package:miltech/help/routes.dart';
import 'package:miltech/models/product_model.dart';
import 'package:miltech/provider/app_provider.dart';
import 'package:miltech/screens/others/CheckOut.dart';

import 'package:provider/provider.dart';

//// ÜRÜNÜN TEKLİ AYRINTILARININ GÖRÜNDÜĞÜ SAYFA
class ProductDetails extends StatefulWidget {
  final ProductModel singleProduct;
  const ProductDetails({super.key, required this.singleProduct});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int qty = 1;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header("", context),
                SizedBox(
                  height: 16,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 70, 15, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  widget.singleProduct.image,
                  height: 300,
                  width: 400,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.singleProduct.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    //FAVORITE BUTTON
                    IconButton(
                      onPressed: () {
                        setState(() {
                          widget.singleProduct.isFavourite =
                              !widget.singleProduct.isFavourite;
                        });
                        if (widget.singleProduct.isFavourite) {
                          appProvider.addFavouriteProduct(widget.singleProduct);
                        } else {
                          appProvider
                              .removeFavouriteProduct(widget.singleProduct);
                        }
                      },
                      icon: Icon(appProvider.getFavouriteProductList
                              .contains(widget.singleProduct)
                          ? Icons.favorite
                          : Icons.favorite_border),
                    ),
                  ],
                ),

                Text(widget.singleProduct.description),
                SizedBox(
                  height: 12.90,
                ),
                Row(
                  children: [
                    Expanded(child: Container()),
                    Expanded(
                      child: Text(
                        " \$${widget.singleProduct.price.toString()}",
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                        ),
                      ),
                    ),
                  ],
                ),

                //ekleme çıkarma
                Row(
                  children: [
                    CupertinoButton(
                      onPressed: () {
                        if (qty >= 1) {
                          setState(() {
                            qty--;
                          });
                        }
                      },
                      padding: EdgeInsets.zero,
                      child: CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 89, 69, 154),
                        foregroundColor: Colors.white,
                        child: Icon(Icons.remove),
                      ),
                    ),
                    SizedBox(
                      width: 12.0,
                    ),
                    Text(
                      qty.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 12.0,
                    ),
                    CupertinoButton(
                      onPressed: () {
                        setState(() {
                          qty++;
                        });
                      },
                      padding: EdgeInsets.zero,
                      child: CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 89, 69, 154),
                        foregroundColor: Colors.white,
                        child: Icon(Icons.add),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  height: 150,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 200,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  ProductModel productModel =
                                      widget.singleProduct.copyWith(qty: qty);
                                  appProvider.addCartProduct(productModel);
                                  showMessage("Added to Cart");
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(
                                      255, 89, 69, 154), // Mor arka plan rengi
                                  onPrimary: Colors.white, // Beyaz yazı rengi
                                ),
                                child: Text(
                                  "ADD TO CART",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
