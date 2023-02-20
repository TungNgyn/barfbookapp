import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        darkTheme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
        ),
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF679267)),
        ),
        themeMode: ThemeMode.dark,
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
        padding: const EdgeInsets.all(20.0),
        child: Text(
          rezept.asLowerCase,
          style: style,
        ),
      ),
    );
  }
}

// Screen Suche
class ScreenSuche extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var startState = context.watch<StartState>();

    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (_, __) => [
        SliverAppBar(
          pinned: true,
          expandedHeight: 110,
          toolbarHeight: 85,
          flexibleSpace: SafeArea(
            child: FlexibleSpaceBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 250,
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide.none),
                          filled: true,
                          hintText: "Suche",
                          hintStyle: TextStyle(fontSize: 15)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
      body: Column(
        children: [
          Card(
            child: Text("alol"),
          )
        ],
      ),
    ));
  }
}

// TextField(
//             decoration: InputDecoration(
//                 filled: true,
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30),
//                     borderSide: BorderSide.none),
//                 hintText: "Suche",
//                 hintStyle: TextStyle(fontSize: 18)),
//           ),
// Screen Barfbook
class ScreenBarfbook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var startState = context.watch<StartState>();

    if (startState.favoriten.isEmpty) {
      return NestedScrollView(
        headerSliverBuilder: (_, __) => [
          SliverAppBar(
            pinned: true,
            expandedHeight: 100,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text("Barfbook"),
            ),
          ),
        ],
        body: ListView(
          children: [
            Column(
              children: [
                Text(
                  "Meine Rezepte:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                KeinErstelltesRezept(),
                SizedBox(height: 20),
                Text("Meine Favoriten:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                KeinGespeichertesRezept(),
              ],
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        FavoritenListe(startState: startState),
      ],
    );
  }
}

class KeinGespeichertesRezept extends StatelessWidget {
  const KeinGespeichertesRezept({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  'assets/images/rezept.png',
                  width: MediaQuery.of(context).size.width * 0.2,
                ),
              ),
              Column(
                children: [
                  Text('Du hast noch keine Rezepte gespeichert.'),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => new ScreenHome()));
                      },
                      child: Text("Lieblingsrezept finden")),
                ],
              ),
            ]),
          ),
        ),
      ],
    );
  }
}

class KeinErstelltesRezept extends StatelessWidget {
  const KeinErstelltesRezept({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
              child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    'assets/images/barfbook.png',
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                ),
                Column(
                  children: [
                    Text("Du hast noch kein eigenes Rezept erstellt."),
                    Text("Fang jetzt damit an!"),
                    SizedBox(height: 10),
                    TextButton(
                      onPressed: () => print("allo"),
                      child: Icon(
                        Icons.add_circle_outline,
                        size: 50,
                      ),
                    )
                  ],
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class FavoritenListe extends StatelessWidget {
  const FavoritenListe({
    super.key,
    required this.startState,
  });

  final StartState startState;

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
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

// Screen Profil
class ScreenProfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var startState = context.watch<StartState>();

    return Text("Profil");
  }
}
