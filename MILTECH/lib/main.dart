import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:miltech/provider/app_provider.dart';
import 'package:miltech/screens/categoriPages/accessories.dart';

import 'package:miltech/screens/categoriPages/computers.dart';
import 'package:miltech/screens/categoriPages/SmartPhones.dart';
import 'package:miltech/screens/categoriPages/tablet.dart';
import 'package:miltech/screens/categoriPages/watch.dart';
import 'package:miltech/screens/tab_bar/homepage.dart';
import 'package:miltech/screens/login/signup/login.dart';
import 'package:miltech/screens/login/signup/signup.dart';
import 'package:miltech/help/custome-bar.dart';
import 'package:miltech/screens/others/welcome.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51MWx8OAVMyklfe3CsjEzA1CiiY0XBTlHYbZ8jQlGtVFIwQi4aNeGv8J1HUw4rgSavMTLzTwgn0XRlwoTVRFXyu2h00mRUeWmAf";
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          "/loginPage": (context) => Login(),
          "/signUp": (context) => SignUp(),
          "/home": (context) => HomePage(),
          "/computers": (context) => Computers(),
          "/accessory": (context) => Accessories(),
          "/smartphones": (context) => SmartPhones(),
          "/tablet": (context) => Tablets(),
          "/watch": (context) => Watches(),
          "/customebottombar": (context) => CustomBottomBar(),
        },
        theme: ThemeData(
            primaryColor: Colors.blue,
            scaffoldBackgroundColor: Colors.white,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        home: CustomBottomBar(),
      ),
    );
  }
}
