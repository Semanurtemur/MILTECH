import 'package:miltech/help/custome-bar.dart';
import 'package:miltech/help/firebase_helpers/firebase_firestore.dart';
import 'package:miltech/help/header.dart';
import 'package:miltech/help/routes.dart';
import 'package:miltech/models/product_model.dart';
import 'package:miltech/screens/tab_bar/categories.dart';
import 'package:flutter/material.dart';
import '../product_details/product_details.dart';
import '../tab_bar/homepage.dart';

class Computers extends StatefulWidget {
  const Computers({super.key});

  @override
  State<Computers> createState() => _ComputersState();
}

class _ComputersState extends State<Computers> {
  List<ProductModel> productModelList = [];

  bool isLodaing = false;
  @override
  void initState() {
    getComputers();
    super.initState();
  }

  void getComputers() async {
    setState(() {
      isLodaing = true;
    });

    productModelList = await FirebaseFirestoreHelper.instance.getcomputers();
    setState(() {
      isLodaing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLodaing
            ? Center(
                child: Container(
                  height: 100,
                  width: 100,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(25, 10, 15, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [header("C O M P U T E R S", context)],
                        )),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: GridView.builder(
                          padding: EdgeInsets.zero,
                          primary: false,
                          shrinkWrap: true,
                          itemCount: productModelList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 20,
                                  childAspectRatio: 0.7,
                                  crossAxisCount: 2),
                          itemBuilder: (ctx, index) {
                            ProductModel singleProduct =
                                productModelList[index];
                            return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0)),
                              color: Color.fromARGB(100, 160, 158, 244),
                              child: InkWell(
                                onTap: () {
                                  Routes.instance.push(
                                      widget: ProductDetails(
                                          singleProduct: singleProduct),
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
                                          height: 120,
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
                                        SizedBox(
                                          height: 20,
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
