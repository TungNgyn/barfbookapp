import 'package:Barfbook/Screens/Barfbook/barfbook_controller.dart';
import 'package:flutter/material.dart';

class ScreenAddPet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Haustier hinzufügen"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: Icon(Icons.add),
                onPressed: () async {},
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                          child: Card(
                              child: FlutterLogo(
                        size: 350,
                      )))),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Name"),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Alter"),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Gewicht in Gramm"),
                  ),
                ]))));
  }
}
