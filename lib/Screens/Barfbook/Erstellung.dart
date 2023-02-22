import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class ScreenErstellung extends StatelessWidget {
  late String teil1;
  late String teil2;

  @override
  Widget build(BuildContext context) {
    var startState = context.watch<StartState>();
    return Container(
      height: MediaQuery.of(context).size.height * 0.89,
      child: Column(
        children: [
          ListTile(
            title: Row(
              children: [
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Abbrechen")),
                ),
                Flexible(
                    flex: 5,
                    fit: FlexFit.tight,
                    child: Center(child: Text("Neues Rezept"))),
                Flexible(
                    flex: 3,
                    fit: FlexFit.tight,
                    child: TextButton(
                        onPressed: () {
                          startState.toggleErstellt(teil1, teil2);
                          Navigator.of(context).pop();
                        },
                        child: Text("Hinzufügen"))),
              ],
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: 350,
            child: TextField(
              onChanged: (textfeld1text) {
                teil1 = textfeld1text;
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Rezeptname"),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: 350,
            child: TextField(
                onChanged: (textfeld2text) {
                  teil2 = textfeld2text;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Wort2")),
          ),
          ElevatedButton(
              onPressed: () {
                print(teil1);
              },
              child: Text("klick"))
        ],
      ),
    );
  }
}
