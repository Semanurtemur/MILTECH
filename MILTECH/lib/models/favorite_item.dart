import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miltech/models/product_model.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../provider/app_provider.dart';

//// FAVORİDEKİ KUTUCUKLARIN TASLAĞI
class SingFavoriteItem extends StatefulWidget {
  final ProductModel singleProduct;

  const SingFavoriteItem({Key? key, required this.singleProduct});

  @override
  State<SingFavoriteItem> createState() => _SingFavoriteItemState();
}

class _SingFavoriteItemState extends State<SingFavoriteItem> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Container(
      margin: EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color.fromARGB(255, 91, 46, 238), width: 3),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 140,
              color: Colors.purple.withOpacity(0.5),
              child: Image.network(widget.singleProduct.image),
            ),
          ),
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 140,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          child: Text(
                            widget.singleProduct.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        SizedBox(
                          height: 12,
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "\$${widget.singleProduct.price.toString()}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          appProvider
                              .removeFavouriteProduct(widget.singleProduct);
                          showMessage("Removed from Cart");
                        },
                        child: CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 89, 69, 154),
                          foregroundColor: Colors.white,
                          maxRadius: 20,
                          child: Icon(
                            Icons.delete,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
