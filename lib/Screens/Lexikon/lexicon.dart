import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

import 'detailPage.dart';

class ScreenLexicon extends StatefulWidget {
  @override
  _lexikonStartState createState() => _lexikonStartState();
}

class _lexikonStartState extends State<ScreenLexicon> {
  var appBarConstraints = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (_, innerBoxIsScrolled) => [
        SliverAppBar(
            title: Text(
              "Lexikon",
              style: TextStyle(fontSize: 31),
            ),
            floating: true,
            forceElevated: innerBoxIsScrolled),
      ],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Alles zum Thema Barf.",
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: CardHorizontal(
                    cta: "Artikel lesen",
                    titleIcon: articlesCards["Was ist Barf?"]!['titleIcon'],
                    title: articlesCards["Was ist Barf?"]!['title'],
                    subtitle: articlesCards["Was ist Barf?"]!['subtitle'],
                    textContent: articlesCards["Was ist Barf?"]!['textContent'],
                    img: articlesCards["Was ist Barf?"]!['image'],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    CardSmall(
                      cta: "Berechnen",
                      titleIcon: articlesCards["Barf Rechner"]!['titleIcon'],
                      title: articlesCards["Barf Rechner"]!['title'],
                      subtitle: articlesCards["Barf Rechner"]!['subtitle'],
                      textContent:
                          articlesCards["Barf Rechner"]!['textContent'],
                      img: articlesCards["Barf Rechner"]!['image'],
                    ),
                    CardSmall()
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

class CardHorizontal extends StatelessWidget {
  CardHorizontal(
      {this.title = "Placeholder Title",
      this.cta = "",
      this.img = "https://via.placeholder.com/200",
      this.subtitle = "Placeholder Title",
      this.textContent = "",
      this.titleIcon = const Icon(Icons.question_mark)});

  final String cta;
  final String img;
  final String title;
  final Icon titleIcon;
  final String subtitle;
  final String textContent;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 130,
        child: OpenContainer(
            openBuilder: (context, closedContainer) {
              return DetailPage(
                titleIcon: titleIcon,
                titleText: title,
                textContent: textContent,
              );
            },
            openColor: Theme.of(context).cardColor,
            closedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(0))),
            closedElevation: 0,
            closedColor: Theme.of(context).cardColor,
            closedBuilder: (context, openContainer) {
              return GestureDetector(
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0))),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    bottomLeft: Radius.circular(4.0)),
                                image: DecorationImage(
                                  image: NetworkImage(img),
                                  fit: BoxFit.cover,
                                ))),
                      ),
                      Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(title, style: TextStyle(fontSize: 12)),
                                Text(cta,
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              );
            }));
  }
}

class CardSmall extends StatelessWidget {
  CardSmall(
      {this.title = "Placeholder Title",
      this.cta = "",
      this.img = "https://via.placeholder.com/200",
      this.subtitle = "Placeholder Title",
      this.textContent = "",
      this.titleIcon = const Icon(Icons.question_mark)});

  final String cta;
  final String img;
  final String title;
  final Icon titleIcon;
  final String subtitle;
  final String textContent;

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Container(
            height: 235,
            child: OpenContainer(
                openBuilder: (context, closedContainer) {
                  return DetailPage(
                    titleIcon: titleIcon,
                    titleText: title,
                    textContent: textContent,
                  );
                },
                openColor: Theme.of(context).cardColor,
                closedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0))),
                closedElevation: 0,
                closedColor: Theme.of(context).cardColor,
                closedBuilder: (context, openContainer) {
                  return GestureDetector(
                    onTap: () {
                      openContainer();
                    },
                    child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                                flex: 11,
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0)),
                                        image: DecorationImage(
                                          image: NetworkImage(img),
                                          fit: BoxFit.cover,
                                        )))),
                            Flexible(
                                flex: 9,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16.0,
                                      bottom: 16.0,
                                      left: 16.0,
                                      right: 16.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(title,
                                          style: TextStyle(fontSize: 12)),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(cta,
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600)),
                                      )
                                    ],
                                  ),
                                ))
                          ],
                        )),
                  );
                })));
  }
}

final Map<String, Map<String, dynamic>> articlesCards = {
  //Was ist Barf
  "Was ist Barf?": {
    "titleIcon": Icon(
      Icons.question_mark,
      color: Colors.white,
      size: 40.0,
    ),
    "title": "Was ist Barf?",
    "subtitle": "Alle Antworten zu deinen Fragen.",
    "textContent":
        'BARF bzw. Barfen steht für die Rohfütterung von verschiedenen Tieren. Der Begriff stammt ursprünglich aus den USA und war zunächst ein Kurzwort für „born again raw feeders“, also „wiedergeborene Rohfütterer“. Hierbei wurde auch auf den ideologischen Aspekt dieser Fütterungsform eingegangen. Eine weitere Bedeutung ist „bones and raw food" - Knochen und rohes Futter, was die Hauptkomponenten beim Barfen umschreibt. In Deutschland hat sich die Langform „biologisch artgerechte Rohfütterung“ durchgesetzt.'
            'BARF bzw. Barfen steht für die Rohfütterung von verschiedenen Tieren. Der Begriff stammt ursprünglich aus den USA und war zunächst ein Kurzwort für „born again raw feeders“, also „wiedergeborene Rohfütterer“. Hierbei wurde auch auf den ideologischen Aspekt dieser Fütterungsform eingegangen. Eine weitere Bedeutung ist „bones and raw food" - Knochen und rohes Futter, was die Hauptkomponenten beim Barfen umschreibt. In Deutschland hat sich die Langform „biologisch artgerechte Rohfütterung“ durchgesetzt.'
            'BARF bzw. Barfen steht für die Rohfütterung von verschiedenen Tieren. Der Begriff stammt ursprünglich aus den USA und war zunächst ein Kurzwort für „born again raw feeders“, also „wiedergeborene Rohfütterer“. Hierbei wurde auch auf den ideologischen Aspekt dieser Fütterungsform eingegangen. Eine weitere Bedeutung ist „bones and raw food" - Knochen und rohes Futter, was die Hauptkomponenten beim Barfen umschreibt. In Deutschland hat sich die Langform „biologisch artgerechte Rohfütterung“ durchgesetzt.',
    "image":
        "https://images.unsplash.com/photo-1516559828984-fb3b99548b21?ixlib=rb-1.2.1&auto=format&fit=crop&w=2100&q=80"
  },

  // Barf Rechner
  "Barf Rechner": {
    "titleIcon": Icon(
      Icons.question_mark,
      color: Colors.white,
      size: 40.0,
    ),
    "title": "Barf Rechner",
    "subtitle": "Rationierung leicht gemacht",
    "textContent": "ScreenBarfCalculator()",
    "image":
        "https://images.unsplash.com/photo-1482686115713-0fbcaced6e28?fit=crop&w=1947&q=80"
  },
};
