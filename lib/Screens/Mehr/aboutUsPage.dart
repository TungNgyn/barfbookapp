import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Über uns"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Willkommen bei Barfbook!",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                  "Unser Ziel ist es, Tierbesitzern dabei zu helfen, ihre Haustiere optimal zu ernähren und ihre Gesundheit zu fördern."),
            ),
            Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text.rich(TextSpan(
                    text:
                        "Das Projekt entstand durch eine einzige Person, mit dem Gedanken eine ",
                    children: [
                      TextSpan(
                        text: "Barf-Kalkulation und Rationierung",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: " immer parat zu haben.")
                    ]))),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text.rich(
                  TextSpan(text: "Des Weiteren wurde nach einer ", children: [
                TextSpan(
                    text: "Alternative ",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                    text:
                        "zu der industriellen Dosen- und Trockenfütterung gesucht, die nicht selten verweigert wurde.")
              ])),
            ),
            Image(image: Image.asset('assets/images/Stein.png').image),
            Padding(
              padding: EdgeInsets.only(left: 20, bottom: 10),
              child: Text.rich(TextSpan(
                  text: 'Der Miniature Bullterrier ',
                  style: TextStyle(fontSize: 13),
                  children: [
                    TextSpan(
                        text: "Stein",
                        style: TextStyle(fontWeight: FontWeight.bold))
                  ])),
            ),
            Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                    "Unsere App bietet eine umfassende und benutzerfreundliche Plattform, auf der Hundehalter und Hundehalterinnen alle notwendigen Informationen und Anleitungen zur Barf-Fütterung finden können. \nVon der Auswahl der richtigen Zutaten bis hin zur Zusammenstellung eines ausgewogenen Mahlzeitenplans - unsere App begleitet dich auf jeder Stufe.")),
            Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                    "Wir sind stolz darauf, Teil der Barf-Gemeinschaft zu sein und freuen uns darauf, dich auf deiner Reise zur optimalen Tierernährung zu begleiten."))
          ],
        ),
      ),
    );
  }
}
