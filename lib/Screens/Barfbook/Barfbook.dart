import 'dart:async';

import 'package:Barfbook/controller.dart';
import 'package:Barfbook/home.dart';
import 'package:Barfbook/Screens/Barfbook/createSchedule.dart';
import 'package:Barfbook/Screens/Barfbook/editRecipe.dart';
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
  var recipeList = [].obs;

  final Controller controller = Get.find();

  var appBarConstraints = 0.0;

  updateRecipeList() async {
    controller.userRecipeList = await supabase
        .from('recipe')
        .select('id, created_at, modified_at, name, description, paws')
        .eq('user_id', user!.id);
    recipeList.clear();
    for (var recipe in controller.userRecipeList) {
      recipeList.add(Recipe(
          name: (recipe as Map)['name'],
          id: recipe['id'],
          created_at: recipe['created_at'],
          paws: recipe['paws'],
          description: recipe['description'],
          modified_at: recipe['modified_at'],
          user_id: user!.id));
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> _pullRefresh() async {
    controller.userRecipeList = await supabase
        .from('recipe')
        .select('id, created_at, modified_at, name, description, paws')
        .eq('user_id', user!.id);
    setState(() {
      recipeList.clear();
      for (var recipe in controller.userRecipeList) {
        recipeList.add(Recipe(
            name: (recipe as Map)['name'],
            id: recipe['id'],
            created_at: recipe['created_at'],
            modified_at: recipe['modified_at'],
            description: recipe['description'],
            user_id: user!.id,
            paws: recipe['paws']));
      }
    });
    return;
  }

  int tabIndex = 1;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: updateRecipeList(),
      builder: (context, snapshot) {
        return snapshot.connectionState == ConnectionState.done
            ? DefaultTabController(
                initialIndex: tabIndex,
                length: 3,
                child: Scaffold(
                  body: NestedScrollView(
                    headerSliverBuilder: (_, __) => [
                      SliverAppBar(
                          expandedHeight: 100,
                          flexibleSpace: FlexibleSpaceBar(
                            centerTitle: true,
                            title: Text("Barfbook"),
                          ),
                          pinned: true),
                      SliverPersistentHeader(
                          pinned: true,
                          delegate: _SliverAppBarDelegate(
                            TabBar(labelStyle: TextStyle(fontSize: 12), tabs: [
                              Tab(
                                  text: "Wochenplan",
                                  icon: Icon(Icons.directions_car)),
                              Tab(
                                  text: "Rezepte",
                                  icon: Icon(Icons.directions_transit)),
                              Tab(
                                  text: "Favoriten",
                                  icon: Icon(Icons.directions_bike)),
                            ]),
                          )),
                    ],
                    body: TabBarView(children: [
                      // Schedule
                      RefreshIndicator(
                        onRefresh: _pullRefresh,
                        child: SingleChildScrollView(
                          child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: ElevatedButton(
                                onPressed: () =>
                                    Get.to(() => ScreenCreateSchedule()),
                                child: Text("Wochenplan erstellen"),
                              )),
                        ),
                      ),
                      //Recipe
                      RefreshIndicator(
                        onRefresh: _pullRefresh,
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              controller.userRecipeList.isEmpty
                                  ? noRecipeCreated()
                                  : Obx(() {
                                      List<Widget> list = [];
                                      list.add(TextButton(
                                        onPressed: () {
                                          Get.to(() => ScreenCreateRecipe());
                                        },
                                        child: Icon(
                                          Icons.add_circle_outline,
                                          size: 50,
                                        ),
                                      ));
                                      for (Recipe recipe in recipeList) {
                                        list.add(SizedBox(
                                          height: 40,
                                          child: ElevatedButton.icon(
                                              style: ButtonStyle(),
                                              onPressed: () {
                                                Get.to(() => ScreenEditRecipe(
                                                      recipeId: recipe.id,
                                                    ));
                                              },
                                              icon: Image.asset(
                                                  "assets/images/recipe/icons/beef.png"),
                                              label: Text(recipe.name)),
                                        ));
                                      }
                                      return Column(children: list);
                                    }),
                            ],
                          ),
                        ),
                      ),
                      // Favorite
                      RefreshIndicator(
                        onRefresh: _pullRefresh,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Image.asset(
                                          'assets/images/rezept.png',
                                          width: MediaQuery.of(context)
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
                        ),
                      ),
                    ]),
                  ),
                ),
              )
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

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
