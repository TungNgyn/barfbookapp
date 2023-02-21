import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ScreenErstellung extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                        onPressed: () {}, child: Text("Hinzufügen"))),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: 350,
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Rezeptname"),
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: 350,
            child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Hallo")),
          )
        ],
      ),
    );
  }
}
