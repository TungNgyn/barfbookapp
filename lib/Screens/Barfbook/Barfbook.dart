import 'dart:math';

import 'package:Barfbook/Screens/Barfbook/Bearbeitung.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../Home.dart';
import 'Erstellung.dart';

class ScreenBarfbook extends StatelessWidget {
  var appBarConstraints = 0.0;

  @override
  Widget build(BuildContext context) {
    var startState = context.watch<StartState>();
    return NestedScrollView(
      headerSliverBuilder: (_, __) => [
        SliverPersistentHeader(
          delegate: BarfbookAppBar(expandedHeight: 200),
          pinned: true,
        ),

        // SliverAppBar(
        //     pinned: true,
        //     backgroundColor: Colors.amber,
        //     expandedHeight: 100,
        //     flexibleSpace: LayoutBuilder(
        //         builder: (BuildContext context, BoxConstraints constraints) {
        //       appBarConstraints = constraints.biggest.height;
        //       double opacityVar = appBarConstraints >= 151
        //           ? 1
        //           : appBarConstraints <= 108
        //               ? 1
        //               : (1 - 100 / appBarConstraints);
        //       return FlexibleSpaceBar(
        //         title: Opacity(
        //             opacity: opacityVar,
        //             child: Text(
        //               "Barfbook",
        //             )),
        //         centerTitle: appBarConstraints <= 108 ? true : false,
        //       );
        //     })),
      ],
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(height: 50),
              Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                      title: Center(
                          child: Text(startState.erstellteRezepte.isEmpty
                              ? "Meine Rezepte"
                              : startState.erstellteRezepte.length == 1
                                  ? "Mein Rezept"
                                  : "Meine ${startState.erstellteRezepte.length} Rezepte")),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ErstellteRezepte(),
                        ),
                        startState.erstellteRezepte.isEmpty
                            ? SizedBox()
                            : ButtonRezeptErstellen(),
                      ])),
              SizedBox(height: 30),
              Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                      title: Center(
                          child: Text(startState.favoriten.isEmpty
                              ? "Meine Favoriten"
                              : startState.favoriten.length == 1
                                  ? "Mein Favorit"
                                  : "Meine ${startState.favoriten.length} Favoriten")),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: GespeicherteRezepte(),
                        ),
                        startState.favoriten.isEmpty
                            ? SizedBox()
                            : ButtonRezeptFinden(),
                      ])),
            ],
          ),
        ],
      ),
    );
  }
}

class BarfbookAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  BarfbookAppBar({required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Container(
          color: Colors.blue,
          child: Center(
            child: Opacity(
              opacity: shrinkOffset / expandedHeight,
              child: Text(
                "Barfbook",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Positioned(
          top: expandedHeight / 2 - shrinkOffset,
          left: MediaQuery.of(context).size.width / 4,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Card(
              elevation: 10,
              child: SizedBox(
                height: expandedHeight,
                width: MediaQuery.of(context).size.width / 2,
                child: FlutterLogo(),
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

class GespeicherteRezepte extends StatelessWidget {
  const GespeicherteRezepte({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var startState = context.watch<StartState>();

    if (startState.favoriten.isNotEmpty) {
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
                  ButtonRezeptFinden(),
                ],
              ),
            ]),
          ),
        ),
      ],
    );
  }
}

class ButtonRezeptFinden extends StatelessWidget {
  const ButtonRezeptFinden({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        // style: ElevatedButton.styleFrom(
        //     primary: theme.colorScheme.secondary),
        onPressed: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => ScreenHome()));
        },
        child: Text("Lieblingsrezepte finden"));
  }
}

class ErstellteRezepte extends StatelessWidget {
  const ErstellteRezepte({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var startState = context.watch<StartState>();
    if (startState.erstellteRezepte.isNotEmpty) {
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
    return Row(
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
                  ButtonRezeptErstellen()
                ],
              ),
            ],
          ),
        )),
      ],
    );
  }
}

class ButtonRezeptErstellen extends StatelessWidget {
  const ButtonRezeptErstellen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        showModalBottomSheet<void>(
            isDismissible: false,
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
    WordPair pair;

    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        for (pair in startState.erstellteRezepte)
          ListTile(
            onTap: () {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return ScreenRezeptBearbeitung(pair: pair);
                  });
            },
            leading: Icon(Icons.library_books),
            title: Text(pair.asLowerCase),
          ),
      ],
    );
  }
}
