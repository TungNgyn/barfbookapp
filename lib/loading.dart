import 'package:Barfbook/Screens/Barfbook/barfbook_controller.dart';
import 'package:Barfbook/Screens/Mehr/profile_controller.dart';
import 'package:Barfbook/Screens/Barfbook/pet_controller.dart';
import 'package:Barfbook/Screens/schedule/schedule_controller.dart';
import 'package:Barfbook/controller.dart';
import 'package:Barfbook/home.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:Barfbook/util/database/database.dart' as db;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ScreenLoading extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

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
  final Controller controller = Get.find();

  // Fetch user data from Supabase and update the `userProfile` property in the `Controller` class.
  final userdata = await supabase
      .from('profile')
      .select("*")
      .match({'id': user?.id}).single();

  var userAvatar;
  try {
    userAvatar = CachedNetworkImage(
      imageUrl:
          'https://wokqzyqvqztmyzhhuqqh.supabase.co/storage/v1/object/public/profile/${user!.id}',
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) => CachedNetworkImage(
        imageUrl:
            'https://wokqzyqvqztmyzhhuqqh.supabase.co/storage/v1/object/public/profile/defaultAvatar',
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CircularProgressIndicator(value: downloadProgress.progress),
        errorWidget: (context, url, error) => Icon(Icons.error),
        imageBuilder: (context, imageProvider) {
          return Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Theme.of(context).colorScheme.primary),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Theme.of(context).colorScheme.primary),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  } catch (error) {
    print(error);
  }
  controller.userProfile = {
    'user': Profile(
        id: user!.id,
        email: userdata['email'],
        name: userdata['name'],
        description: userdata['description'],
        avatar: userAvatar,
        rank: userdata['rank'])
  };
}

initExplorerPopularRecipe() async {
  // Find the instance of the `Controller` class created by `Get.put()` in the widget tree.
  final Controller controller = Get.find();
  // init explore popular recipe
  try {
    // Fetch popular recipes from the database
    controller.databasePopularRecipeList =
        await supabase.from('select_recipe').select('*').order('paws');
  } catch (error) {
    print(error);
  } finally {
    // Clear the existing popular recipe list
    controller.explorePopularRecipeList.clear();

    // Iterate through the popular recipe list and create Recipe objects
    for (var recipe in controller.databasePopularRecipeList) {
      // Try to load the recipe avatar using the recipe ID
      var recipeAvatar;
      try {
        recipeAvatar = CachedNetworkImage(
          imageUrl:
              'https://wokqzyqvqztmyzhhuqqh.supabase.co/storage/v1/object/public/recipe/${recipe['id']}',
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => Icon(Icons.error),
          imageBuilder: (context, imageProvider) {
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      } catch (error) {
        // If the recipe avatar can't be loaded, use the default avatar instead
        recipeAvatar = CachedNetworkImage(
          imageUrl:
              'https://wokqzyqvqztmyzhhuqqh.supabase.co/storage/v1/object/public/recipe/defaultRecipeAvatar',
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => Icon(Icons.error),
          imageBuilder: (context, imageProvider) {
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }

      // Try to load the user avatar using the user ID
      var userAvatar;
      try {
        userAvatar = CachedNetworkImage(
          imageUrl:
              'https://wokqzyqvqztmyzhhuqqh.supabase.co/storage/v1/object/public/profile/${recipe['user_id']}',
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => Icon(Icons.error),
          imageBuilder: (context, imageProvider) {
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border:
                    Border.all(color: Theme.of(context).colorScheme.primary),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      } catch (error) {
        // If the user avatar can't be loaded, use the default avatar instead
        userAvatar = CachedNetworkImage(
          imageUrl:
              'https://wokqzyqvqztmyzhhuqqh.supabase.co/storage/v1/object/public/profile/defaultAvatar.png',
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => Icon(Icons.error),
          imageBuilder: (context, imageProvider) {
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border:
                    Border.all(color: Theme.of(context).colorScheme.primary),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }

      List userdata = await supabase
          .from('profile')
          .select("*")
          .match({'id': recipe['user_id']});

      List<String> dateParts = recipe['created_at'].split('-');
      int year = int.parse(dateParts[0]);
      int month = int.parse(dateParts[1]);
      int day = int.parse(dateParts[2].substring(0, 2));

      List<String> datePartsMod = recipe['created_at'].split('-');
      int yearMod = int.parse(datePartsMod[0]);
      int monthMod = int.parse(datePartsMod[1]);
      int dayMod = int.parse(datePartsMod[2].substring(0, 2));

      controller.explorePopularRecipeList.add(Recipe(
          name: (recipe as Map)['name'],
          id: recipe['id'],
          created_at: DateTime(year, month, day),
          paws: recipe['paws'],
          description: recipe['description'],
          modified_at: DateTime(yearMod, monthMod, dayMod),
          user_id: recipe['user_id'],
          user: Profile(
              id: userdata[0]['id'],
              email: userdata[0]['email'],
              name: userdata[0]['name'],
              description: userdata[0]['description'],
              avatar: userAvatar,
              rank: userdata[0]['rank']),
          userAvatar: userAvatar,
          avatar: recipeAvatar));
    }
  }
}

initExplorerNewRecipe() async {
  // Find the instance of the `Controller` class created by `Get.put()` in the widget tree.
  final Controller controller = Get.find();

  // init explore new recipe
  try {
    controller.databaseNewRecipeList =
        await supabase.from('select_recipe').select('*').order('created_at');
  } catch (error) {
    print(error);
  } finally {
    controller.exploreNewRecipeList.clear();

    for (var recipe in controller.databaseNewRecipeList) {
      var recipeAvatar;
      try {
        recipeAvatar = CachedNetworkImage(
          imageUrl:
              'https://wokqzyqvqztmyzhhuqqh.supabase.co/storage/v1/object/public/recipe/${recipe['id']}',
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => Icon(Icons.error),
          imageBuilder: (context, imageProvider) {
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      } catch (error) {
        // recipeAvatar = await supabase.storage
        //     .from('recipe')
        //     .download('defaultRecipeAvatar');
        recipeAvatar = CachedNetworkImage(
          imageUrl:
              'https://wokqzyqvqztmyzhhuqqh.supabase.co/storage/v1/object/public/recipe/defaultRecipeAvatar',
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => Icon(Icons.error),
          imageBuilder: (context, imageProvider) {
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }

      var userAvatar;
      try {
        userAvatar = CachedNetworkImage(
          imageUrl:
              'https://wokqzyqvqztmyzhhuqqh.supabase.co/storage/v1/object/public/profile/${recipe['user_id']}',
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => Icon(Icons.error),
          imageBuilder: (context, imageProvider) {
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border:
                    Border.all(color: Theme.of(context).colorScheme.primary),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      } catch (error) {
        userAvatar = CachedNetworkImage(
          imageUrl:
              'https://wokqzyqvqztmyzhhuqqh.supabase.co/storage/v1/object/public/profile/defaultAvatar.png',
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => Icon(Icons.error),
          imageBuilder: (context, imageProvider) {
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border:
                    Border.all(color: Theme.of(context).colorScheme.primary),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }

      List userdata = await supabase
          .from('profile')
          .select("*")
          .eq('id', recipe['user_id']);

      List<String> dateParts = recipe['created_at'].split('-');
      int year = int.parse(dateParts[0]);
      int month = int.parse(dateParts[1]);
      int day = int.parse(dateParts[2].substring(0, 2));

      List<String> datePartsMod = recipe['created_at'].split('-');
      int yearMod = int.parse(datePartsMod[0]);
      int monthMod = int.parse(datePartsMod[1]);
      int dayMod = int.parse(datePartsMod[2].substring(0, 2));

      controller.exploreNewRecipeList.add(Recipe(
          name: (recipe as Map)['name'],
          id: recipe['id'],
          created_at: DateTime(year, month, day),
          paws: recipe['paws'],
          description: recipe['description'],
          modified_at: DateTime(yearMod, monthMod, dayMod),
          user_id: recipe['user_id'],
          user: Profile(
              id: userdata[0]['id'],
              email: userdata[0]['email'],
              name: userdata[0]['name'],
              description: userdata[0]['description'],
              avatar: userAvatar,
              rank: userdata[0]['rank']),
          userAvatar: userAvatar,
          avatar: recipeAvatar));
    }
  }
}

initUserCreatedRecipe() async {
  // Find the instance of the `Controller` class created by `Get.put()` in the widget tree.
  final Controller controller = Get.find();

  // init user-created recipe
  try {
    controller.userRecipeListDB = await supabase
        .from('select_recipe')
        .select('*')
        .eq('user_id', user!.id)
        .order('created_at');
    controller.userRecipeList.clear();
    for (var recipe in controller.userRecipeListDB) {
      var recipeAvatar;
      try {
        recipeAvatar = CachedNetworkImage(
          imageUrl:
              'https://wokqzyqvqztmyzhhuqqh.supabase.co/storage/v1/object/public/recipe/${recipe['id']}',
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => Icon(Icons.error),
          imageBuilder: (context, imageProvider) {
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      } catch (error) {
        recipeAvatar = CachedNetworkImage(
          imageUrl:
              'https://wokqzyqvqztmyzhhuqqh.supabase.co/storage/v1/object/public/recipe/defaultRecipeAvatar',
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => Icon(Icons.error),
          imageBuilder: (context, imageProvider) {
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }

      final userdata = await supabase
          .from('profile')
          .select("*")
          .match({'id': user?.id}).single();
      final userAvatar = CachedNetworkImage(
        imageUrl:
            'https://wokqzyqvqztmyzhhuqqh.supabase.co/storage/v1/object/public/profile/${user?.id}',
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CircularProgressIndicator(value: downloadProgress.progress),
        errorWidget: (context, url, error) => Icon(Icons.error),
        imageBuilder: (context, imageProvider) {
          return Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Theme.of(context).colorScheme.primary),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      );

      List<String> dateParts = recipe['created_at'].split('-');
      int year = int.parse(dateParts[0]);
      int month = int.parse(dateParts[1]);
      int day = int.parse(dateParts[2].substring(0, 2));

      List<String> datePartsMod = recipe['created_at'].split('-');
      int yearMod = int.parse(datePartsMod[0]);
      int monthMod = int.parse(datePartsMod[1]);
      int dayMod = int.parse(datePartsMod[2].substring(0, 2));

      controller.userRecipeList.add(Recipe(
          name: (recipe as Map)['name'],
          id: recipe['id'],
          created_at: DateTime(year, month, day),
          paws: recipe['paws'],
          description: recipe['description'],
          modified_at: DateTime(yearMod, monthMod, dayMod),
          user_id: user!.id,
          userAvatar: userAvatar,
          user: Profile(
              id: user!.id,
              email: userdata['email'],
              name: userdata['name'],
              description: userdata['description'],
              avatar: userAvatar,
              rank: userdata['rank']),
          avatar: recipeAvatar));
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
    controller.userLikedRecipeXrefDB = await supabase
        .from('profile_liked_recipe')
        .select('*')
        .eq('profile', user!.id);

    for (var likedRecipe in controller.userLikedRecipeXrefDB) {
      final recipe = await supabase
          .from('select_recipe')
          .select('*')
          .eq('id', likedRecipe['recipe'])
          .single();
      var recipeAvatar;
      try {
        recipeAvatar =
            // await supabase.storage.from('recipe').download('${recipe['id']}');
            CachedNetworkImage(
          imageUrl:
              'https://wokqzyqvqztmyzhhuqqh.supabase.co/storage/v1/object/public/recipe/${recipe['id']}',
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => Icon(Icons.error),
          imageBuilder: (context, imageProvider) {
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      } catch (error) {
        recipeAvatar = CachedNetworkImage(
          imageUrl:
              'https://wokqzyqvqztmyzhhuqqh.supabase.co/storage/v1/object/public/profile/defaultAvatar',
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => Icon(Icons.error),
          imageBuilder: (context, imageProvider) {
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }
      final userAvatar = CachedNetworkImage(
        imageUrl:
            'https://wokqzyqvqztmyzhhuqqh.supabase.co/storage/v1/object/public/profile/${recipe['user_id']}',
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CircularProgressIndicator(value: downloadProgress.progress),
        errorWidget: (context, url, error) => Icon(Icons.error),
        imageBuilder: (context, imageProvider) {
          return Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Theme.of(context).colorScheme.primary),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      );

      List userdata = await supabase
          .from('profile')
          .select("*")
          .match({'id': recipe['user_id']});

      List<String> dateParts = recipe['created_at'].split('-');
      int year = int.parse(dateParts[0]);
      int month = int.parse(dateParts[1]);
      int day = int.parse(dateParts[2].substring(0, 2));

      List<String> datePartsMod = recipe['created_at'].split('-');
      int yearMod = int.parse(datePartsMod[0]);
      int monthMod = int.parse(datePartsMod[1]);
      int dayMod = int.parse(datePartsMod[2].substring(0, 2));

      controller.userLikedRecipe.add(Recipe(
          name: (recipe as Map)['name'],
          id: recipe['id'],
          created_at: DateTime(year, month, day),
          paws: recipe['paws'],
          description: recipe['description'],
          modified_at: DateTime(yearMod, monthMod, dayMod),
          user_id: recipe['user_id'],
          avatar: recipeAvatar,
          user: Profile(
              id: userdata[0]['id'],
              email: userdata[0]['email'],
              name: userdata[0]['name'],
              description: userdata[0]['description'],
              avatar: userAvatar,
              rank: userdata[0]['rank']),
          userAvatar: userAvatar));
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
    controller.userPetListDB =
        await supabase.from('pet').select('*').eq('owner', user?.id);
    controller.userPetList.clear();
    for (var pet in controller.userPetListDB) {
      var avatar;
      try {
        // final avatar =
        //     await supabase.storage.from('pet').download('${pet['id']}');
        avatar = CachedNetworkImage(
          imageUrl:
              'https://wokqzyqvqztmyzhhuqqh.supabase.co/storage/v1/object/public/pet/${pet['id']}',
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => Icon(Icons.error),
          imageBuilder: (context, imageProvider) {
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border:
                    Border.all(color: Theme.of(context).colorScheme.primary),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      } catch (error) {
        avatar =
            // await supabase.storage.from('pet').download('defaultDogAvatar');
            CachedNetworkImage(
          imageUrl:
              'https://wokqzyqvqztmyzhhuqqh.supabase.co/storage/v1/object/public/pet/defaultDogAvatar',
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => Icon(Icons.error),
          imageBuilder: (context, imageProvider) {
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border:
                    Border.all(color: Theme.of(context).colorScheme.primary),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }
      controller.userPetList.add(Pet(
          id: (pet as Map)['id'],
          owner: pet['owner'],
          name: pet['name'],
          breed: pet['breed'],
          age: pet['age'],
          weight: pet['weight'],
          gender: pet['gender'],
          ration: pet['ration'].toDouble(),
          avatar: avatar));

      try {
        var test = await db.database.addPet(db.PetsCompanion(
            id: drift.Value(
              pet['id'],
            ),
            owner: drift.Value(pet['owner']),
            name: drift.Value(pet['name']),
            breed: drift.Value(pet['breed']),
            age: drift.Value(pet['age']),
            weight: drift.Value(pet['weight']),
            gender: drift.Value(pet['gender']),
            ration: drift.Value(pet['ration'].toDouble())));
        print(test);
      } catch (error) {
        print(error);
      }
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
    controller.scheduleRecipeListDB =
        await supabase.from('schedule').select('*').eq('user_id', user?.id);
    controller.scheduleRecipeList.clear();
    for (var schedule in controller.scheduleRecipeListDB) {
      List<String> dateParts = schedule['date'].split('-');
      int year = int.parse(dateParts[0]);
      int month = int.parse(dateParts[1]);
      int day = int.parse(dateParts[2].substring(0, 2));

      controller.scheduleRecipeList.add(Schedule(schedule['id'],
          schedule['user_id'], schedule['recipe'], DateTime(year, month, day)));
    }
    kEventSource.clear();
    try {
      for (var schedule in controller.scheduleRecipeList) {
        var recipeAvatar;
        try {
          recipeAvatar = CachedNetworkImage(
            imageUrl:
                'https://wokqzyqvqztmyzhhuqqh.supabase.co/storage/v1/object/public/recipe/${schedule.recipe}',
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => Icon(Icons.error),
            imageBuilder: (context, imageProvider) {
              return Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
        } catch (error) {
          recipeAvatar = CachedNetworkImage(
            imageUrl:
                'https://wokqzyqvqztmyzhhuqqh.supabase.co/storage/v1/object/public/recipe/defaultRecipeAvatar',
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => Icon(Icons.error),
            imageBuilder: (context, imageProvider) {
              return Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
        }
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
        final userAvatar = CachedNetworkImage(
          imageUrl:
              'https://wokqzyqvqztmyzhhuqqh.supabase.co/storage/v1/object/public/profile/${userTemp['id']}',
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => Icon(Icons.error),
          imageBuilder: (context, imageProvider) {
            return Container(
              decoration: BoxDecoration(
                border:
                    Border.all(color: Theme.of(context).colorScheme.primary),
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );

        final recipe = await supabase
            .from('select_recipe')
            .select('*')
            .eq('id', schedule.recipe)
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

        List<String> datePartsMod = recipe['modified_at'].split('-');
        int yearMod = int.parse(datePartsMod[0]);
        int monthMod = int.parse(datePartsMod[1]);
        int dayMod = int.parse(datePartsMod[2].substring(0, 2));

        kEventSource[schedule.date] = [
          Recipe(
              id: recipe['id'],
              name: recipe['name'],
              description: recipe['description'],
              paws: recipe['paws'],
              created_at: DateTime(year, month, day),
              modified_at: DateTime(yearMod, monthMod, dayMod),
              user_id: recipe['user_id'],
              scheduleID: schedule.id,
              avatar: recipeAvatar,
              user: Profile(
                  id: user['id'],
                  email: user['email'],
                  name: user['name'],
                  description: user['description'],
                  avatar: userAvatar,
                  rank: user['rank']),
              userAvatar: userAvatar)
        ];
      }
    } catch (error) {
      print(error);
    }
  } catch (error) {
    print(error);
  }
}
