import 'dart:math';

import 'package:Barfbook/home.dart';
import 'package:Barfbook/Screens/Barfbook/createSchedule.dart';
import 'package:Barfbook/Screens/Barfbook/editRecipe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import 'createRecipe.dart';

class ScreenBarfbook extends StatelessWidget {
  var appBarConstraints = 0.0;

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [
        SliverOverlapAbsorber(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          sliver: SliverAppBar(
              pinned: true,
              expandedHeight: 100,
              flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                appBarConstraints = constraints.biggest.height;
                double opacityVar = appBarConstraints.floor() == 159
                    ? 1
                    : (((appBarConstraints - 137).abs()) * 0.045);
                opacityVar <= 0
                    ? opacityVar = 0
                    : opacityVar >= 1
                        ? opacityVar = 1
                        : opacityVar;
                return FlexibleSpaceBar(
                    title: Opacity(
                        opacity: opacityVar,
                        child: Text("Barfbook",
                            style: Theme.of(context).textTheme.titleLarge)),
                    centerTitle:
                        appBarConstraints.floor() <= 137 ? true : false);
              })),
        ),
      ],
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(height: 70),
              Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                      initiallyExpanded: true,
                      title: Center(child: Text("Meine Wochenpläne")),
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: ElevatedButton(
                              onPressed: () =>
                                  Get.to(() => ScreenCreateSchedule()),
                              child: Text("Wochenplan erstellen"),
                            )),
                        ButtonRezeptErstellen(),
                      ])),
              SizedBox(height: 30),
              Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                      initiallyExpanded: true,
                      title: Center(child: Text("Meine Rezepte")),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ErstellteRezepte(),
                        ),
                        ButtonRezeptErstellen(),
                      ])),
              SizedBox(height: 30),
              Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                      initiallyExpanded: true,
                      title: Center(child: Text("Meine Favoriten")),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: GespeicherteRezepte(),
                        ),
                        ButtonRezeptFinden(),
                      ])),
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
    return KeineFavoritenRezepte();
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
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
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
    return KeineErstelltenRezepte();
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
      onPressed: () {
        Get.to(() => ScreenCreateRecipe());
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
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      children: [
        ListTile(
          leading: Icon(Icons.favorite),
        ),
      ],
    );
  }
}

class ErstelltenListe extends StatelessWidget {
  const ErstelltenListe({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      children: [
        ListTile(
          onTap: () {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return ScreenEditRecipe();
                });
          },
          leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              decoration: BoxDecoration(
                  border: Border(
                      right: BorderSide(
                          width: 1.0,
                          color: Theme.of(context).colorScheme.onSecondary))),
              child: Icon(Icons.library_books)),
          title: Text("pair"),
        ),
      ],
    );
  }
}
