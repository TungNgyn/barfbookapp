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
              Text('An dieser Stelle möchten wir unseren Dank aussprechen.'),
              Text(
                  "\nWir bedanken uns bei Nikita Golubev und Freepik aus flaticon.com für die bereitgestellten Grafiken und Icons."),
              Text.rich(TextSpan(
                  text: '\nEin ganz besonderer Dank geht an ',
                  children: [
                    TextSpan(
                        text: 'Anna Eichmann',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: ' und ihrem Hund '),
                    TextSpan(
                        text: 'Stein',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                        text:
                            ', die uns bei der Entwicklung von Barfbook tatkräftig unterstützt und an das Thema Barf herangeführt haben. Ohne sie wäre das Projekt gar nicht erst entstanden.'),
                  ])),
              Text(
                  '\nAußerdem möchten wir uns bei allen bedanken, die dazu beigetragen haben, dass Barfbook zu dem geworden ist, was es heute ist.'),
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
