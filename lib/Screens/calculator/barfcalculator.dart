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
                  ? AddPetCard()
                  : Obx(() {
                      List<Widget> list = [];
                      list.add(TextButton(
                        onPressed: () {
                          Get.to(() => ScreenAddPet());
                        },
                        child: Icon(
                          Icons.add_circle_outline,
                          size: 50,
                        ),
                      ));
                      for (Pet pet in controller.userPetList) {
                        list.add(SizedBox(
                          height: 40,
                          child: ElevatedButton.icon(
                              onPressed: () {
                                Get.to(() => ScreenPetDetailPage(pet: pet));
                              },
                              icon: Image.asset(
                                  "assets/images/recipe/icons/beef.png"),
                              label: Text(pet.name)),
                        ));
                      }
                      return Column(children: list);
                    }),
            ],
          ))),
    );
  }
}

class AddPetCard extends StatelessWidget {
  const AddPetCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
        ));
  }
}
