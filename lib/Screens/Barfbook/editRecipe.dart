import 'package:Barfbook/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenEditRecipe extends StatelessWidget {
  ScreenEditRecipe({super.key});

  @override
  Widget build(BuildContext context) {
    late String teil1;
    late String teil2;

    return AlertDialog(
      scrollable: true,
      title: Text("{pair} bearbeiten"),
      content: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Tschüß")),
            TextField(
              onChanged: (textfeld1text) {
                teil1 = textfeld1text;
              },
              decoration:
                  InputDecoration(border: OutlineInputBorder(), labelText: "1"),
            ),
            SizedBox(height: 10),
            TextField(
              onChanged: (textfeld2ext) {
                teil2 = textfeld2ext;
              },
              decoration:
                  InputDecoration(border: OutlineInputBorder(), labelText: "2"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Bearbeiten"))
          ],
        ),
      ),
    );
  }
}
