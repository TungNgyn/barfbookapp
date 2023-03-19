import 'package:Barfbook/Screens/Lexikon/lexicon.dart';
import 'package:Barfbook/Screens/Mehr/settings.dart';
import 'package:Barfbook/Screens/explore/explore.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:get/get.dart';

import 'Screens/Barfbook/Barfbook.dart';
import 'controller.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _selectedPageIndex;
  List<Widget> _pages = [
    ScreenExplore(),
    ScreenBarfbook(),
    ScreenLexicon(),
    ScreenSettings()
  ];
  late PageController _pageController =
      PageController(initialPage: _selectedPageIndex);

  @override
  void initState() {
    super.initState();

    _selectedPageIndex = 0;
    _pages = [
      ScreenExplore(),
      ScreenBarfbook(),
      ScreenLexicon(),
      ScreenSettings()
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Navigation
  var navigationIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: [
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
            currentIndex: _selectedPageIndex,
            onTap: (selectedPageIndex) {
              setState(() {
                _selectedPageIndex = selectedPageIndex;
                _pageController.jumpToPage(selectedPageIndex);
              });
            }));
  }
}
