import 'package:Barfbook/Screens/Lexikon/Lexikon.dart';
import 'package:Barfbook/Screens/Mehr/Mehr.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

import 'Barfbook/Barfbook.dart';
import 'Entdecken.dart';

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
    Widget seite;
    switch (navigationIndex) {
      case 0:
        seite = ScreenEntdecken();
        break;
      case 1:
        seite = ScreenBarfbook();
        break;
      case 2:
        seite = ScreenLexikon();
        break;
      case 3:
        seite = ScreenMehr();
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
