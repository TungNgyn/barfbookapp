import 'package:Barfbook/Screens/calculator/editPet.dart';
import 'package:Barfbook/Screens/calculator/pet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenPetDetailPage extends StatelessWidget {
  ScreenPetDetailPage({required this.pet});
  Pet pet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text('${pet.name}'),
          backgroundColor: Colors.transparent,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: Icon(Icons.create),
                onPressed: () {
                  Get.to(() => ScreenEditPet(pet: pet));
                },
              ),
            )
          ],
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
          Center(
            child: Column(children: [
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
                        "${pet.name}",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 21),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.onSecondary,
                  child: Center(
                      child: Column(
                    children: [
                      SizedBox(height: 30),
                      FeedingCard(
                        pet: pet,
                        days: 1,
                        meat: 80,
                        organs: 10,
                        vegetables: 10,
                      ),
                    ],
                  )),
                ),
              ),
            ]),
          )
        ]));
  }
}

class FeedingCard extends StatelessWidget {
  const FeedingCard(
      {super.key,
      required this.pet,
      required this.days,
      required this.meat,
      required this.organs,
      required this.vegetables});

  final Pet pet;
  final int days;
  final int meat;
  final int organs;
  final int vegetables;

  @override
  Widget build(BuildContext context) {
    final double ration = pet.weight * pet.ration / 100;
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Container(
          width: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Täglicher Bedarf",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 26),
                      ),
                      Text(
                        '${ration * days}g',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 26),
                      )
                    ],
                  ),
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Fleisch ($meat%)',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 21),
                        ),
                        Text(
                            '${(ration * meat / 100 * days).toStringAsFixed(2)}g',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 21))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Muskelfleisch (50%)'),
                        Text(
                            '${(ration * (meat / 100) * (50 / meat) * days).toStringAsFixed(1)}g')
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Pansen/Magen (20%)'),
                        Text(
                            '${(ration * (meat / 100) * (20 / meat) * days).toStringAsFixed(1)}g')
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('fleischige Knochen (10%)'),
                        Text(
                            '${(ration * (meat / 100) * (10 / meat) * days).toStringAsFixed(1)}g')
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Innereien ($organs%)',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 21),
                        ),
                        Text(
                            '${(pet.weight * pet.ration / 100 * organs / 100 * days).toStringAsFixed(2)}g',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 21))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Leber (5%)'),
                        Text(
                            '${(pet.weight * pet.ration / 100 * organs / 100 * 5 / organs * days).toStringAsFixed(1)}g')
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('andere Organe (5%)'),
                        Text(
                            '${(pet.weight * pet.ration / 100 * organs / 100 * 5 / organs * days).toStringAsFixed(1)}g')
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Vegetarisch ($vegetables%)',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 21),
                        ),
                        Text(
                            '${(pet.weight * pet.ration / 100 * vegetables / 100 * days).toStringAsFixed(2)}g',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 21))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Gemüse (8%)'),
                        Text(
                            '${(pet.weight * pet.ration / 100 * vegetables / 100 * 8 / vegetables * days).toStringAsFixed(1)}g')
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Obst (2%)'),
                        Text(
                            '${(pet.weight * pet.ration / 100 * vegetables / 100 * 2 / vegetables * days).toStringAsFixed(1)}g')
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
