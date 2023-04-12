import 'package:Barfbook/Screens/calculator/addPet.dart';
import 'package:Barfbook/Screens/calculator/calculator.dart';
import 'package:Barfbook/Screens/calculator/editPet.dart';
import 'package:Barfbook/Screens/calculator/petDetailPage.dart';
import 'package:Barfbook/Screens/calculator/pet_controller.dart';
import 'package:Barfbook/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenCalculator extends StatefulWidget {
  @override
  State<ScreenCalculator> createState() => _ScreenCalculatorState();
}

class _ScreenCalculatorState extends State<ScreenCalculator> {
  final Controller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {
          controller.userProfile['user'].name == 'Gast'
              ? Get.snackbar("Registrierung",
                  "Du musst angemeldet sein, um ein Haustier hinzuzufügen.")
              : Get.to(() => ScreenAddPet());
        },
        child: Icon(Icons.add),
      ),
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
              controller.userPetListDB.isEmpty
                  ? AddPetCard(context)
                  : Obx(() {
                      List<Widget> list = [];
                      for (Pet pet in controller.userPetList) {
                        list.add(
                            //   SizedBox(
                            //   height: 40,
                            //   child:
                            //   ElevatedButton.icon(
                            //       onPressed: () {
                            // Get.to(() => ScreenPetDetailPage(pet: pet));
                            //       },
                            //       icon: Image.asset(
                            //           "assets/images/recipe/icons/beef.png"),
                            //       label: Text(pet.name)),
                            // ));
                            GestureDetector(
                          onTap: () {
                            Get.to(() => ScreenPetDetailPage(pet: pet));
                          },
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Card(
                              child: Column(
                                children: [
                                  Text(
                                    pet.name,
                                    style: TextStyle(
                                        fontSize: 21,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text('${pet.age} Jahre'),
                                  Text('${pet.breed}'),
                                  Text(
                                      '${(pet.weight / 1000).toStringAsFixed(1)}kg'),
                                  Text('${pet.ration}% tägliche Ration'),
                                  Text('${pet.gender}')
                                ],
                              ),
                            ),
                          ),
                        ));
                      }
                      return Column(children: list);
                    }),
            ],
          ))),
    );
  }

  Widget AddPetCard(BuildContext context) {
    return Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  'assets/icons/petCard.png',
                  width: MediaQuery.of(context).size.width * 0.2,
                ),
              ),
              Column(
                children: [
                  Text("Du hast noch keine Haustiere hinzugefügt."),
                  Text("Trage jetzt einen ein!"),
                ],
              ),
            ],
          ),
        ));
  }
}
