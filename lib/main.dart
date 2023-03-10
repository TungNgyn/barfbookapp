import 'package:Barfbook/home.dart';
import 'package:Barfbook/util/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  // runApp(GetMaterialApp(home: ScreenSplash()));
  // runApp(GetMaterialApp(
  //   home: Scaffold(
  //     resizeToAvoidBottomInset: false,
  //     body: Container(
  //       decoration: BoxDecoration(
  //           image: DecorationImage(
  //               image: AssetImage("assets/images/splash/SteinSplash1.png"),
  //               fit: BoxFit.cover)),
  //     ),
  //   ),
  // ));

  await Supabase.initialize(
    url: 'https://wokqzyqvqztmyzhhuqqh.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Indva3F6eXF2cXp0bXl6aGh1cXFoIiwicm9sZSI6ImFub24iLCJpYXQiOjE2Nzc0MTAwNjUsImV4cCI6MTk5Mjk4NjA2NX0.Lw1KOvMQsD7mx_NbiXvZ2uxGTX61j_oSS93v_DqTyG0',
  );
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: CustomTheme.classicLight,
      darkTheme: CustomTheme.classicDark,
      home: Home(),
    );
  }
}
