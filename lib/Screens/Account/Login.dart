import 'dart:async';

import 'package:Barfbook/controller.dart';
import 'package:Barfbook/home.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../util/Supabase/AuthController.dart';
import 'SignUp.dart';

class ScreenLogin extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<ScreenLogin> {
  final Controller controller = Get.find();
  bool _isLoading = false;
  bool _redirecting = false;
  late final _emailController;
  late final _passwordController;
  late final StreamSubscription<AuthState> _authStateSubscription;

  String get email => _emailController.text.trim();
  String get password => _passwordController.text.trim();

  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        Opacity(
          opacity: 0.4,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/barfbookapp.png"),
                    fit: BoxFit.cover)),
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
                              _isLoading ? null : _login();
                            },
                            child: Text(_isLoading ? 'Laden..' : 'Anmelden'))),
                  )
                ],
              ),
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        _isLoading ? null : _loginGuest();
                      },
                      child: Text("Als Gast fortfahren")),
                  VerticalDivider(
                    width: 10,
                    thickness: 0.5,
                  ),
                  GestureDetector(
                    onTap: () => Get.offAll(() => ScreenSignUp()),
                    child: Text("Registrieren"),
                  ),
                ],
              ),
            ),
            // ElevatedButton(
            //     onPressed: () {
            //       _loginGoogle();
            //     },
            //     child: Text("allo"))
          ],
        )
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

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final AuthResponse response = await supabase.auth
          .signInWithPassword(email: email, password: password);

      session = response.session;
      user = response.user;
    } on AuthException catch (error) {
      Get.snackbar("Etwas ist schief gelaufen",
          "Deine Email oder dein Passwort ist nicht korrekt. Bitte versuche es nochmal.",
          backgroundColor: Colors.grey.withOpacity(0.5));
    } catch (error) {
      Get.snackbar("Etwas ist schief gelaufen",
          'Unerwarteter Fehler aufgetreten. Bitte kontaktiere den Support.',
          backgroundColor: Colors.grey.withOpacity(0.5));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loginGuest() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final AuthResponse response = await supabase.auth
          .signUp(password: "12345678", data: {'name': 'Gast'});

      session = response.session;
      user = response.user;
      print(userdata);
    } catch (error) {
      Get.snackbar("Etwas ist schief gelaufen",
          'Unerwarteter Fehler aufgetreten. Bitte kontaktiere den Support.',
          backgroundColor: Colors.grey.withOpacity(0.5));
      print(error);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loginGoogle() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await supabase.auth.signInWithOAuth(Provider.google);
    } on AuthException catch (error) {
      Get.snackbar("Etwas ist schief gelaufen",
          "Deine Email oder dein Passwort ist nicht korrekt. Bitte versuche es nochmal.",
          backgroundColor: Colors.grey.withOpacity(0.5));
    } catch (error) {
      Get.snackbar("Etwas ist schief gelaufen",
          'Unerwarteter Fehler aufgetreten. Bitte kontaktiere den Support.',
          backgroundColor: Colors.grey.withOpacity(0.5));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _authStateSubscription = supabase.auth.onAuthStateChange.listen((data) {
      if (_redirecting) return;
      final session = data.session;
      if (session != null) {
        _redirecting = true;
        Get.off(() => Home());
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _authStateSubscription.cancel();
    super.dispose();
  }
}
