import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miltech/models/product_model.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../provider/app_provider.dart';

//// SEPETTEKİ KUTUCUKLARIN TASLAĞI
class SingleCartItem extends StatefulWidget {
  final ProductModel singleProduct;

  const SingleCartItem({Key? key, required this.singleProduct});

  @override
  State<SingleCartItem> createState() => _SingleCartItemState();
}

class _SingleCartItemState extends State<SingleCartItem> {
  int qty = 1;

  @override
  void initState() {
    qty = widget.singleProduct.qty ?? 0;
    super.initState();
  }

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
                        Row(
                          children: [
                            CupertinoButton(
                              onPressed: () {
                                if (qty > 1) {
                                  setState(() {
                                    qty--;
                                  });
                                  appProvider.updateQty(
                                      widget.singleProduct, qty);
                                }
                              },
                              padding: EdgeInsets.zero,
                              child: CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 89, 69, 154),
                                foregroundColor: Colors.white,
                                maxRadius: 13,
                                child: Icon(Icons.remove),
                              ),
                            ),
                            Text(
                              qty.toString(),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            CupertinoButton(
                              onPressed: () {
                                setState(() {
                                  qty++;
                                });
                                appProvider.updateQty(
                                    widget.singleProduct, qty);
                              },
                              padding: EdgeInsets.zero,
                              child: CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 89, 69, 154),
                                foregroundColor: Colors.white,
                                maxRadius: 13,
                                child: Icon(Icons.add),
                              ),
                            )
                          ],
                        ),
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
                          appProvider.removeCartProduct(widget.singleProduct);
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
