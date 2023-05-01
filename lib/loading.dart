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
      initSchedule()
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

  // Fetch user data from Supabase and update the `userProfile` property in the `Controller` class.
  final userdata = await supabase
      .from('profile')
      .select("*")
      .match({'id': user?.id}).single();

  try {
    List<String> dateParts = userdata['created_at'].split('-');
    int year = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int day = int.parse(dateParts[2].substring(0, 2));

    await database.into(database.profiles).insertOnConflictUpdate(Profile(
        id: user!.id,
        createdAt: DateTime(year, month, day),
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

    controller.explorePopularRecipeList.clear();

    for (final recipe in databasePopularRecipeList) {
      List<String> dateParts = recipe['created_at'].split('-');
      int year = int.parse(dateParts[0]);
      int month = int.parse(dateParts[1]);
      int day = int.parse(dateParts[2].substring(0, 2));
      DateTime created = DateTime(year, month, day);

      dateParts = recipe['modified_at'].split('-');
      year = int.parse(dateParts[0]);
      month = int.parse(dateParts[1]);
      day = int.parse(dateParts[2].substring(0, 2));
      DateTime modified = DateTime(year, month, day);

      controller.explorePopularRecipeList.add(Recipe(
          name: recipe['name'],
          id: recipe['id'],
          createdAt: created,
          paws: recipe['paws'],
          description: recipe['description'],
          modifiedAt: modified,
          userId: recipe['user_id']));
    }
  } catch (error) {
    print(error);
  }
}

initExplorerNewRecipe() async {
  // Find the instance of the `Controller` class created by `Get.put()` in the widget tree.
  final Controller controller = Get.find();

  // init explore new recipe
  try {
    final databaseNewRecipeList = await supabase
        .from('select_recipe')
        .select('*')
        .order('created_at')
        .limit(5);
    controller.exploreNewRecipeList.clear();

    for (final recipe in databaseNewRecipeList) {
      List<String> dateParts = recipe['created_at'].split('-');
      int year = int.parse(dateParts[0]);
      int month = int.parse(dateParts[1]);
      int day = int.parse(dateParts[2].substring(0, 2));
      DateTime created = DateTime(year, month, day);

      dateParts = recipe['modified_at'].split('-');
      year = int.parse(dateParts[0]);
      month = int.parse(dateParts[1]);
      day = int.parse(dateParts[2].substring(0, 2));
      DateTime modified = DateTime(year, month, day);

      controller.exploreNewRecipeList.add(Recipe(
          name: recipe['name'],
          id: recipe['id'],
          createdAt: created,
          paws: recipe['paws'],
          description: recipe['description'],
          modifiedAt: modified,
          userId: recipe['user_id']));
    }
  } catch (error) {
    print(error);
  }
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
      List<String> dateParts = recipe['created_at'].split('-');
      int year = int.parse(dateParts[0]);
      int month = int.parse(dateParts[1]);
      int day = int.parse(dateParts[2].substring(0, 2));
      DateTime created = DateTime(year, month, day);

      dateParts = recipe['modified_at'].split('-');
      year = int.parse(dateParts[0]);
      month = int.parse(dateParts[1]);
      day = int.parse(dateParts[2].substring(0, 2));
      DateTime modified = DateTime(year, month, day);

      controller.userRecipeList.add(Recipe(
          name: recipe['name'],
          id: recipe['id'],
          createdAt: created,
          paws: recipe['paws'],
          description: recipe['description'],
          modifiedAt: modified,
          userId: recipe['user_id']));
    }
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
      List<String> dateParts = recipe['created_at'].split('-');
      int year = int.parse(dateParts[0]);
      int month = int.parse(dateParts[1]);
      int day = int.parse(dateParts[2].substring(0, 2));
      DateTime created = DateTime(year, month, day);

      dateParts = recipe['modified_at'].split('-');
      year = int.parse(dateParts[0]);
      month = int.parse(dateParts[1]);
      day = int.parse(dateParts[2].substring(0, 2));
      DateTime modified = DateTime(year, month, day);

      controller.userLikedRecipe.add(Recipe(
          name: recipe['name'],
          id: recipe['id'],
          createdAt: created,
          paws: recipe['paws'],
          description: recipe['description'],
          modifiedAt: modified,
          userId: recipe['user_id']));
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
      controller.userPetList.add(Pet(
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
      List<String> dateParts = schedule['date'].split('-');
      int year = int.parse(dateParts[0]);
      int month = int.parse(dateParts[1]);
      int day = int.parse(dateParts[2].substring(0, 2));

      controller.scheduleRecipeList.add(Schedule(
          id: schedule['id'],
          date: DateTime(year, month, day),
          recipe: schedule['recipe'],
          userId: schedule['user_id']));
    }
    kEventSource.clear();
    try {
      for (final schedule in controller.scheduleRecipeList) {
        var userTemp = await supabase
            .from('select_recipe')
            .select('user_id')
            .eq('id', schedule['recipe'])
            .single();
        userTemp = await supabase
            .from('profile')
            .select('*')
            .eq('id', userTemp['user_id'])
            .single();

        final recipe = await supabase
            .from('select_recipe')
            .select('*')
            .eq('id', schedule['recipe'])
            .single();
        final user = await supabase
            .from('profile')
            .select('*')
            .eq('id', userTemp['id'])
            .single();

        List<String> dateParts = recipe['created_at'].split('-');
        int year = int.parse(dateParts[0]);
        int month = int.parse(dateParts[1]);
        int day = int.parse(dateParts[2].substring(0, 2));
        DateTime created = DateTime(year, month, day);

        dateParts = recipe['modified_at'].split('-');
        year = int.parse(dateParts[0]);
        month = int.parse(dateParts[1]);
        day = int.parse(dateParts[2].substring(0, 2));
        DateTime modified = DateTime(year, month, day);

        kEventSource[schedule['date']] = [
          Recipe(
              id: recipe['id'],
              name: recipe['name'],
              description: recipe['description'],
              paws: recipe['paws'],
              createdAt: created,
              modifiedAt: modified,
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
