import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

import 'DetailPage.dart';

final Map<String, Map<String, dynamic>> articlesCards = {
  "Ice Cream": {
    "title": "Ice cream is made with carrageenan …",
    "image":
        "https://images.unsplash.com/photo-1516559828984-fb3b99548b21?ixlib=rb-1.2.1&auto=format&fit=crop&w=2100&q=80"
  }
};

class ScreenLexikon extends StatefulWidget {
  @override
  _lexikonStartState createState() => _lexikonStartState();
}

class _lexikonStartState extends State<ScreenLexikon> {
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
                        child: Text("Lexikon",
                            style: Theme.of(context).textTheme.titleLarge)),
                    centerTitle:
                        appBarConstraints.floor() <= 137 ? true : false);
              })),
        ),
      ],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 120),
            Container(
              padding: EdgeInsets.only(right: 24, left: 24, bottom: 36),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8, top: 32),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Alles zum Thema Barf.",
                        style: TextStyle(
                            fontSize: 21, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: CardHorizontal(),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      CardSmall(
                        cta: "View article",
                        title: articlesCards["Ice Cream"]!['title'],
                        img: articlesCards["Ice Cream"]!['image'],
                      ),
                      CardSmall()
                    ],
                  )
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}

class CardHorizontal extends StatelessWidget {
  CardHorizontal(
      {this.title = "Placeholder Title",
      this.cta = "",
      this.img = "https://via.placeholder.com/200"});

  final String cta;
  final String img;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 130,
        child: OpenContainer(
            openBuilder: (context, closedContainer) {
              return DetailPage(
                titleIcon: WhatIsBarf().titleIcon,
                titleText: WhatIsBarf().titleText,
                textContent: WhatIsBarf().textContent,
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
      this.img = "https://via.placeholder.com/200"});

  final String cta;
  final String img;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Container(
            height: 235,
            child: OpenContainer(
                openBuilder: (context, closedContainer) {
                  return DetailPage(
                    titleIcon: WhatIsBarf().titleIcon,
                    titleText: WhatIsBarf().titleText,
                    textContent: WhatIsBarf().textContent,
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

class WhatIsBarfCard extends StatelessWidget {
  const WhatIsBarfCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      openBuilder: (context, closedContainer) {
        return DetailPage(
          titleIcon: WhatIsBarf().titleIcon,
          titleText: WhatIsBarf().titleText,
          textContent: WhatIsBarf().textContent,
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
              elevation: 5,
              color: Colors.grey,
              child: Container(
                  height: 200,
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, bottom: 22.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text(WhatIsBarf().titleText,
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                                fontSize: 30,
                                fontWeight: FontWeight.bold)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            WhatIsBarf().subTitleText,
                            style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer),
                          )
                        ],
                      )
                    ],
                  ))),
        );
      },
    );
  }
}

class WhatIsBarf {
  Icon titleIcon = Icon(
    Icons.question_mark,
    color: Colors.white,
    size: 40.0,
  );
  String titleText = 'Was ist Barf?';
  String subTitleText = 'Alle Antworten zu deinen Fragen.';
  String textContent =
      'BARF bzw. Barfen steht für die Rohfütterung von verschiedenen Tieren. Der Begriff stammt ursprünglich aus den USA und war zunächst ein Kurzwort für „born again raw feeders“, also „wiedergeborene Rohfütterer“. Hierbei wurde auch auf den ideologischen Aspekt dieser Fütterungsform eingegangen. Eine weitere Bedeutung ist „bones and raw food" - Knochen und rohes Futter, was die Hauptkomponenten beim Barfen umschreibt. In Deutschland hat sich die Langform „biologisch artgerechte Rohfütterung“ durchgesetzt.'
      'BARF bzw. Barfen steht für die Rohfütterung von verschiedenen Tieren. Der Begriff stammt ursprünglich aus den USA und war zunächst ein Kurzwort für „born again raw feeders“, also „wiedergeborene Rohfütterer“. Hierbei wurde auch auf den ideologischen Aspekt dieser Fütterungsform eingegangen. Eine weitere Bedeutung ist „bones and raw food" - Knochen und rohes Futter, was die Hauptkomponenten beim Barfen umschreibt. In Deutschland hat sich die Langform „biologisch artgerechte Rohfütterung“ durchgesetzt.';
}
