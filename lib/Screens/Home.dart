import 'package:Barfbook/Screens/Lexikon/lexicon.dart';
import 'package:Barfbook/Screens/Mehr/settings.dart';
import 'package:Barfbook/Screens/explore.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'Barfbook/Barfbook.dart';

class ScreenHome extends StatefulWidget {
  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  // Navigation
  var appBarTitel;
  var navigationIndex = 0;

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    Widget seite;
    switch (navigationIndex) {
      case 0:
        seite = ScreenExplore();
        break;
      case 1:
        seite = ScreenBarfbook();
        break;
      case 2:
        seite = ScreenLexicon();
        break;
      case 3:
        seite = ScreenSettings();
        break;
      default:
        throw UnimplementedError('Kein Widget für ${navigationIndex}');
    }

    void _onNavigationTap(int index) {
      setState(() {
        navigationIndex = index;
      });
    }

    return Scaffold(
      body: PageTransitionSwitcher(
        transitionBuilder: (
          Widget child,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: seite,
      ),
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Theme.of(context).colorScheme.primary,
        currentIndex: navigationIndex,
        onTap: _onNavigationTap,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Entdecken',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Barfbook',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Lexikon',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'Mehr',
          )
        ],
      ),
    );
  }
}
