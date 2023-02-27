import 'package:Barfbook/Screens/Account/Splash.dart';
import 'package:Barfbook/Screens/Account/Login.dart';
import 'package:Barfbook/util/custom_theme.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:json_theme/json_theme.dart';
import 'package:get/get.dart';

import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:convert';
import 'util/Supabase/AuthController.dart';
import 'Screens/home.dart';

void main() async {
  // runApp(GetMaterialApp(home: ScreenSplash()));
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://wokqzyqvqztmyzhhuqqh.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Indva3F6eXF2cXp0bXl6aGh1cXFoIiwicm9sZSI6ImFub24iLCJpYXQiOjE2Nzc0MTAwNjUsImV4cCI6MTk5Mjk4NjA2NX0.Lw1KOvMQsD7mx_NbiXvZ2uxGTX61j_oSS93v_DqTyG0',
  );

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StartState(),
      child: GetMaterialApp(
        home: user == null ? ScreenLogin() : ScreenHome(),
        title: "Barfbook",
        theme: CustomTheme.lightTheme,
        darkTheme: CustomTheme.darkTheme,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

// State
class StartState extends ChangeNotifier {
  var rezept = WordPair.random();

  void getNext() {
    rezept = WordPair.random();
    notifyListeners();
  }

  var favoriten = <WordPair>[];
  var erstellteRezepte = <WordPair>[];

  void toggleFavoriten() {
    if (favoriten.contains(rezept)) {
      favoriten.remove(rezept);
    } else {
      favoriten.add(rezept);
    }
    notifyListeners();
  }

  void toggleErstellt(String teil1, String teil2) {
    if (erstellteRezepte.contains(WordPair(teil1, teil2))) {
      erstellteRezepte.remove(WordPair(teil1, teil2));
    } else {
      erstellteRezepte.add(WordPair(teil1, teil2));
    }
    notifyListeners();
  }
}

// ThemeModes

