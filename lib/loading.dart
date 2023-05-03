import 'package:Barfbook/Screens/Barfbook/barfbook_controller.dart';
import 'package:Barfbook/Screens/Mehr/profile_controller.dart';
import 'package:Barfbook/Screens/Barfbook/pet_controller.dart';
import 'package:Barfbook/Screens/schedule/schedule_controller.dart';
import 'package:Barfbook/controller.dart';
import 'package:Barfbook/home.dart';
import 'package:Barfbook/main.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:Barfbook/util/database/database.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenLoading extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

late Profile userProfile;

class _LoadingScreenState extends State<ScreenLoading> {
  Future<List<dynamic>>? _future;
  @override
  void initState() {
    super.initState();
    _future = Future.wait([
      initUser(),
      initExplorerPopularRecipe(),
      initExplorerNewRecipe(),
      initUserCreatedRecipe(),
      initFavorite(),
      initPetList(),
      initSchedule(),
      initIngredients()
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.connectionState == ConnectionState.done
              ? Home()
              : Center(child: CircularProgressIndicator());
        });
  }
}

initUser() async {
  // Find the instance of the `Controller` class created by `Get.put()` in the widget tree.
  // final Controller controller = Get.find();

  try {
    // Fetch user data from Supabase and update the `userProfile` property in the `Controller` class.
    final userdata = await supabase
        .from('profile')
        .select("*")
        .match({'id': user?.id}).single();

    await database.into(database.profiles).insertOnConflictUpdate(Profile(
        id: user!.id,
        createdAt: getDateTime(userdata['created_at']),
        email: userdata['email'],
        name: userdata['name'],
        description: userdata['description'],
        rank: userdata['rank']));

    userProfile = await (database.select(database.profiles)
          ..where((tbl) => tbl.id.equals(user!.id)))
        .getSingle();
  } catch (error) {
    print(error);
  }
}

initExplorerPopularRecipe() async {
  // Find the instance of the `Controller` class created by `Get.put()` in the widget tree.
  final Controller controller = Get.find();
  // init explore popular recipe
  try {
    // Fetch popular recipes from the database
    final databasePopularRecipeList =
        await supabase.from('select_recipe').select('*').order('paws').limit(5);

    // controller.explorePopularRecipeList.clear();
    for (final recipe in databasePopularRecipeList) {
      final userdata = await supabase
          .from('profile')
          .select("*")
          .match({'id': recipe['user_id']}).single();

      await database.into(database.profiles).insertOnConflictUpdate(Profile(
          id: recipe['user_id'],
          createdAt: getDateTime(userdata['created_at']),
          email: userdata['email'],
          name: userdata['name'],
          description: userdata['description'],
          rank: userdata['rank']));

      await database.into(database.recipes).insertOnConflictUpdate(Recipe(
          id: recipe['id'],
          createdAt: getDateTime(recipe['created_at']),
          name: recipe['name'],
          description: recipe['description'],
          userId: recipe['user_id'],
          paws: recipe['paws'],
          modifiedAt: getDateTime(recipe['modified_at'])));

      final ingredientlist = await supabase
          .from('recipe_ingredient')
          .select('*')
          .eq('recipe', recipe['id']);
      for (var ingredient in ingredientlist) {
        await database.into(database.recipeIngredients).insertOnConflictUpdate(
            RecipeIngredient(
                recipe: ingredient['recipe'],
                ingredient: ingredient['ingredient'],
                gram: ingredient['grams']));
      }
    }
    controller.explorePopularRecipeList =
        await (database.select(database.recipes)
              ..orderBy([(t) => OrderingTerm.desc(t.paws)])
              ..limit(5))
            .get();
  } catch (error) {
    print(error);
  }
}

initExplorerNewRecipe() async {
  // Find the instance of the `Controller` class created by `Get.put()` in the widget tree.
  final Controller controller = Get.find();

  // init explore new recipe
  try {
    final databasePopularRecipeList = await supabase
        .from('select_recipe')
        .select('*')
        .order('created_at')
        .limit(5);

    controller.exploreNewRecipeList.clear();

    for (final recipe in databasePopularRecipeList) {
      final userdata = await supabase
          .from('profile')
          .select("*")
          .match({'id': recipe['user_id']}).single();

      await database.into(database.profiles).insertOnConflictUpdate(Profile(
          id: recipe['user_id'],
          createdAt: getDateTime(userdata['created_at']),
          email: userdata['email'],
          name: userdata['name'],
          description: userdata['description'],
          rank: userdata['rank']));

      await database.into(database.recipes).insertOnConflictUpdate(Recipe(
          id: recipe['id'],
          createdAt: getDateTime(recipe['created_at']),
          name: recipe['name'],
          description: recipe['description'],
          userId: recipe['user_id'],
          paws: recipe['paws'],
          modifiedAt: getDateTime(recipe['modified_at'])));

      final ingredientlist = await supabase
          .from('recipe_ingredient')
          .select('*')
          .eq('recipe', recipe['id']);
      for (var ingredient in ingredientlist) {
        await database.into(database.recipeIngredients).insertOnConflictUpdate(
            RecipeIngredient(
                recipe: ingredient['recipe'],
                ingredient: ingredient['ingredient'],
                gram: ingredient['grams']));
      }
    }
    controller.exploreNewRecipeList = await (database.select(database.recipes)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(5))
        .get();
  } catch (error) {
    print(error);
  }
}

getDateTime(String s) {
  List<String> dateParts = s.split('-');
  int year = int.parse(dateParts[0]);
  int month = int.parse(dateParts[1]);
  int day = int.parse(dateParts[2].substring(0, 2));

  return DateTime(year, month, day);
}

initUserCreatedRecipe() async {
  // Find the instance of the `Controller` class created by `Get.put()` in the widget tree.
  final Controller controller = Get.find();

  // init user-created recipe
  try {
    final userRecipeListDB = await supabase
        .from('select_recipe')
        .select('*')
        .eq('user_id', user!.id)
        .order('created_at');
    controller.userRecipeList.clear();
    for (final recipe in userRecipeListDB) {
      final userdata = await supabase
          .from('profile')
          .select("*")
          .match({'id': recipe['user_id']}).single();

      await database.into(database.profiles).insertOnConflictUpdate(Profile(
          id: recipe['user_id'],
          createdAt: getDateTime(userdata['created_at']),
          email: userdata['email'],
          name: userdata['name'],
          description: userdata['description'],
          rank: userdata['rank']));

      await database.into(database.recipes).insertOnConflictUpdate(Recipe(
          name: recipe['name'],
          id: recipe['id'],
          createdAt: getDateTime(recipe['created_at']),
          paws: recipe['paws'],
          description: recipe['description'],
          modifiedAt: getDateTime(recipe['modified_at']),
          userId: recipe['user_id']));

      final ingredientlist = await supabase
          .from('recipe_ingredient')
          .select('*')
          .eq('recipe', recipe['id']);
      for (var ingredient in ingredientlist) {
        await database.into(database.recipeIngredients).insertOnConflictUpdate(
            RecipeIngredient(
                recipe: ingredient['recipe'],
                ingredient: ingredient['ingredient'],
                gram: ingredient['grams']));
      }
    }
    controller.userRecipeList = await (database.select(database.recipes)
          ..where((tbl) => tbl.userId.equals(user!.id)))
        .get();
  } catch (error) {
    print(error);
  }
}

initFavorite() async {
  // Find the instance of the `Controller` class created by `Get.put()` in the widget tree.
  final Controller controller = Get.find();

  // init favorites
  try {
    controller.userLikedRecipe.clear();
    final userLikedRecipeXrefDB = await supabase
        .from('profile_liked_recipe')
        .select('*')
        .eq('profile', user!.id);

    for (var likedRecipe in userLikedRecipeXrefDB) {
      final recipe = await supabase
          .from('select_recipe')
          .select('*')
          .eq('id', likedRecipe['recipe'])
          .single();
      final userdata = await supabase
          .from('profile')
          .select("*")
          .match({'id': recipe['user_id']}).single();

      await database.into(database.profiles).insertOnConflictUpdate(Profile(
          id: recipe['user_id'],
          createdAt: getDateTime(userdata['created_at']),
          email: userdata['email'],
          name: userdata['name'],
          description: userdata['description'],
          rank: userdata['rank']));

      await database.into(database.recipes).insertOnConflictUpdate(Recipe(
          name: recipe['name'],
          id: recipe['id'],
          createdAt: getDateTime(recipe['created_at']),
          paws: recipe['paws'],
          description: recipe['description'],
          modifiedAt: getDateTime(recipe['modified_at']),
          userId: recipe['user_id']));

      final ingredientlist = await supabase
          .from('recipe_ingredient')
          .select('*')
          .eq('recipe', recipe['id']);
      for (var ingredient in ingredientlist) {
        await database.into(database.recipeIngredients).insertOnConflictUpdate(
            RecipeIngredient(
                recipe: ingredient['recipe'],
                ingredient: ingredient['ingredient'],
                gram: ingredient['grams']));
      }

      await database.into(database.likedRecipes).insertOnConflictUpdate(
          LikedRecipe(profile: recipe['user_id'], recipe: recipe['id']));
    }
    for (LikedRecipe likedRecipe
        in await (database.select(database.likedRecipes)).get()) {
      controller.userLikedRecipe = (await (database.select(database.recipes)
            ..where((tbl) => tbl.id.equals(likedRecipe.recipe)))
          .get());
    }
  } catch (error) {
    print(error);
  }
}

initPetList() async {
  // Find the instance of the `Controller` class created by `Get.put()` in the widget tree.
  final Controller controller = Get.find();

  //init pet list
  try {
    final userPetListDB =
        await supabase.from('pet').select('*').eq('owner', user?.id);
    controller.userPetList.clear();

    for (final pet in userPetListDB) {
      await database.into(database.pets).insertOnConflictUpdate(Pet(
            id: pet['id'],
            owner: pet['owner'],
            name: pet['name'],
            breed: pet['breed'],
            age: pet['age'],
            weight: pet['weight'],
            gender: pet['gender'],
            ration: pet['ration'].toDouble(),
          ));
    }
    controller.userPetList = await (database.select(database.pets)
          ..where((tbl) => tbl.owner.equals(user!.id)))
        .get();
  } catch (error) {
    print(error);
  }
}

initSchedule() async {
  // Find the instance of the `Controller` class created by `Get.put()` in the widget tree.
  final Controller controller = Get.find();

  //init schedule
  try {
    final scheduleRecipeListDB =
        await supabase.from('schedule').select('*').eq('user_id', user?.id);
    controller.scheduleRecipeList.clear();
    for (final schedule in scheduleRecipeListDB) {
      await database.into(database.schedules).insertOnConflictUpdate(Schedule(
          id: schedule['id'],
          date: getDateTime(schedule['date']),
          recipe: schedule['recipe'],
          userId: schedule['user_id']));
    }
    controller.scheduleRecipeList = await (database.select(database.schedules)
          ..where((tbl) => tbl.userId.equals(user!.id)))
        .get();
    kEventSource.clear();
    try {
      for (final schedule in controller.scheduleRecipeList) {
        var userTemp = await supabase
            .from('select_recipe')
            .select('user_id')
            .eq('id', schedule.recipe)
            .single();
        userTemp = await supabase
            .from('profile')
            .select('*')
            .eq('id', userTemp['user_id'])
            .single();

        final recipe = await supabase
            .from('select_recipe')
            .select('*')
            .eq('id', schedule.recipe)
            .single();

        kEventSource[schedule.date] = [
          Recipe(
              id: recipe['id'],
              name: recipe['name'],
              description: recipe['description'],
              paws: recipe['paws'],
              createdAt: getDateTime(recipe['created_at']),
              modifiedAt: getDateTime(recipe['modified_at']),
              userId: recipe['user_id'])
        ];
      }
    } catch (error) {
      print(error);
    }
  } catch (error) {
    print(error);
  }
}

initIngredients() async {
  // Find the instance of the `Controller` class created by `Get.put()` in the widget tree.
  final Controller controller = Get.find();
  try {
    // Fetch user data from Supabase and update the `userProfile` property in the `Controller` class.
    final ingredientlist = await supabase.from('ingredient').select('*');
    for (var ingredient in ingredientlist) {
      await database.into(database.ingredients).insertOnConflictUpdate(
          Ingredient(
              id: ingredient['id'],
              name: ingredient['name'],
              category: ingredient['category'],
              type: ingredient['type'],
              calories: ingredient['calories'].toDouble(),
              protein: ingredient['protein'].toDouble(),
              fat: ingredient['fat'].toDouble(),
              carbohydrates: ingredient['carbohydrates'].toDouble(),
              minerals: ingredient['minerals'].toDouble(),
              moisture: ingredient['moisture'].toDouble(),
              avatar: ingredient['avatar'],
              gram: 0));
    }
    controller.ingredients = await database.select(database.ingredients).get();
  } catch (error) {
    print(error);
  }
}
