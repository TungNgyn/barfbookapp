import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:Barfbook/home.dart';
import 'package:Barfbook/Screens/Account/Login.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ScreenSignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<ScreenSignUp> {
  bool _isLoading = false;
  bool _redirecting = false;
  late final _emailController;
  late final _usernameController;
  late final _passwordController;
  late final StreamSubscription<AuthState> _authStateSubscription;

  String get email => _emailController.text.trim();
  String get username => _usernameController.text.trim();
  String get password => _passwordController.text.trim();

  @override
  void initState() {
    _emailController = TextEditingController();
    _usernameController = TextEditingController();
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
    _usernameController.dispose();
    _passwordController.dispose();
    _authStateSubscription.cancel();
    super.dispose();
  }

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
                    'Registrierung',
                    style: TextStyle(fontWeight: FontWeight.w200, fontSize: 33),
                  ),
                  SizedBox(height: 50),
                  Container(
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
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        children: [
                          inputText("Benutzername", _usernameController, false),
                          Divider(height: 5, color: Colors.black),
                          inputText("Email", _emailController, false),
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
                              GetUtils.isEmail(email)
                                  ? password.length >= 8
                                      ? _signUp()
                                      : Get.snackbar(
                                          "Etwas ist schief gelaufen",
                                          "Dein Passwort ist zu kurz!")
                                  : Get.snackbar("Etwas ist schief gelaufen",
                                      "Deine Email hat ein falsches Format!");
                            },
                            child: Text("Registrieren"))),
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
                    onTap: () => Get.offAll(() => ScreenLogin()),
                    child: Text("Anmelden"),
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

  Future<void> _signUp() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final AuthResponse response = await supabase.auth.signUp(
          email: email,
          password: password,
          data: {
            'name': username,
            'description': "Ich bin ein BARF-Enthusiast!"
          });

      session = response.session;
      user = response.user;
    } catch (error) {
      print(error);
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
      final AuthResponse response = await supabase.auth.signUp(
          email: "${DateTime.now().microsecondsSinceEpoch}@barfbook.app",
          password: "BarfbookGast",
          data: {'name': 'Gast', 'description': "Ich bin ein BARF-Gast."});

      session = response.session;
      user = response.user;

      final bytes = await rootBundle.load('assets/images/defaultAvatar.png');
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/defaultAvatar.png');
      await file.writeAsBytes(
          bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));

      final storageResponse =
          await supabase.storage.from('profile').upload('${user?.id}', file);
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
}
