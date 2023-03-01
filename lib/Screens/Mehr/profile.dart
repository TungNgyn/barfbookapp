import 'package:Barfbook/Screens/Mehr/settings.dart';
import 'package:Barfbook/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class ScreenProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var startState = context.watch<StartState>();

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text("Profil"),
          backgroundColor: Colors.transparent,
        ),
        body: Stack(children: [
          Opacity(
            opacity: 0.4,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/barfbookapp.png"),
                      fit: BoxFit.cover)),
            ),
          ),
          SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  CircleAvatar(
                    backgroundImage:
                        AssetImage("assets/images/defaultAvatar.png"),
                    radius: 65,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 24),
                    child: Text(
                      "${userdata["name"]}",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 21),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text("${userdata["email"]}"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 24, left: 42, right: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "0",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text("Rezepte",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary
                                        .withOpacity(0.8)))
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "0",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Pfoten",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "0",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Kommentare",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Expanded(
                    child: Container(
                      color: Theme.of(context).colorScheme.onPrimary,
                      child: Center(
                          child: Column(
                        children: [
                          SizedBox(height: 50),
                          Text(
                            "Über mich",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 17),
                          )
                        ],
                      )),
                    ),
                  )
                ],
              ),
            ),
          )
        ]));
  }
}
