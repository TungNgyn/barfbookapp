import 'dart:ui';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;
final authController = AuthController();

Session? session = supabase.auth.currentSession;
User? user = supabase.auth.currentUser;

class AuthController {
  Future<User?> signUp(String email, String username, String password) async {
    final AuthResponse response = await supabase.auth.signUp(
      email: email,
      password: password,
    );

    session = response.session;
    user = response.user;
  }

  Future<User?> loginWithGuest() async {
    final AuthResponse response = await supabase.auth.signInWithPassword(
      email: "${WordPair.random()}@${WordPair.random()}.com",
      password: "${WordPair.random()}",
    );
    session = response.session;
    user = response.user;
  }

  Future<User?> loginWithEmail(String email, String password) async {
    try {
      await supabase.auth.signInWithPassword(email: email, password: password);
    } on AuthException catch (error) {
      // Get.snackbar("message: ", error.message.tr);
      // Get.updateLocale(Locale('de'));
      Get.snackbar("Etwas ist schief gelaufen",
          "Deine Email oder dein Passwort ist nicht korrekt. Bitte versuche es nochmal.",
          backgroundColor: Colors.grey.withOpacity(0.5));
    } catch (error) {
      Get.snackbar("Etwas ist schief gelaufen",
          'Unerwarteter Fehler aufgetreten. Bitte kontaktiere den Support.',
          backgroundColor: Colors.grey.withOpacity(0.5));
    }
    ;
  }

  Future<User?> signOut() async {
    await supabase.auth.signOut();
    session = null;
    user = null;
  }
}
