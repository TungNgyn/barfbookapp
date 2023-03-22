import 'dart:async';

import 'package:Barfbook/Screens/Barfbook/barfbook_controller.dart';
import 'package:Barfbook/controller.dart';
import 'package:Barfbook/home.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Map userdata = {'name': 'name', 'email': 'email', 'description': 'description'};

class ScreenLoading extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<ScreenLoading> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.connectionState == ConnectionState.done
              ? Home()
              : Center(child: CircularProgressIndicator());
        });
  }
}

initData() async {
  final Controller controller = Get.find();
  // init userdata
  try {
    userdata = await supabase
        .from('profile')
        .select("name, email, description")
        .match({'id': user?.id}).single();
  } catch (error) {
    print("ERROR = $error");
  }

  // init recipe
  try {
    controller.databaseRecipeList = await supabase.from('recipe').select(
        'id, created_at, modified_at, name, description, paws, user_id, category');
  } catch (error) {
    print(error);
  } finally {
    controller.exploreRecipeList.clear();
    for (var recipe in controller.databaseRecipeList) {
      List userName = await supabase
          .from('profile')
          .select('name')
          .eq('id', recipe['user_id']);
      controller.exploreRecipeList.add(Recipe(
          name: (recipe as Map)['name'],
          id: recipe['id'],
          created_at: recipe['created_at'].substring(0, 10),
          paws: recipe['paws'],
          description: recipe['description'],
          modified_at: recipe['modified_at'].substring(0, 10),
          category: recipe['category'],
          user_id: recipe['user_id'],
          user: userName[0]['name']));
    }
  }

  // init user-created recipe
  try {
    controller.userRecipeListDB = await supabase
        .from('recipe')
        .select(
            'id, created_at, modified_at, name, description, paws, category')
        .eq('user_id', user!.id);
    controller.userRecipeList.clear();
    for (var recipe in controller.userRecipeListDB) {
      controller.userRecipeList.add(Recipe(
          name: (recipe as Map)['name'],
          id: recipe['id'],
          created_at: recipe['created_at'],
          paws: recipe['paws'],
          description: recipe['description'],
          modified_at: recipe['modified_at'],
          category: recipe['category'],
          user_id: user!.id,
          user: ""));
    }
  } catch (error) {
    print(error);
  }

  // init favorites
  try {
    controller.userLikedRecipeXrefDB = await supabase
        .from('profile_liked_recipe')
        .select('profile, recipe')
        .eq('profile', user!.id);

    for (var map in controller.userLikedRecipeXrefDB) {
      if (map?.containsKey("recipe") ?? false) {
        var tempRecipe = await supabase
            .from('recipe')
            .select(
                'id, created_at, modified_at, name, description, paws, category')
            .eq('id', map['recipe']);

        print(controller.userLikedRecipe);
        controller.userLikedRecipe.clear();
        print(controller.userLikedRecipe);
        for (var recipe in tempRecipe) {
          controller.userLikedRecipe.add(Recipe(
              name: (recipe as Map)['name'],
              id: recipe['id'],
              created_at: recipe['created_at'],
              paws: recipe['paws'],
              description: recipe['description'],
              modified_at: recipe['modified_at'],
              category: recipe['category'],
              user_id: user!.id,
              user: ""));
        }
      }
    }
  } catch (error) {
    print(error);
  }
}
