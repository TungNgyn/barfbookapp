import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary.withAlpha(50),
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            Icons.close,
            size: 40,
          ),
        ),
      ),
      backgroundColor:
          Theme.of(context).colorScheme.onSurfaceVariant.withAlpha(200),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: Colors.grey.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              children: [
                Image.asset(
                  'assets/icons/icon.png',
                  height: 128,
                ),
                Text(
                  "Barfbook+",
                  style: TextStyle(
                      fontSize: 31,
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
                Text(
                  'Entdecke alle Vorteile von Barfbook+',
                  style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.check),
                          Text("erstelle und speichere mehr Rezepte")
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.check),
                          Text("füge mehr Haustiere hinzu")
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.check),
                          Text("plane mehr Rezepte am Tag ein")
                        ],
                      ),
                      Row(
                        children: [Icon(Icons.check), Text("entferne Werbung")],
                      ),
                      Row(
                        children: [
                          Icon(Icons.check),
                          Text("unterstütze Barfbook")
                        ],
                      ),
                      Container(
                        height: 50,
                        child: Card(
                          color: Theme.of(context)
                              .colorScheme
                              .primaryContainer
                              .withOpacity(0.8),
                          child: Row(
                            children: [
                              Radio(
                                  value: true,
                                  groupValue: true,
                                  onChanged: (value) {}),
                              Text.rich(TextSpan(
                                  text: "0,99€ ",
                                  style: TextStyle(fontSize: 21),
                                  children: [
                                    TextSpan(
                                        text: "monatlich",
                                        style: TextStyle(fontSize: 16))
                                  ]))
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 80,
                        child: Card(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          child: Row(
                            children: [
                              Radio(
                                  value: false,
                                  groupValue: true,
                                  onChanged: (value) {}),
                              Text(
                                "11,99€ ",
                                style: TextStyle(
                                  fontSize: 21,
                                  decoration: TextDecoration.lineThrough,
                                  decorationThickness: 2.0,
                                ),
                              ),
                              Text.rich(TextSpan(
                                  text: "9,99€ ",
                                  style: TextStyle(
                                    fontSize: 21,
                                  ),
                                  children: [
                                    TextSpan(
                                        text: "jährlich",
                                        style: TextStyle(fontSize: 16))
                                  ]))
                            ],
                          ),
                        ),
                      ),
                      Text("Es gelten unsere allgemeinen Geschäftsbedingungen.")
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
