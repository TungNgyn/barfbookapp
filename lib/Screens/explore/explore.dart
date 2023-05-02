import 'package:Barfbook/Screens/Mehr/profile.dart';
import 'package:Barfbook/Screens/explore/newRecipe.dart';
import 'package:Barfbook/Screens/explore/popularRecipe.dart';
import 'package:Barfbook/Screens/explore/recipeDetailPage.dart';
import 'package:Barfbook/controller.dart';
import 'package:Barfbook/loading.dart';
import 'package:Barfbook/Screens/Barfbook/pet_controller.dart';
import 'package:Barfbook/main.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:Barfbook/util/admin.dart';
import 'package:Barfbook/util/database/database.dart';
import 'package:Barfbook/util/widgets/avatar_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:drift_db_viewer/drift_db_viewer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ScreenExplore extends StatefulWidget {
  @override
  State<ScreenExplore> createState() => _ScreenExploreState();
}

class _ScreenExploreState extends State<ScreenExplore>
    with AutomaticKeepAliveClientMixin<ScreenExplore> {
  final Controller controller = Get.find();

  Future<void> _refreshPage() async {
    setState(() {
      initExplorerNewRecipe();
      initExplorerPopularRecipe();
    });
  }

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
                          "Hallo ${userProfile.rank == 'guest' ? 'Gast' : userProfile.name}",
                          style: TextStyle(fontSize: 31),
                        ),
                        Text(
                          "Entdecke neues",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    if (userProfile.rank == 'admin')
                      ElevatedButton(
                          onPressed: () async {
                            Get.to(() => Admin());
                          },
                          child: Text("TEST")),
                    GestureDetector(
                      onTap: () {
                        if (userProfile.rank != 'guest') {
                          Get.to(
                              () => ScreenProfile(profileId: userProfile.id));
                        }
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 32,
                        child: getUserAvatar(userProfile.id),
                      ),
                    ),
                  ],
                ),
              )
            ];
          },
          body: RefreshIndicator(
            onRefresh: _refreshPage,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ListView(
                children: [
                  _searchBar(),
                  sortPopularRecipe(),
                  explorePopularRecipeRow(context),
                  sortNewRecipe(),
                  exploreNewRecipeRow(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SingleChildScrollView explorePopularRecipeRow(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        for (var recipe in controller.explorePopularRecipeList)
          RecipeCard(controller: controller, recipe: recipe)
      ]),
    );
  }

  SingleChildScrollView exploreNewRecipeRow(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        for (var recipe in controller.exploreNewRecipeList)
          RecipeCard(controller: controller, recipe: recipe)
      ]),
    );
  }

  Row sortPopularRecipe() {
    // controller.explorePopularProfileList
    //     .sort(((a, b) => b.paws.compareTo(a.paws)));
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
    // controller.explorePopularProfileList
    //     .sort(((a, b) => b.created_at.compareTo(a.created_at)));
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
    // loadExplorePage();
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

class RecipeCard extends StatefulWidget {
  const RecipeCard({
    super.key,
    required this.controller,
    required this.recipe,
  });

  final Controller controller;
  final Recipe recipe;

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  Profile? profile;
  Future? _future;

  @override
  void initState() {
    _future =
        getRecipeUserProfile(widget.recipe.userId).then((value) => setState(() {
              profile = value;
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.done
            ? GestureDetector(
                onTap: () {
                  for (var map in widget.controller.userLikedRecipe) {
                    if (map?.containsKey("recipe") ?? false) {
                      if (map['recipe'] == widget.recipe.id) {
                        Get.to(() => RecipeDetailPage(
                              recipe: widget.recipe,
                              favorite: true,
                            ));
                        return;
                      }
                    }
                  }
                  Get.to(() => RecipeDetailPage(
                        recipe: widget.recipe,
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
                    height: 200,
                    width: 168,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, right: 10, left: 10),
                          child: Container(
                              height: 96,
                              child: getRecipeAvatar(widget.recipe.id)),
                        ),
                        Expanded(
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: 15, right: 15, bottom: 10, top: 5),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.recipe.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton.icon(
                                          onPressed: () {
                                            Get.to(() => ScreenProfile(
                                                profileId: profile!.id));
                                          },
                                          icon: CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              radius: 14,
                                              child:
                                                  getUserAvatar(profile!.id)),
                                          label: profile == null
                                              ? CircularProgressIndicator()
                                              : Text(profile!.name)),
                                      FaIcon(
                                        FontAwesomeIcons.paw,
                                      ),
                                      Text(
                                        '${widget.recipe.paws}',
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
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}

class BigRecipeCard extends StatefulWidget {
  const BigRecipeCard({
    super.key,
    required this.controller,
    required this.recipe,
  });

  final Controller controller;
  final recipe;

  @override
  State<BigRecipeCard> createState() => _BigRecipeCardState();
}

class _BigRecipeCardState extends State<BigRecipeCard> {
  Profile? profile;
  Future? _future;
  @override
  void initState() {
    _future =
        getRecipeUserProfile(widget.recipe.userId).then((value) => setState(() {
              profile = value;
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.done
            ? GestureDetector(
                onTap: () {
                  for (var map in widget.controller.userLikedRecipe) {
                    if (map?.containsKey("recipe") ?? false) {
                      if (map['recipe'] == widget.recipe.id) {
                        Get.to(() => RecipeDetailPage(
                              recipe: widget.recipe,
                              favorite: true,
                            ));
                        return;
                      }
                    }
                  }
                  Get.to(() => RecipeDetailPage(
                        recipe: widget.recipe,
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
                    height: 150,
                    width: 336,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, right: 10, left: 10),
                          child: Container(
                              height: 128,
                              width: 128,
                              child: getRecipeAvatar(widget.recipe.id)),
                        ),
                        Expanded(
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: 15, right: 15, bottom: 10, top: 5),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.recipe.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton.icon(
                                          onPressed: () {
                                            Get.to(() => ScreenProfile(
                                                profileId: profile!.id));
                                          },
                                          icon: CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              radius: 14,
                                              child:
                                                  getUserAvatar(profile!.id)),
                                          label: Text(profile!.name)),
                                      Row(
                                        children: [
                                          FaIcon(
                                            FontAwesomeIcons.paw,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              '${widget.recipe.paws}',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ],
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
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
