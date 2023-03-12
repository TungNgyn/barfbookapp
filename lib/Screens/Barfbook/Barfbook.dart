import 'dart:async';

import 'package:Barfbook/controller.dart';
import 'package:Barfbook/home.dart';
import 'package:Barfbook/Screens/Barfbook/createSchedule.dart';
import 'package:Barfbook/Screens/Barfbook/editRecipe.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'createRecipe.dart';

class ScreenBarfbook extends StatefulWidget {
  @override
  State<ScreenBarfbook> createState() => _ScreenBarfbookState();
}

class _ScreenBarfbookState extends State<ScreenBarfbook> {
  var recipeList = [].obs;

  final Controller controller = Get.find();

  var appBarConstraints = 0.0;

  updateRecipeList() async {
    controller.userRecipeList = await supabase
        .from('recipe')
        .select('id, created_at, name, description, paws')
        .eq('user_id', user!.id);
    recipeList.clear();
    for (var recipe in controller.userRecipeList) {
      recipeList.add(Recipe(
          name: (recipe as Map)['name'],
          createdAt: recipe['created_at'],
          paws: recipe['paws']));
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> _pullRefresh() async {
    controller.userRecipeList = await supabase
        .from('recipe')
        .select('id, created_at, name, description, paws')
        .eq('user_id', user!.id);
    setState(() {
      recipeList.clear();
      for (var recipe in controller.userRecipeList) {
        recipeList.add(Recipe(
            name: (recipe as Map)['name'],
            createdAt: recipe['created_at'],
            paws: recipe['paws']));
      }
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: updateRecipeList(),
      builder: (context, snapshot) {
        return snapshot.connectionState == ConnectionState.done
            ? Scaffold(
                body: NestedScrollView(
                headerSliverBuilder: (_, __) => [
                  SliverAppBar(
                    expandedHeight: 100,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        "Barfbook",
                        style: TextStyle(color: Colors.amber),
                      ),
                    ),
                  )
                ],
                body: RefreshIndicator(
                  onRefresh: _pullRefresh,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Column(
                        children: [
                          // Schedule
                          Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                  initiallyExpanded: true,
                                  title:
                                      Center(child: Text("Meine Wochenpläne")),
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: ElevatedButton(
                                          onPressed: () => Get.to(
                                              () => ScreenCreateSchedule()),
                                          child: Text("Wochenplan erstellen"),
                                        )),
                                  ])),
                          SizedBox(height: 30),
                          //Recipe
                          Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                  initiallyExpanded: true,
                                  title: Center(child: Text("Meine Rezepte")),
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          print(user!.id);
                                          print(controller.userRecipeList);
                                        },
                                        child: Text("show")),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          controller.userRecipeList.isEmpty
                                              ? noRecipeCreated()
                                              : Obx(() {
                                                  List<Widget> list = [];
                                                  for (Recipe recipe
                                                      in recipeList) {
                                                    list.add(SizedBox(
                                                      height: 40,
                                                      child: ElevatedButton.icon(
                                                          style: ButtonStyle(),
                                                          onPressed: () {},
                                                          icon: Image.asset(
                                                              "assets/images/recipe/icons/beef.png"),
                                                          label: Text(
                                                              recipe.name)),
                                                    ));
                                                  }
                                                  list.add(TextButton(
                                                    onPressed: () {
                                                      Get.to(() =>
                                                          ScreenCreateRecipe());
                                                    },
                                                    child: Icon(
                                                      Icons.add_circle_outline,
                                                      size: 50,
                                                    ),
                                                  ));
                                                  return Column(children: list);
                                                }),
                                        ],
                                      ),
                                    ),
                                  ])),
                          SizedBox(height: 30),
                          // Favorite
                          Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                  initiallyExpanded: true,
                                  title: Center(child: Text("Meine Favoriten")),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Card(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Column(children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Image.asset(
                                                    'assets/images/rezept.png',
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.2,
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
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ElevatedButton(
                                        // style: ElevatedButton.styleFrom(
                                        //     primary: theme.colorScheme.secondary),
                                        onPressed: () {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Home()));
                                        },
                                        child: Text("Lieblingsrezepte finden")),
                                  ])),
                        ],
                      ),
                    ],
                  ),
                ),
              ))
            : Center(child: CircularProgressIndicator());
      },
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

class Recipe {
  const Recipe({
    required this.name,
    required this.createdAt,
    required this.paws,
  });

  final String name;
  final String createdAt;
  final int paws;
}
