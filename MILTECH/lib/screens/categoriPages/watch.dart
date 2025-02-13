import 'package:miltech/help/custome-bar.dart';
import 'package:miltech/help/firebase_helpers/firebase_firestore.dart';
import 'package:miltech/help/header.dart';
import 'package:miltech/help/routes.dart';
import 'package:miltech/models/product_model.dart';
import 'package:miltech/screens/tab_bar/categories.dart';
import 'package:flutter/material.dart';

import '../product_details/product_details.dart';
import '../tab_bar/homepage.dart';

class Watches extends StatefulWidget {
  const Watches({super.key});

  @override
  State<Watches> createState() => _WatchesState();
}

class _WatchesState extends State<Watches> {
  List<ProductModel> productModelList = [];

  bool isLodaing = false;
  @override
  void initState() {
    getTablet();
    super.initState();
  }

  void getTablet() async {
    setState(() {
      isLodaing = true;
    });

    productModelList = await FirebaseFirestoreHelper.instance.getwatch();
    setState(() {
      isLodaing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.fromLTRB(25, 10, 15, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [header("W A T C H", context)],
          )),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
            padding: EdgeInsets.zero,
            primary: false,
            shrinkWrap: true,
            itemCount: productModelList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 0.7,
                crossAxisCount: 2),
            itemBuilder: (ctx, index) {
              ProductModel singleProduct = productModelList[index];
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                color: Color.fromARGB(100, 160, 158, 244),
                child: InkWell(
                  onTap: () {
                    Routes.instance.push(
                        widget: ProductDetails(singleProduct: singleProduct),
                        context: context);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Image.network(
                            singleProduct.image,
                            height: 130,
                            width: 140,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          FittedBox(
                            child: Text(
                              singleProduct.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 9.0,
                          ),
                          Text("Price: \$${singleProduct.price}"),
                          const SizedBox(
                            height: 11.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    ])));
  }
}
