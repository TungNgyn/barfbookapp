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
                      Card(
                        child: Container(
                          width: 400,
                          height: 250,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12))),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 10),
                                  child: Text(
                                    "Täglicher Bedarf",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 28),
                                  ),
                                ),
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Fleisch',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 21),
                                    ),
                                    Text('Muskelfleisch'),
                                    Text('Pansen/Magen'),
                                    Text('Muskelfleisch'),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
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
