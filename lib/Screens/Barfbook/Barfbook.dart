import 'package:Barfbook/Screens/Barfbook/addPet.dart';
import 'package:Barfbook/Screens/Barfbook/pet_controller.dart';
import 'package:Barfbook/Screens/Barfbook/petDetailPage.dart';
import 'package:Barfbook/Screens/explore/explore.dart';
import 'package:Barfbook/controller.dart';
import 'package:Barfbook/home.dart';
import 'package:Barfbook/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'barfbook_controller.dart';
import 'createRecipe.dart';

class ScreenBarfbook extends StatefulWidget {
  @override
  State<ScreenBarfbook> createState() => _ScreenBarfbookState();
}

class _ScreenBarfbookState extends State<ScreenBarfbook> {
  final Controller controller = Get.find();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _refreshPets() async {
    setState(() {
      initPetList();
    });
  }

  Future<void> _refreshRecipe() async {
    setState(() {
      initUserCreatedRecipe();
    });
  }

  Future<void> _refreshFavorite() async {
    setState(() {
      initFavorite();
    });
  }

  int tabIndex = 1;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: tabIndex,
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) => [
            SliverAppBar(
              centerTitle: true,
              title: Text(
                "Barfbook",
                style: TextStyle(fontSize: 31),
              ),
              pinned: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              bottom: TabBar(labelStyle: TextStyle(fontSize: 12), tabs: [
                Tab(child: Image.asset("assets/icons/pet.png", width: 44)),
                Tab(child: Image.asset("assets/icons/recipe.png", width: 42)),
                Tab(child: Image.asset("assets/icons/favorite.png", width: 42)),
              ]),
            ),
          ],
          body: TabBarView(children: [
            // Pets
            Scaffold(
              resizeToAvoidBottomInset: false,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  controller.userProfile['user'].name == 'Gast'
                      ? Get.snackbar("Registrierung",
                          "Du musst angemeldet sein, um ein Haustier hinzuzufügen.",
                          backgroundColor:
                              Theme.of(context).colorScheme.outlineVariant)
                      : Get.to(() => ScreenAddPet());
                },
                child: Icon(Icons.add),
              ),
              body: RefreshIndicator(
                onRefresh: _refreshPets,
                child: CustomScrollView(slivers: [
                  SliverToBoxAdapter(
                      child: controller.userPetList.isEmpty
                          ? addPetCard(context)
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  child: Text(
                                    "Hunde",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                for (Pet pet in controller.userPetList)
                                  BigPetCard(pet: pet)
                              ])))
                ]),
              ),
            ),

            //Recipe
            Scaffold(
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    controller.userProfile['user'].name == 'Gast'
                        ? Get.snackbar("Registrierung",
                            "Du musst angemeldet sein, um ein Rezept zu erstellen.",
                            backgroundColor:
                                Theme.of(context).colorScheme.outlineVariant)
                        : Get.to(() => ScreenCreateRecipe());
                  },
                  child: Icon(Icons.add),
                ),
                body: RefreshIndicator(
                  onRefresh: _refreshRecipe,
                  child: CustomScrollView(slivers: [
                    SliverToBoxAdapter(
                      child: controller.userRecipeListDB.isEmpty
                          ? noRecipeCreatedCard(context)
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    child: Text(
                                      "Rezepte",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Obx(() {
                                    List<Widget> list = [];
                                    for (Recipe recipe
                                        in controller.userRecipeList) {
                                      list.add(BigRecipeCard(
                                          controller: controller,
                                          recipe: recipe));
                                    }
                                    return Wrap(children: list);
                                  }),
                                ],
                              ),
                            ),
                    )
                  ]),
                )),
            // Favorite
            Scaffold(
                resizeToAvoidBottomInset: false,
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Get.offAll(() => Home());
                  },
                  child: Icon(Icons.search),
                ),
                body: RefreshIndicator(
                  onRefresh: _refreshFavorite,
                  child: CustomScrollView(slivers: [
                    SliverToBoxAdapter(
                      child: controller.userLikedRecipe.isEmpty
                          ? noFavoriteRecipeCard(context)
                          : Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    "Favoriten",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Obx(() {
                                      List<Widget> list = [];
                                      for (Recipe recipe
                                          in controller.userLikedRecipe) {
                                        list.add(BigRecipeCard(
                                            controller: controller,
                                            recipe: recipe));
                                      }
                                      return Wrap(children: list);
                                    })),
                              ],
                            ),
                    ),
                  ]),
                )),
          ]),
        ),
      ),
    );
  }

  Widget noRecipeCreatedCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Image.asset(
                'assets/icons/recipe_color.png',
                width: MediaQuery.of(context).size.width * 0.2,
              ),
              const SizedBox(height: 10),
              const Text(
                "Du hast noch kein eigenes Rezept erstellt.",
                textAlign: TextAlign.center,
              ),
              const Text(
                "Fang jetzt damit an!",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget noFavoriteRecipeCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Image.asset(
                'assets/icons/favorite_color.png',
                width: MediaQuery.of(context).size.width * 0.2,
              ),
              const SizedBox(height: 10),
              const Text(
                'Du hast noch keine Rezepte gespeichert.',
                textAlign: TextAlign.center,
              ),
              const Text(
                'Finde die besten Rezepte!',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget addPetCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Image.asset(
                'assets/icons/petCard.png',
                width: MediaQuery.of(context).size.width * 0.2,
              ),
              const SizedBox(height: 10),
              const Text(
                "Du hast noch keine Haustiere hinzugefügt.",
                textAlign: TextAlign.center,
              ),
              const Text(
                "Trage jetzt einen ein!",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PetCard extends StatelessWidget {
  final Pet pet;

  PetCard({required this.pet});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ScreenPetDetailPage(pet: pet));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: Colors.grey.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Container(
          height: 224,
          width: 176,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  radius: 56,
                  child: pet.avatar,
                ),
                Text(
                  pet.name,
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                ),
                Text('${pet.age} Jahre'),
                Text(
                  '${pet.breed}',
                  style: TextStyle(overflow: TextOverflow.ellipsis),
                ),
                Text('${(pet.weight / 1000).toStringAsFixed(1)}kg'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BigPetCard extends StatelessWidget {
  final Pet pet;

  BigPetCard({required this.pet});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ScreenPetDetailPage(pet: pet));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: Colors.grey.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Container(
          height: 150,
          width: 336,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  radius: 56,
                  child: pet.avatar,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        pet.name,
                        style: TextStyle(
                            fontSize: 21, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text('${pet.age} Jahre'),
                      Text(
                        '${pet.breed}',
                        style: TextStyle(overflow: TextOverflow.ellipsis),
                      ),
                      Text('${(pet.weight / 1000).toStringAsFixed(1)}kg'),
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
