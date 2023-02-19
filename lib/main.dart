import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF679267)),
        ),
        darkTheme: ThemeData.dark(),
        // themeMode: ThemeMode.system,
        themeMode: ThemeMode.light,
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

  void toggleFavoriten() {
    if (favoriten.contains(rezept)) {
      favoriten.remove(rezept);
    } else {
      favoriten.add(rezept);
    }
    notifyListeners();
  }
}

// Home Screen
class ScreenHome extends StatefulWidget {
  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  // Navigation
  var navigationIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget seite;
    switch (navigationIndex) {
      case 0:
        seite = ScreenEntdecken();
        print("ScreenEntdecken");
        break;
      case 1:
        seite = Placeholder();
        print("ScreenRezepte");
        break;
      case 2:
        seite = ScreenBarfbook();
        print("ScreenBarfbook");
        break;
      case 3:
        seite = ScreenProfil();
        print("ScreenProfil");
        break;
      default:
        throw UnimplementedError('Kein Widget für $navigationIndex');
    }

    void _onNavigationTap(int index) {
      setState(() {
        navigationIndex = index;
      });
    }

    return Scaffold(
      body: Navigator(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationIndex,
        onTap: _onNavigationTap,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Entdecken',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Rezepte',
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

// Screen Entdecken
class ScreenEntdecken extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var startState = context.watch<StartState>();
    var rezept = startState.rezept;

    IconData icon;
    if (startState.favoriten.contains(rezept)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(rezept: rezept),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  startState.toggleFavoriten();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  startState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  final WordPair rezept;
  const BigCard({
    Key? key,
    required this.rezept,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          rezept.asLowerCase,
          style: style,
          semanticsLabel: rezept.asPascalCase,
        ),
      ),
    );
  }
}

// Screen Favoriten
class ScreenRezepte extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var startState = context.watch<StartState>();

    if (startState.favoriten.isEmpty) {
      return Center(
        child: Text('Du hast noch nichts favorisiert.'),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('Du hast '
              '${startState.favoriten.length} Favoriten:'),
        ),
        for (var pair in startState.favoriten)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(pair.asLowerCase),
          ),
      ],
    );
  }
}

// Screen Barfbook
class ScreenBarfbook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var startState = context.watch<StartState>();

    return Scaffold(
      body: Column(
        children: [
          Text('A random idea:'),
          Text(startState.rezept.asPascalCase),
        ],
      ),
    );
  }
}

// Screen Profil
class ScreenProfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var startState = context.watch<StartState>();

    return Text("Profil");
  }
}
