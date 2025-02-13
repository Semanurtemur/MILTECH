import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:miltech/help/custome-bar.dart';
import 'package:miltech/help/firebase_helpers/firebase_firestore.dart';

import 'package:miltech/help/routes.dart';
import 'package:miltech/screens/account_informations/Account.dart';
import 'package:miltech/screens/categoriPages/SmartPhones.dart';
import 'package:miltech/screens/categoriPages/computers.dart';
import 'package:miltech/screens/categoriPages/tablet.dart';

import 'package:miltech/screens/product_details/product_details.dart';
import 'package:miltech/screens/tab_bar/cart.dart';
import 'package:miltech/screens/tab_bar/categories.dart';
import 'package:miltech/screens/tab_bar/favorite.dart';
import 'package:provider/provider.dart';
import '../../models/product_model.dart';
import '../../provider/app_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProductModel> productModelList = [];

  bool isLodaing = false;
  @override
  void initState() {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getUserInfoFirebase();
    getBestProductList();
    super.initState();
  }

  void getBestProductList() async {
    setState(() {
      isLodaing = true;
    });
    FirebaseFirestoreHelper.instance.updateTokenFromFirebase();
    productModelList = await FirebaseFirestoreHelper.instance.getbestProducts();
    setState(() {
      isLodaing = false;
    });
  }

  TextEditingController search = TextEditingController();
  List<ProductModel> searchList = [];
  void searchProducts(String value) {
    searchList = productModelList
        .where((element) =>
            element.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 10,
        title: Text(
          "M I L T E C H",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
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
                      children: [
                        //Search Button

                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: search,
                                onChanged: (String value) {
                                  searchProducts(value);
                                },
                                decoration: InputDecoration(
                                    hintText: 'search...',
                                    hintTextDirection: TextDirection.ltr),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {
                                // You can search here
                              },
                            ),
                            InkWell(
                              onTap: () {
                                Routes.instance.push(
                                    widget: AccountScreen(), context: context);
                              },
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromARGB(100, 160, 158, 244),
                                ),
                                child: Icon(Icons.person),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(45, 30, 45, 30),
                    child: Row(
                      children: [
                        //first button
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 25,
                              ),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromARGB(100, 160, 158, 244)),
                              child: IconButton(
                                icon: Icon(Icons.phone_android, size: 25),
                                onPressed: () {
                                  Routes.instance.push(
                                      widget: const SmartPhones(),
                                      context: context);
                                },
                                color: Color(0XFF0001FC),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                              width: 100,
                            ),
                            Text(
                              "PHONES",
                              style: TextStyle(
                                  color: Color(0xFF1F53E4),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        //second button

                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 25),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromARGB(100, 160, 158, 244)),
                              child: IconButton(
                                icon: Icon(Icons.computer, size: 25),
                                onPressed: () {
                                  Routes.instance.push(
                                      widget: const Computers(),
                                      context: context);
                                },
                                color: Color(0XFF0001FC),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                              width: 100,
                            ),
                            Text(
                              "COMPUTER",
                              style: TextStyle(
                                  color: Color(0xFF1F53E4),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),

                        //third button
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 25),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromARGB(100, 160, 158, 244)),
                              child: IconButton(
                                icon: Icon(Icons.tablet, size: 25),
                                onPressed: () {
                                  Routes.instance.push(
                                      widget: const Tablets(),
                                      context: context);
                                },
                                color: Color(0XFF0001FC),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                              width: 100,
                            ),
                            Text(
                              "TABLET",
                              style: TextStyle(
                                  color: Color(0xFF1F53E4),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  !isSearched()
                      ? const Padding(
                          padding: const EdgeInsets.only(top: 12.0, left: 12.0),
                          child: Text(
                            "BEST PRODUCT",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Color.fromARGB(255, 91, 46, 238),
                            ),
                          ),
                        )
                      : SizedBox.fromSize(),
                  const SizedBox(
                    height: 12.0,
                  ),
                  search.text.isNotEmpty && searchList.isEmpty
                      ? const Center(
                          child: Text("No Product Found "),
                        )
                      : searchList.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: GridView.builder(
                                  padding: EdgeInsets.zero,
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: searchList.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisSpacing: 20,
                                          crossAxisSpacing: 20,
                                          childAspectRatio: 0.7,
                                          crossAxisCount: 2),
                                  itemBuilder: (ctx, index) {
                                    ProductModel singleProduct =
                                        searchList[index];
                                    return Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0)),
                                      color: Color.fromARGB(100, 160, 158, 244),
                                      child: InkWell(
                                        onTap: () {
                                          Routes.instance.push(
                                              widget: ProductDetails(
                                                  singleProduct: singleProduct),
                                              context: context);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18.0,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 9.0,
                                                ),
                                                Text(
                                                    "Price: \$${singleProduct.price}"),
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
                            )
                          : productModelList.isEmpty
                              ? const Center(
                                  child: Text("Best Product is empty"),
                                )
                              : Padding(
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
                                              borderRadius:
                                                  BorderRadius.circular(12.0)),
                                          color: Color.fromARGB(
                                              100, 160, 158, 244),
                                          child: InkWell(
                                            onTap: () {
                                              Routes.instance.push(
                                                  widget: ProductDetails(
                                                      singleProduct:
                                                          singleProduct),
                                                  context: context);
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
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
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18.0,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 9.0,
                                                    ),
                                                    Text(
                                                        "Price: \$${singleProduct.price}"),
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
                  const SizedBox(
                    height: 12.0,
                  ),
                ],
              ),
            ),
    );
  }

  bool isSearched() {
    if (search.text.isNotEmpty && searchList.isEmpty) {
      return true;
    } else if (search.text.isEmpty && searchList.isNotEmpty) {
      return false;
    } else if (searchList.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
