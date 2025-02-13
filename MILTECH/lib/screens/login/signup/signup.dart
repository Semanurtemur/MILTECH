import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:miltech/screens/login/signup/login.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regExp = new RegExp(p);

class _SignUpState extends State<SignUp> {
  void vailadation() {
    final FormState? _form = _formKey.currentState;
    if (_form!.validate()) {
      print("Yes");
    } else {
      print("No");
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String username, email, password;
  final firebaseAuth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 200,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "MILTECH",
                          style: TextStyle(
                              fontSize: 30,
                              height: 5,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Signup",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 300,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Fill UserName";
                            } else if (value.length < 6) {
                              return "UserName Is Too Short";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            username = value!;
                          },
                          decoration: InputDecoration(
                            hintText: "UserName",
                            hintStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Fill Email";
                            } else if (!regExp.hasMatch(value)) {
                              return "Invalid Email";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            email = value!;
                          },
                          decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Fill Password";
                            } else if (value.length < 6) {
                              return "Password Is Too Short";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            password = value!;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        Container(
                            height: 45,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState?.save();
                                  try {
                                    var userResult = await firebaseAuth
                                        .createUserWithEmailAndPassword(
                                            email: email, password: password)
                                        .then((users) => {
                                              fireStore
                                                  .collection("Users")
                                                  .doc(username)
                                                  .set({
                                                "email": email,
                                                "password": password
                                              }).whenComplete(() => print(
                                                      "user add to firebase"))
                                            });
                                    _formKey.currentState?.reset();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            "Recorded! You are redirected to the login page"),
                                      ),
                                    );
                                    Navigator.pushReplacementNamed(
                                        context, "/loginPage");
                                  } catch (e) {
                                    print(e.toString());
                                  }
                                } else {}
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 89, 69, 154)),
                              child: const Text(
                                'Elevated Button',
                                style: TextStyle(fontSize: 20),
                              ),
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "I Already Have An Account",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () =>
                                  Navigator.pushNamed(context, "/loginPage"),
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 89, 69, 154),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
