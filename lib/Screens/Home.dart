import 'package:Barfbook/Screens/Lexikon/Lexikon.dart';
import 'package:Barfbook/Screens/Mehr/Mehr.dart';
import 'package:flutter/material.dart';

import 'Barfbook/Barfbook.dart';
import 'Entdecken.dart';
import 'Lexikon/Suche.dart';

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
        seite = ScreenLexikon();
        break;
      case 2:
        seite = ScreenBarfbook();
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
      // appBar: AppBar(
      //   scrolledUnderElevation: 2,
      //   shadowColor: Theme.of(context).colorScheme.shadow,
      //   title: Center(
      //       child: Text(appBarTitel,
      //           style: TextStyle(fontWeight: FontWeight.bold))),
      // ),
      body: Center(
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
            icon: Icon(Icons.search),
            label: 'Suche',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Barfbook',
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
