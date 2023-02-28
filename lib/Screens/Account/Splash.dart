import 'package:Barfbook/Screens/Account/Login.dart';
import 'package:Barfbook/Screens/home.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  _ScreenSplashState createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  bool _redirectCalled = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _redirect();
  }

  Future<void> _redirect() async {
    await Future.delayed(Duration.zero);
    if (_redirectCalled || !mounted) {
      return;
    }

    await Supabase.initialize(
      url: 'https://wokqzyqvqztmyzhhuqqh.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Indva3F6eXF2cXp0bXl6aGh1cXFoIiwicm9sZSI6ImFub24iLCJpYXQiOjE2Nzc0MTAwNjUsImV4cCI6MTk5Mjk4NjA2NX0.Lw1KOvMQsD7mx_NbiXvZ2uxGTX61j_oSS93v_DqTyG0',
    );
    _redirectCalled = true;
    final session = supabase.auth.currentSession;

    if (session != null) {
      Get.offAll(() => ScreenHome());
    } else {
      Get.offAll(() => ScreenLogin());
    }
  }

  @override
  Widget build(BuildContext context) {
    authController.signOut();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/splash/SteinSplash1.png"),
                fit: BoxFit.cover)),
      ),
    );
  }
}
