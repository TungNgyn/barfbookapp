import 'package:Barfbook/Screens/Barfbook/barfbook_controller.dart';
import 'package:Barfbook/Screens/Mehr/profile.dart';
import 'package:Barfbook/Screens/explore/explore.dart';
import 'package:Barfbook/Screens/explore/recipeDetailPage.dart';
import 'package:Barfbook/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenPopularRecipe extends StatelessWidget {
  final Controller controller = Get.find();
  @override
  Widget build(BuildContext context) {
    controller.exploreRecipeList.sort(((a, b) => b.paws.compareTo(a.paws)));
    return Scaffold(
        appBar: AppBar(
          title: Text("Beliebte Rezepte"),
        ),
        body: ListView(
          children: [
            Column(
              children: [
                Wrap(
                  children: [
                    for (Recipe recipe in controller.exploreRecipeList)
                      // RecipeCard(controller: controller, recipe: recipe)
                      Card()
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
