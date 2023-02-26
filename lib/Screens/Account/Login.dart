import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import '../../firebase_options.dart';
import 'AuthController.dart';

class ScreenLogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<ScreenLogIn> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String get email => _emailController.text.trim();
  String get password => _passwordController.text.trim();

  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        Opacity(
          opacity: 0.5,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/barfbookapp.png"),
                    fit: BoxFit.fill)),
          ),
        ),
        Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(top: 100.0, right: 40, left: 40, bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: FlutterLogo(
                    size: _media.height * 0.1,
                  )),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Willkommen",
                    style: TextStyle(
                      letterSpacing: 3,
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Anmeldung',
                    style: TextStyle(fontWeight: FontWeight.w200, fontSize: 33),
                  ),
                  SizedBox(height: 50),
                  Container(
                    height: _media.height / 4.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 20,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        children: [
                          inputText("Benutzername", _emailController, false),
                          Divider(height: 5, color: Colors.black),
                          inputText("Passwort", _passwordController, true),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Center(
                        child: ElevatedButton(
                            onPressed: () {
                              authHandler.handleSignUp(email, password);
                              print(_emailController.text);
                            },
                            child: Text("Anmelden"))),
                  )
                ],
              ),
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Als Gast fortfahren"),
                  VerticalDivider(
                    width: 10,
                    thickness: 0.5,
                  ),
                  GestureDetector(
                    onTap: () => print("Sign Up Tapped"),
                    child: Text("Registrieren"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ]),
    );
  }

  Widget inputText(
    String fieldName,
    TextEditingController controller,
    bool obSecure,
  ) {
    return TextField(
      style: TextStyle(height: 1.5),
      controller: controller,
      decoration: InputDecoration(
        labelText: fieldName,
        labelStyle: TextStyle(
            fontSize: 21, fontWeight: FontWeight.w400, letterSpacing: 1),
        border: InputBorder.none,
      ),
      obscureText: obSecure,
    );
  }
}
