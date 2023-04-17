import 'package:flutter/material.dart';

class ThankPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Danksagung")),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: ListView(
            children: [
              Text('An dieser Stelle möchte ich meinen Dank aussprechen.'),
              Text(
                  "\nIch bedanke mich bei Nikita Golubev aus flaticon.com für die bereitgestellten Grafiken."),
              Text.rich(
                  TextSpan(text: '\nEin besonderer Dank geht an ', children: [
                TextSpan(
                    text: 'Anna Eichmann',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: ' und ihrem Hund '),
                TextSpan(
                    text: 'Stein',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                    text:
                        ', die mich bei der Entwicklung von Barfbook tatkräftig unterstützt und an das Thema Barf herangeführt haben. Ohne sie wäre die Idee gar nicht erst entstanden.'),
              ])),
              Text(
                  '\nZuletzt möchten wir uns bei allen bedanken, die dazu beigetragen haben, dass Barfbook zu dem geworden ist, was es heute ist.'),
              Text(
                '\nVielen Dank, dass ihr uns auf dieser Reise begleitet!',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                  '\nWir sind stolz darauf, Teil einer Gemeinschaft zu sein, die sich für die artgerechte und gesunde Ernährung von Hunden einsetzt. Wir sind bestrebt, weiterhin eine nützliche Ressource für Hundebesitzer bereitzustellen und freuen uns darauf, euch auf dieser Reise begleiten zu dürfen.'),
            ],
          ),
        ));
  }
}
