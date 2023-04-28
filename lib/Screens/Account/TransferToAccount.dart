import 'dart:async';
import 'dart:io';

import 'package:Barfbook/loading.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart'
    show FilteringTextInputFormatter, rootBundle;
import 'package:Barfbook/Screens/Account/Login.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ScreenTransfer extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<ScreenTransfer> {
  bool _isLoading = false;
  bool _redirecting = false;
  late final _emailController;
  late final _usernameController;
  late final _passwordController;

  String get email => _emailController.text.trim();
  String get username => _usernameController.text.trim();
  String get password => _passwordController.text.trim();

  @override
  void initState() {
    _emailController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
          Opacity(
            opacity: 0.4,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/splash/background.png"),
                      fit: BoxFit.fill)),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Center(
                      child: Image.asset(
                    'assets/icons/icon.png',
                    width: MediaQuery.of(context).size.height * 0.1,
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
                  Text(
                    'Registrierung',
                    style: TextStyle(fontWeight: FontWeight.w200, fontSize: 33),
                  ),
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: _media.height / 3.5,
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
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            TextField(
                              style: TextStyle(height: 1.5),
                              controller: _usernameController,
                              keyboardType: TextInputType.name,
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(' ')
                              ],
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: "Benutzername",
                                labelStyle: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1),
                                border: InputBorder.none,
                              ),
                            ),
                            Divider(height: 5, color: Colors.black),
                            TextField(
                              style: TextStyle(height: 1.5),
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(' ')
                              ],
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1),
                                border: InputBorder.none,
                              ),
                            ),
                            Divider(height: 5, color: Colors.black),
                            TextField(
                              style: TextStyle(height: 1.5),
                              controller: _passwordController,
                              decoration: InputDecoration(
                                labelText: 'Passwort',
                                labelStyle: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1),
                                border: InputBorder.none,
                              ),
                              obscureText: true,
                            ),
                            Center(
                                child: ElevatedButton(
                                    onPressed: () {},
                                    child: Text("Registrieren"))),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: _media.height * 0.1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {}, child: Text("Als Gast fortfahren")),
                      VerticalDivider(
                        width: 10,
                        thickness: 0.5,
                      ),
                      GestureDetector(
                        onTap: () => Get.offAll(() => ScreenLogin()),
                        child: Text("Anmelden"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
