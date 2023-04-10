import 'package:Barfbook/Screens/Barfbook/barfbook_controller.dart';
import 'package:Barfbook/Screens/Mehr/profile.dart';
import 'package:Barfbook/Screens/explore/newRecipe.dart';
import 'package:Barfbook/Screens/explore/popularRecipe.dart';
import 'package:Barfbook/Screens/explore/recipeDetailPage.dart';
import 'package:Barfbook/controller.dart';
import 'package:Barfbook/loading.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenExplore extends StatefulWidget {
  @override
  State<ScreenExplore> createState() => _ScreenExploreState();
}

class _ScreenExploreState extends State<ScreenExplore>
    with AutomaticKeepAliveClientMixin<ScreenExplore> {
  final Controller controller = Get.find();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    Recipe recipe = controller.exploreRecipeList[index];

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: Padding(
                padding: EdgeInsets.only(top: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hallo ${controller.userProfile['user'].name}",
                          style: TextStyle(fontSize: 31),
                        ),
                        Text(
                          "Entdecke neues",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.menu),
                    )
                  ],
                ),
              ),
            )
          ];
        },
        body: RefreshIndicator(
          onRefresh: () => _pullRefresh(),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  _searchBar(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Beliebte Rezepte",
                        style: TextStyle(fontSize: 24),
                      ),
                      IconButton(
                          onPressed: () {
                            Get.to(() => ScreenPopularRecipe());
                          },
                          icon: Icon(Icons.arrow_forward_sharp))
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: [
                      for (var recipe in controller.exploreRecipeList)
                        GestureDetector(
                          onTap: () {
                            for (var map in controller.userLikedRecipeXrefDB) {
                              if (map?.containsKey("recipe") ?? false) {
                                if (map['recipe'] == recipe.id) {
                                  Get.to(() => RecipeDetailPage(
                                        recipe: recipe,
                                        favorite: true,
                                      ));
                                  return;
                                }
                              }
                            }
                            Get.to(() => RecipeDetailPage(
                                  recipe: recipe,
                                  favorite: false,
                                ));
                            return;
                          },
                          child: Card(
                            child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          recipe.name,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        TextButton.icon(
                                            onPressed: () {
                                              Get.to(() => ScreenProfile(
                                                  profile: controller
                                                          .exploreProfileList[
                                                      index]));
                                            },
                                            icon: Image.asset(
                                              'assets/images/defaultAvatar.png',
                                              height: 24,
                                            ),
                                            label: Text(recipe.user)),
                                      ],
                                    ),
                                    TextButton.icon(
                                        onPressed: () {},
                                        icon: Image.asset(
                                          'assets/icons/paw.png',
                                          width: 48,
                                        ),
                                        label: Text(
                                          '${recipe.paws}',
                                          style: TextStyle(
                                              fontSize: 21,
                                              fontWeight: FontWeight.bold),
                                        ))
                                  ],
                                )),
                          ),
                        )
                    ]),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Neue Rezepte",
                        style: TextStyle(fontSize: 24),
                      ),
                      IconButton(
                          onPressed: () {
                            Get.to(() => ScreenNewRecipe());
                          },
                          icon: Icon(Icons.arrow_forward_sharp))
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: [
                      for (var recipe in controller.exploreRecipeList)
                        GestureDetector(
                          onTap: () {
                            for (var map in controller.userLikedRecipeXrefDB) {
                              if (map?.containsKey("recipe") ?? false) {
                                if (map['recipe'] == recipe.id) {
                                  Get.to(() => RecipeDetailPage(
                                        recipe: recipe,
                                        favorite: true,
                                      ));
                                  return;
                                }
                              }
                            }
                            Get.to(() => RecipeDetailPage(
                                  recipe: recipe,
                                  favorite: false,
                                ));
                            return;
                          },
                          child: Card(
                            child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          recipe.name,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        TextButton.icon(
                                            onPressed: () {
                                              Get.to(() => ScreenProfile(
                                                  profile: controller
                                                          .exploreProfileList[
                                                      index]));
                                            },
                                            icon: Image.asset(
                                              'assets/images/defaultAvatar.png',
                                              height: 24,
                                            ),
                                            label: Text(recipe.user)),
                                      ],
                                    ),
                                    TextButton.icon(
                                        onPressed: () {},
                                        icon: Image.asset(
                                          'assets/icons/paw.png',
                                          width: 48,
                                        ),
                                        label: Text(
                                          '${recipe.paws}',
                                          style: TextStyle(
                                              fontSize: 21,
                                              fontWeight: FontWeight.bold),
                                        ))
                                  ],
                                )),
                          ),
                        )
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> _pullRefresh() async {
    loadExplorePage();
    setState(() {});
  }

  Padding _searchBar() {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: TextField(
        decoration: InputDecoration(
            hintText: 'Suche',
            prefixIcon: Icon(Icons.search, color: Colors.grey),
            suffixIcon: Icon(Icons.menu, color: Colors.grey),
            contentPadding: EdgeInsets.all(20),
            border: OutlineInputBorder(borderSide: BorderSide(width: 1))),
      ),
    );
  }
}
