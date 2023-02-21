// Screen Barfbook
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:namer_app/Screens/Barfbook/Erstellung.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../Home.dart';

class ScreenBarfbook extends StatelessWidget {
  var appBarConstraints = 0.0;

  @override
  Widget build(BuildContext context) {
    var startState = context.watch<StartState>();

    return NestedScrollView(
      headerSliverBuilder: (_, __) => [
        SliverAppBar(
            pinned: true,
            expandedHeight: 100,
            flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              appBarConstraints = constraints.biggest.height;
              double opacityVar = appBarConstraints >= 151
                  ? 1
                  : appBarConstraints <= 108
                      ? 1
                      : (1 - 100 / appBarConstraints);
              return FlexibleSpaceBar(
                title: Opacity(
                    opacity: opacityVar,
                    child: Text(
                      "Barfbook",
                      style: TextStyle(
                          color: MediaQuery.of(context).platformBrightness ==
                                  Brightness.dark
                              ? Colors.white
                              : Colors.black),
                    )),
                centerTitle: appBarConstraints <= 108 ? true : false,
              );
            })),
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
              ErstellteRezepte(),
              SizedBox(height: 20),
              Text("Meine Favoriten:",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              GespeicherteRezepte(),
            ],
          ),
        ],
      ),
    );
  }
}

class GespeicherteRezepte extends StatelessWidget {
  const GespeicherteRezepte({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var startState = context.watch<StartState>();
    var theme = Theme.of(context);
    var style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    if (!startState.favoriten.isEmpty) {
      return Column(
        children: [
          FavoritenListe(startState: startState),
        ],
      );
    } else {
      return KeineFavoritenRezepte();
    }
  }
}

class KeineFavoritenRezepte extends StatelessWidget {
  const KeineFavoritenRezepte({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                      // style: ElevatedButton.styleFrom(
                      //     primary: theme.colorScheme.secondary),
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

class ErstellteRezepte extends StatelessWidget {
  const ErstellteRezepte({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var startState = context.watch<StartState>();
    if (!startState.erstellteRezepte.isEmpty) {
      return Column(
        children: [
          ErstelltenListe(startState: startState),
        ],
      );
    } else {
      return KeineErstelltenRezepte();
    }
  }
}

class KeineErstelltenRezepte extends StatelessWidget {
  const KeineErstelltenRezepte({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var startState = context.watch<StartState>();
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
                      onPressed: () async {
                        // startState.toggleErstellt();
                        showModalBottomSheet<void>(
                            enableDrag: false,
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return ScreenErstellung();
                            });
                      },
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
        for (var pair in startState.favoriten)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(pair.asLowerCase),
          ),
      ],
    );
  }
}

class ErstelltenListe extends StatelessWidget {
  const ErstelltenListe({
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
        for (var pair in startState.erstellteRezepte)
          ListTile(
            leading: Icon(Icons.library_books),
            title: Text(pair.asLowerCase),
          ),
      ],
    );
  }
}
