import 'dart:async';

import 'package:Barfbook/Screens/explore/explore.dart';
import 'package:Barfbook/Screens/explore/recipeDetailPage.dart';
import 'package:Barfbook/controller.dart';
import 'package:Barfbook/home.dart';
import 'package:Barfbook/Screens/Barfbook/createSchedule.dart';
import 'package:Barfbook/Screens/Barfbook/editRecipe.dart';
import 'package:Barfbook/loading.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
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

  updateRecipeList() async {
    controller.userRecipeListDB = await supabase
        .from('recipe')
        .select('id, created_at, modified_at, name, description')
        .eq('user_id', user!.id);
    controller.userRecipeList.clear();
    for (var recipe in controller.userRecipeListDB) {
      controller.userRecipeList.add(Recipe(
          name: (recipe as Map)['name'],
          id: recipe['id'],
          created_at: recipe['created_at'],
          paws: 0,
          description: recipe['description'],
          modified_at: recipe['modified_at'],
          user_id: user!.id,
          user: ""));
    }
  }

  @override
  void initState() {
    super.initState();
    updateRecipeList();
  }

  Future<void> _pullRefresh() async {
    setState(() {
      initData();
    });
    return;
  }

  int tabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: tabIndex,
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) => [
            SliverAppBar(
              title: Text(
                "Barfbook",
                style: TextStyle(fontSize: 31),
              ),
              pinned: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              bottom: TabBar(labelStyle: TextStyle(fontSize: 12), tabs: [
                Tab(
                    child: Column(
                  children: [
                    Image.asset("assets/icons/recipe.png", width: 32),
                    Text("Rezepte")
                  ],
                )),
                Tab(
                    child: Column(
                  children: [
                    Image.asset("assets/icons/favorite.png", width: 32),
                    Text("Favoriten")
                  ],
                )),
              ]),
            ),
          ],
          body: SafeArea(
            child: TabBarView(children: [
              // // Schedule
              // SingleChildScrollView(
              //   child: Padding(
              //       padding: EdgeInsets.all(20.0),
              //       child: ElevatedButton(
              //         onPressed: () => Get.to(() => ScreenCreateSchedule()),
              //         child: Text("Wochenplan erstellen"),
              //       )),
              // ),
              //Recipe
              Scaffold(
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerFloat,
                  floatingActionButton: FloatingActionButton.large(
                    onPressed: () {
                      Get.to(() => ScreenCreateRecipe());
                    },
                    child: Icon(Icons.add),
                  ),
                  body: CustomScrollView(slivers: [
                    SliverFillRemaining(
                      child: controller.userRecipeListDB.isEmpty
                          ? noRecipeCreated()
                          : Obx(() {
                              List<Widget> list = [];
                              // list.add(TextButton(
                              //   onPressed: () {
                              //     Get.to(() => ScreenCreateRecipe());
                              //   },
                              //   child: Icon(
                              //     Icons.add_circle_outline,
                              //     size: 50,
                              //   ),
                              // ));
                              for (Recipe recipe in controller.userRecipeList) {
                                list.add(SizedBox(
                                  height: 40,
                                  child: ElevatedButton(
                                    child: Text(recipe.name),
                                    style: ButtonStyle(),
                                    onPressed: () {
                                      Get.to(() => ScreenEditRecipe(
                                            recipe: recipe,
                                          ));
                                    },
                                  ),
                                ));
                              }
                              return Column(children: list);
                            }),
                    ),
                  ])),
              // Favorite
              Scaffold(
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerFloat,
                  floatingActionButton: FloatingActionButton.large(
                    onPressed: () {
                      Get.offAll(() => Home());
                    },
                    child: Icon(Icons.search),
                  ),
                  body: CustomScrollView(slivers: [
                    SliverFillRemaining(
                      child: controller.userLikedRecipe.isEmpty
                          ? Card(
                              child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image.asset(
                                    'assets/images/rezept.png',
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                  ),
                                ),
                                Column(
                                  children: [
                                    Text(
                                        'Du hast noch keine Rezepte gespeichert.'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ]),
                            )
                          : Obx(() {
                              List<Widget> list = [];
                              for (Recipe recipe
                                  in controller.userLikedRecipe) {
                                list.add(SizedBox(
                                  height: 40,
                                  child: ElevatedButton.icon(
                                      style: ButtonStyle(),
                                      onPressed: () {
                                        Get.to(() => RecipeDetailPage(
                                              recipe: recipe,
                                              favorite: true,
                                            ));
                                      },
                                      icon: Image.asset(
                                          "assets/images/recipe/icons/beef.png"),
                                      label: Text(recipe.name)),
                                ));
                              }
                              return Column(children: list);
                            }),
                    ),
                  ])),
            ]),
          ),
        ),
      ),
    );
  }
}

class noRecipeCreated extends StatelessWidget {
  const noRecipeCreated({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              'assets/images/barfbook.png',
              width: MediaQuery.of(context).size.width * 0.2,
            ),
          ),
          Column(
            children: [
              Text("Du hast noch kein eigenes Rezept erstellt."),
              Text("Fang jetzt damit an!"),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Get.to(() => ScreenCreateRecipe());
                },
                child: Icon(
                  Icons.add_circle_outline,
                  size: 50,
                ),
              )
            ],
          ),
        ],
      ),
    ));
  }
}
