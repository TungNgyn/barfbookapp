import 'package:Barfbook/Screens/Barfbook/barfbook_controller.dart';
import 'package:Barfbook/Screens/Mehr/profile.dart';
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
    super.build(context);
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
              child: ListView(
                children: [
                  _searchBar(),
                  Text(
                    "Beliebt",
                    style: TextStyle(fontSize: 24),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: controller.exploreRecipeList.length,
                    itemBuilder: (_, index) {
                      Recipe recipe = controller.exploreRecipeList[index];
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
                          elevation: 4,
                          child: Padding(
                              padding: EdgeInsets.only(bottom: 15, top: 10),
                              child: Row(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Card(
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: FlutterLogo(
                                          size: 100,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 100,
                                        width: 150,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  recipe.name,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
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
                                      ),
                                      SizedBox(
                                        height: 120,
                                        child: Row(
                                          children: [
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
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ))
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )),
                        ),
                      );
                    },
                  )
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
