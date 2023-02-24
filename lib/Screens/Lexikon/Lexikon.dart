import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

import 'DetailPage.dart';

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
            Text(
              "Alles zum Thema Barf.",
              style: TextStyle(
                  fontSize: 21,
                  color: Theme.of(context).colorScheme.onSecondary),
            ),
            SizedBox(
              height: 20,
            ),
            WhatIsBarfCard(),
            WhatIsBarfCard(),
          ],
        ),
      ),
    );
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
