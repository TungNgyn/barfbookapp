import 'package:Barfbook/Screens/Account/Login.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:json_theme/json_theme.dart';
import 'package:get/get.dart';

import 'package:flutter/services.dart';
import 'dart:convert';
import 'Screens/Account/AuthController.dart';
import 'Screens/Home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await firebaseInitialization.then((value) => {
        Get.put(AuthController()),
      });

  var helligkeit = SchedulerBinding.instance.window.platformBrightness;
  bool darkModus = helligkeit == Brightness.dark;

  final themeStr = darkModus == true
      ? await rootBundle.loadString('assets/themes/appainter_theme_dark.json')
      : await rootBundle.loadString('assets/themes/appainter_theme_light.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson);

  runApp(MainApp(theme: theme));
}

class MainApp extends StatelessWidget {
  final ThemeData? theme;
  const MainApp({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StartState(),
      child: GetMaterialApp(
        home: ScreenLogIn(),
        title: "Barfbook",
        theme: theme,
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
