import 'package:flutter/material.dart';
import 'package:miltech/screens/login/signup/signup.dart';
import 'package:miltech/screens/tab_bar/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regExp = new RegExp(p);

class _LoginState extends State<Login> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            height: 600,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 380,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        "MILTECH",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.normal),
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
                            border: OutlineInputBorder(),
                            hintText: "Email",
                            hintStyle: TextStyle(color: Colors.black)),
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
                            border: OutlineInputBorder(),
                            hintText: "Password",
                            hintStyle: TextStyle(color: Colors.black)),
                      ),
                      Container(
                          height: 45,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                try {
                                  final userResult = await firebaseAuth
                                      .signInWithEmailAndPassword(
                                          email: email, password: password);
                                  Navigator.popAndPushNamed(
                                      context, "/customebottombar");
                                  print(userResult.user!.email);
                                } catch (e) {
                                  print(e.toString());
                                }
                              } else {}
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 89, 69, 154)),
                            child: const Text(
                              'Login',
                              style: TextStyle(fontSize: 20),
                            ),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "  I Already Have Not Account",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, "/signUp"),
                            child: Text(
                              "SignUp",
                              style: TextStyle(
                                  color: Colors.blue,
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
      ),
    );
  }
}
