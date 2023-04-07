import 'package:Barfbook/Screens/calculator/editPet.dart';
import 'package:Barfbook/Screens/calculator/pet_controller.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenPetDetailPage extends StatefulWidget {
  ScreenPetDetailPage({required this.pet});
  Pet pet;

  @override
  State<ScreenPetDetailPage> createState() => _ScreenPetDetailPageState();
}

class _ScreenPetDetailPageState extends State<ScreenPetDetailPage> {
  late String owner;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadOwner(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.done
            ? Scaffold(
                extendBodyBehindAppBar: true,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: IconButton(
                        icon: Icon(Icons.create),
                        onPressed: () {
                          Get.to(() => ScreenEditPet(pet: widget.pet));
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
                              image:
                                  AssetImage("assets/images/barfbookapp.png"),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  Center(
                    child: Column(children: [
                      SafeArea(
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/defaultAvatar.png"),
                              radius: 65,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 24),
                              child: Text(
                                "${widget.pet.name}",
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
                              child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                PetInfo(owner: owner, pet: widget.pet),
                                SizedBox(height: 30),
                                FeedingCard(
                                  pet: widget.pet,
                                  days: 1,
                                  meat: 80,
                                  vegetables: 20,
                                ),
                              ],
                            ),
                          )),
                        ),
                      ),
                    ]),
                  )
                ]))
            : Center(child: CircularProgressIndicator()));
  }

  loadOwner() async {
    List ownerDB = await supabase
        .from('profile')
        .select('name')
        .eq('id', widget.pet.owner);
    owner = (ownerDB[0] as Map)['name'];
  }
}

class PetInfo extends StatelessWidget {
  const PetInfo({super.key, required this.owner, required this.pet});

  final String owner;
  final Pet pet;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Besitzer',
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
          Text(
            '${owner}',
            style: TextStyle(fontSize: 21),
          )
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Alter',
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
          Text(
            '${pet.age} Jahre',
            style: TextStyle(fontSize: 21),
          )
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Rasse',
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
          Text(
            '${pet.breed}',
            style: TextStyle(fontSize: 21),
          )
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Geschlecht',
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
          Text(
            '${pet.gender}',
            style: TextStyle(fontSize: 21),
          )
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Gewicht',
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
          Text(
            '${pet.weight / 1000}kg',
            style: TextStyle(fontSize: 21),
          )
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Tägliche Ration',
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
          Text(
            '${pet.ration}%',
            style: TextStyle(fontSize: 21),
          )
        ],
      ),
    ]);
  }
}

class FeedingCard extends StatelessWidget {
  const FeedingCard(
      {super.key,
      required this.pet,
      required this.days,
      required this.meat,
      required this.vegetables});

  final Pet pet;
  final int days;
  final int meat;
  final int vegetables;

  @override
  Widget build(BuildContext context) {
    final double ration = pet.weight * pet.ration / 100;
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Täglicher Bedarf",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                    ),
                    Text(
                      '${ration * days}g',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Fleisch ($meat%)',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 21),
                      ),
                      Text(
                          '${((ration / 100 * meat) * days).toStringAsFixed(2)}g',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 21))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Muskelfleisch (50%)'),
                      Text(
                          '${(((ration / 100 * meat) * 0.5) * days).toStringAsFixed(1)}g')
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Pansen/Magen (20%)'),
                      Text(
                          '${(((ration / 100 * meat) * 0.2) * days).toStringAsFixed(1)}g')
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('fleischige Knochen (15%)'),
                      Text(
                          '${(((ration / 100 * meat) * 0.15) * days).toStringAsFixed(1)}g')
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Organe (15%)'),
                      Text(
                          '${(((ration / 100 * meat) * 0.15) * days).toStringAsFixed(1)}g')
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
                          '${((ration / 100 * vegetables) * days).toStringAsFixed(2)}g',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 21))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Gemüse (80%)'),
                      Text(
                          '${(((ration / 100 * vegetables) * 0.8) * days).toStringAsFixed(1)}g')
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Obst (20%)'),
                      Text(
                          '${(((ration / 100 * vegetables) * 0.2) * days).toStringAsFixed(1)}g')
                    ],
                  ),
                  // Divider(),
                  // Container(
                  //   height: 20,
                  //   child: TextButton(
                  //     child: Text("Details"),
                  //     onPressed: () {},
                  //   ),
                  // )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
