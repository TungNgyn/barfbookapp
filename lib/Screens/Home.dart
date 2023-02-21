import 'package:flutter/material.dart';

import 'Barfbook/Barfbook.dart';
import 'Entdecken.dart';
import 'Profil.dart';
import 'Suche.dart';

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
        print("ScreenEntdecken");
        appBarTitel = 'Entdecken';
        break;
      case 1:
        seite = ScreenSuche();
        print("ScreenSuche");
        appBarTitel = 'Suche';
        break;
      case 2:
        seite = ScreenBarfbook();
        print("ScreenBarfbook");
        appBarTitel = 'Barfbook';
        break;
      case 3:
        seite = ScreenProfil();
        print("ScreenProfil");
        appBarTitel = 'Profil';
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
            icon: Icon(Icons.account_circle),
            label: 'Profil',
          )
        ],
      ),
    );
  }
}
