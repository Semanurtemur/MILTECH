import 'package:flutter/material.dart';
import 'package:miltech/help/routes.dart';
import 'package:miltech/screens/login/signup/login.dart';
import 'package:miltech/screens/login/signup/signup.dart';

class welcome extends StatelessWidget {
  const welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: kToolbarHeight + 70,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "WELCOME",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),

            //fotoğraf
            Image.asset("assets/images/logo.png"),

            const SizedBox(
              height: 5,
            ),

            SizedBox(
              height: 45,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Routes.instance.push(widget: Login(), context: context);
                },
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 89, 69, 154)),
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 45,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Routes.instance.push(widget: SignUp(), context: context);
                },
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 89, 69, 154)),
                child: const Text(
                  "SignUp",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
