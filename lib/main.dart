import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Screens/Home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StartState(),
      child: MaterialApp(
        home: ScreenHome(),
        title: "Barfbook",
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch(
              primarySwatch: MaterialColor(0xFF4F7942, {
                50: Color.fromRGBO(4, 57, 39, .1),
                100: Color.fromRGBO(4, 57, 39, .2),
                200: Color.fromRGBO(4, 57, 39, .3),
                300: Color.fromRGBO(4, 57, 39, .4),
                400: Color.fromRGBO(4, 57, 39, .5),
                500: Color.fromRGBO(4, 57, 39, .6),
                600: Color.fromRGBO(4, 57, 39, .7),
                700: Color.fromRGBO(4, 57, 39, .8),
                800: Color.fromRGBO(4, 57, 39, .9),
                900: Color.fromRGBO(4, 57, 39, 1),
              }),
              brightness: Brightness.dark),
        ),
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Color(0xFF679267), brightness: Brightness.light),
        ),
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

  void toggleErstellt() {
    if (erstellteRezepte.contains(WordPair.random())) {
      erstellteRezepte.remove(WordPair.random());
    } else {
      erstellteRezepte.add(WordPair.random());
    }
    notifyListeners();
  }
}
