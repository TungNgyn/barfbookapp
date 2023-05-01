import 'package:Barfbook/Screens/Barfbook/barfbook_controller.dart';
import 'package:Barfbook/Screens/Mehr/profile.dart';
import 'package:Barfbook/Screens/explore/explore.dart';
import 'package:Barfbook/Screens/explore/recipeDetailPage.dart';
import 'package:Barfbook/controller.dart';
import 'package:Barfbook/util/database/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenNewRecipe extends StatelessWidget {
  final Controller controller = Get.find();
  @override
  Widget build(BuildContext context) {
    // controller.explorePopularProfileList
    //     .sort(((a, b) => b.created_at.compareTo(a.created_at)));
    return Scaffold(
      appBar: AppBar(
        title: Text("Neue Rezepte"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            for (Recipe recipe in controller.exploreNewRecipeList)
              BigRecipeCard(
                recipe: recipe,
                controller: controller,
              )
          ],
        ),
      ),
    );
  }
}
