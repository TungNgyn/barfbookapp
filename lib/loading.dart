import 'dart:async';

import 'package:Barfbook/Screens/Barfbook/barfbook_controller.dart';
import 'package:Barfbook/Screens/Mehr/profile_controller.dart';
import 'package:Barfbook/Screens/calculator/pet_controller.dart';
import 'package:Barfbook/controller.dart';
import 'package:Barfbook/home.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    final avatar =
        await supabase.storage.from('profile').download('${user?.id}');
    final userdata = await supabase
        .from('profile')
        .select("*")
        .match({'id': user?.id}).single();
    controller.userProfile = {
      'user': Profile(
          id: user!.id,
          createdAt: userdata['created_at'].substring(0, 10),
          email: userdata['email'],
          name: userdata['name'],
          description: userdata['description'],
          avatar: avatar)
    };
  } catch (error) {
    final avatar =
        await supabase.storage.from('profile').download('defaultAvatar');
    final userdata = await supabase
        .from('profile')
        .select("*")
        .match({'id': user?.id}).single();
    controller.userProfile = {
      'user': Profile(
          id: user!.id,
          createdAt: userdata['created_at'].substring(0, 10),
          email: userdata['email'],
          name: userdata['name'],
          description: userdata['description'],
          avatar: avatar)
    };
  }

  // init explore recipe and likes and profile list
  try {
    controller.databaseRecipeList = await supabase
        .from('recipe')
        .select('id, created_at, modified_at, name, description, user_id');
  } catch (error) {
    print(error);
  } finally {
    controller.exploreRecipeList.clear();
    controller.exploreProfileList.clear();
    for (var recipe in controller.databaseRecipeList) {
      List userName = await supabase
          .from('profile')
          .select('name')
          .eq('id', recipe['user_id']);

      final avatar = await supabase.storage
          .from('profile')
          .download('${recipe['user_id']}');
      List userdata = await supabase
          .from('profile')
          .select("*")
          .match({'id': recipe['user_id']});
      controller.exploreProfileList.add(Profile(
          id: userdata[0]['id'],
          createdAt: userdata[0]['created_at'].substring(0, 10),
          email: userdata[0]['email'],
          name: userdata[0]['name'],
          description: userdata[0]['description'],
          avatar: avatar));
      print(userdata[0]['name']);
      print(controller.exploreProfileList);

      final paws = await supabase
          .from('profile_liked_recipe')
          .select('*', FetchOptions(count: CountOption.exact))
          .eq('recipe', recipe['id']);
      for (var profile in controller.exploreProfileList) {
        if (profile.id == recipe['user_id']) {
          controller.exploreRecipeList.add(Recipe(
              name: (recipe as Map)['name'],
              id: recipe['id'],
              created_at: recipe['created_at'].substring(0, 10),
              paws: paws.count,
              description: recipe['description'],
              modified_at: recipe['modified_at'].substring(0, 10),
              user_id: recipe['user_id'],
              user: profile,
              userAvatar: avatar));
        }
      }
    }
  }

  // init user-created recipe
  try {
    controller.userRecipeListDB = await supabase
        .from('recipe')
        .select('id, created_at, modified_at, name, description')
        .eq('user_id', user!.id);
    controller.userRecipeList.clear();
    for (var recipe in controller.userRecipeListDB) {
      controller.userRecipeList.add(Recipe(
          name: (recipe as Map)['name'],
          id: recipe['id'],
          created_at: recipe['created_at'],
          paws: 0,
          description: recipe['description'],
          modified_at: recipe['modified_at'],
          user_id: user!.id));
    }
  } catch (error) {
    print(error);
  }

  // init favorites
  try {
    controller.userLikedRecipe.clear();
    controller.userLikedRecipeXrefDB = await supabase
        .from('profile_liked_recipe')
        .select('profile, recipe')
        .eq('profile', user!.id);

    for (var map in controller.userLikedRecipeXrefDB) {
      if (map?.containsKey("recipe") ?? false) {
        var tempRecipe =
            await supabase.from('recipe').select('*').eq('id', map['recipe']);

        for (var recipe in tempRecipe) {
          controller.userLikedRecipe.add(Recipe(
              name: (recipe as Map)['name'],
              id: recipe['id'],
              created_at: recipe['created_at'],
              paws: 0,
              description: recipe['description'],
              modified_at: recipe['modified_at'],
              user_id: recipe['user_id']));
        }
      }
    }
  } catch (error) {
    print(error);
  }

  //init pet list

  try {
    controller.userPetListDB =
        await supabase.from('pet').select('*').eq('owner', user?.id);

    controller.userPetList.clear();
    for (var pet in controller.userPetListDB) {
      controller.userPetList.add(Pet(
          id: (pet as Map)['id'],
          owner: pet['owner'],
          name: pet['name'],
          breed: pet['breed'],
          age: pet['age'],
          weight: pet['weight'],
          gender: pet['gender'],
          ration: pet['ration']));
    }
  } catch (error) {
    print(error);
  }
}

loadExplorePage() async {
  final Controller controller = Get.find();
  try {
    controller.databaseRecipeList = await supabase
        .from('recipe')
        .select('id, created_at, modified_at, name, description, user_id');
  } catch (error) {
    print(error);
  } finally {
    controller.exploreRecipeList.clear();
    controller.exploreProfileList.clear();
    for (var recipe in controller.databaseRecipeList) {
      List userName = await supabase
          .from('profile')
          .select('name')
          .eq('id', recipe['user_id']);

      final avatar = await supabase.storage
          .from('profile')
          .download('${recipe['user_id']}');
      List userdata = await supabase
          .from('profile')
          .select("*")
          .match({'id': recipe['user_id']});
      controller.exploreProfileList.add(Profile(
          id: userdata[0]['id'],
          createdAt: userdata[0]['created_at'].substring(0, 10),
          email: userdata[0]['email'],
          name: userdata[0]['name'],
          description: userdata[0]['description'],
          avatar: avatar));
      print(userdata[0]['name']);
      print(controller.exploreProfileList);

      final paws = await supabase
          .from('profile_liked_recipe')
          .select('*', FetchOptions(count: CountOption.exact))
          .eq('recipe', recipe['id']);
      for (var profile in controller.exploreProfileList) {
        if (profile.id == recipe['user_id']) {
          controller.exploreRecipeList.add(Recipe(
              name: (recipe as Map)['name'],
              id: recipe['id'],
              created_at: recipe['created_at'].substring(0, 10),
              paws: paws.count,
              description: recipe['description'],
              modified_at: recipe['modified_at'].substring(0, 10),
              user_id: recipe['user_id'],
              user: profile,
              userAvatar: avatar));
        }
      }
    }
  }
}

initFavorite() async {
  final Controller controller = Get.find();
  try {
    controller.userLikedRecipe.clear();
    controller.userLikedRecipeXrefDB = await supabase
        .from('profile_liked_recipe')
        .select('profile, recipe')
        .eq('profile', user!.id);

    for (var map in controller.userLikedRecipeXrefDB) {
      if (map?.containsKey("recipe") ?? false) {
        var tempRecipe = await supabase
            .from('recipe')
            .select('id, created_at, modified_at, name, description')
            .eq('id', map['recipe']);

        for (var recipe in tempRecipe) {
          controller.userLikedRecipe.add(Recipe(
              name: (recipe as Map)['name'],
              id: recipe['id'],
              created_at: recipe['created_at'],
              paws: 0,
              description: recipe['description'],
              modified_at: recipe['modified_at'],
              user_id: user!.id));
        }
      }
    }
  } catch (error) {
    print(error);
  }
}
