import 'package:Barfbook/Screens/Barfbook/addPet.dart';
import 'package:Barfbook/Screens/Barfbook/editPet.dart';
import 'package:Barfbook/Screens/Barfbook/petDetailPage.dart';
import 'package:Barfbook/Screens/Barfbook/pet_controller.dart';
import 'package:Barfbook/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenSchedule extends StatefulWidget {
  @override
  State<ScreenSchedule> createState() => _ScreenScheduleState();
}

class _ScreenScheduleState extends State<ScreenSchedule> {
  final Controller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                  title: Text(
                "Planer",
                style: TextStyle(fontSize: 31),
              ))
            ];
          },
          body: SafeArea(
              child: Column(
            children: [
              controller.userPetListDB.isEmpty
                  ? addPetCard(context)
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
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.surface,
                                    radius: 64,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: Image.memory(pet.avatar)
                                                  .image)),
                                    ),
                                  ),
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
                      return Wrap(children: list);
                    }),
            ],
          ))),
    );
  }

  Widget addPetCard(BuildContext context) {
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
