import 'package:Barfbook/Screens/Barfbook/barfbook_controller.dart';
import 'package:Barfbook/Screens/Mehr/profile.dart';
import 'package:Barfbook/Screens/explore/newRecipe.dart';
import 'package:Barfbook/Screens/explore/popularRecipe.dart';
import 'package:Barfbook/Screens/explore/recipeDetailPage.dart';
import 'package:Barfbook/controller.dart';
import 'package:Barfbook/loading.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ScreenExplore extends StatefulWidget {
  @override
  State<ScreenExplore> createState() => _ScreenExploreState();
}

class _ScreenExploreState extends State<ScreenExplore>
    with AutomaticKeepAliveClientMixin<ScreenExplore> {
  final Controller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                toolbarHeight: 100,
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    GestureDetector(
                      onTap: () {
                        if (controller.userProfile['user'].name != 'Gast') {
                          Get.to(() => ScreenProfile(
                              profile: controller.userProfile['user']));
                        }
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 32,
                        child: controller.userProfile['user'].avatar,
                      ),
                    ),
                  ],
                ),
              )
            ];
          },
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: ListView(
              children: [
                _searchBar(),
                sortPopularRecipe(),
                exploreRecipeRow(context),
                sortNewRecipe(),
                exploreRecipeRow(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SingleChildScrollView exploreRecipeRow(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        for (var recipe in controller.exploreRecipeList)
          RecipeCard(controller: controller, recipe: recipe)
      ]),
    );
  }

  Row sortPopularRecipe() {
    controller.exploreRecipeList.sort(((a, b) => b.paws.compareTo(a.paws)));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Beliebte Rezepte",
          style: TextStyle(fontSize: 21),
        ),
        IconButton(
            onPressed: () {
              Get.to(() => ScreenPopularRecipe());
            },
            icon: Icon(Icons.arrow_forward_sharp))
      ],
    );
  }

  Row sortNewRecipe() {
    controller.exploreRecipeList
        .sort(((a, b) => b.created_at.compareTo(a.created_at)));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Neue Rezepte",
          style: TextStyle(fontSize: 21),
        ),
        IconButton(
            onPressed: () {
              Get.to(() => ScreenNewRecipe());
            },
            icon: Icon(Icons.arrow_forward_sharp))
      ],
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
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
      ),
    );
  }
}

class RecipeCard extends StatelessWidget {
  const RecipeCard({
    super.key,
    required this.controller,
    required this.recipe,
  });

  final Controller controller;
  final recipe;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: Colors.grey.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Container(
          color: Theme.of(context).colorScheme.surface,
          height: 200,
          width: 168,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                child: Container(height: 96, child: recipe.avatar),
              ),
              Expanded(
                child: Padding(
                    padding: EdgeInsets.only(
                        left: 15, right: 15, bottom: 10, top: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recipe.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton.icon(
                                onPressed: () {
                                  Get.to(() =>
                                      ScreenProfile(profile: recipe.user));
                                },
                                icon: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 14,
                                    child: recipe.userAvatar),
                                label: Text(
                                  recipe.user.name,
                                )),
                            FaIcon(
                              FontAwesomeIcons.paw,
                            ),
                            Text(
                              '${recipe.paws}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
