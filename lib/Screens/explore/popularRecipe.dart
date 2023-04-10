import 'package:Barfbook/Screens/Barfbook/barfbook_controller.dart';
import 'package:Barfbook/Screens/Mehr/profile.dart';
import 'package:Barfbook/Screens/explore/recipeDetailPage.dart';
import 'package:Barfbook/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenPopularRecipe extends StatelessWidget {
  final Controller controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Beliebte Rezepte"),
      ),
      body: ListView.builder(
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
                        padding: EdgeInsets.symmetric(horizontal: 10),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      recipe.name,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                TextButton.icon(
                                    onPressed: () {
                                      Get.to(() => ScreenProfile(
                                          profile: controller
                                              .exploreProfileList[index]));
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
                                          fontWeight: FontWeight.bold),
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
      ),
    );
  }
}
