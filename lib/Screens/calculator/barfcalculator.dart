import 'package:Barfbook/Screens/calculator/addPet.dart';
import 'package:Barfbook/Screens/calculator/calculator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenCalculator extends StatefulWidget {
  @override
  State<ScreenCalculator> createState() => _ScreenCalculatorState();
}

class _ScreenCalculatorState extends State<ScreenCalculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                  title: Text(
                "Barfrechner",
                style: TextStyle(fontSize: 31),
              ))
            ];
          },
          body: SafeArea(
              child: Column(
            children: [
              Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset(
                            'assets/images/calculator/icons/minibull.png',
                            width: MediaQuery.of(context).size.width * 0.2,
                          ),
                        ),
                        Column(
                          children: [
                            Text("Du hast noch keine Haustiere hinzugefügt."),
                            Text("Trage jetzt einen ein!"),
                            SizedBox(height: 10),
                            IconButton(
                              onPressed: () {
                                Get.to(() => ScreenAddPet());
                              },
                              icon: Icon(Icons.add_circle_outline),
                              iconSize: 50,
                            )
                          ],
                        ),
                      ],
                    ),
                  )),
              ElevatedButton(
                  onPressed: () {
                    Get.to(() => Calculator());
                  },
                  child: Text("Rechner"))
            ],
          ))),
    );
  }
}
