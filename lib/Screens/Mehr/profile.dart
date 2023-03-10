import 'package:Barfbook/Screens/Mehr/settings.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
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
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 21),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text("${userdata["email"]}"),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.33,
                        child: Column(
                          children: [
                            Text(
                              "0",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text("Rezepte")
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.33,
                        child: Column(
                          children: [
                            Text(
                              "0",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Pfoten",
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.33,
                        child: Column(
                          children: [
                            Text(
                              "0",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Kommentare",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Container(
                  color: Theme.of(context).colorScheme.onSecondary,
                  child: Center(
                      child: Column(
                    children: [
                      SizedBox(height: 30),
                      Text(
                        "Über mich",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 21),
                      ),
                      SizedBox(height: 20),
                      Text(
                        userdata['description'],
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  )),
                ),
              ],
            ),
          ),
        ]));
  }
}
