import 'package:Barfbook/Screens/Barfbook/barfbook_controller.dart';
import 'package:Barfbook/Screens/Mehr/profile_controller.dart';
import 'package:Barfbook/Screens/Barfbook/pet_controller.dart';
import 'package:Barfbook/Screens/schedule/schedule_controller.dart';
import 'package:Barfbook/controller.dart';
import 'package:Barfbook/home.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
    // final avatar =
    //     await supabase.storage.from('profile').download('${user?.id}');
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
          avatar: CachedNetworkImage(
            imageUrl:
                'https://wokqzyqvqztmyzhhuqqh.supabase.co/storage/v1/object/public/profile/${user!.id}',
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
          ))
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
    controller.databaseRecipeList = await supabase.from('recipe').select('*');
  } catch (error) {
    print(error);
  } finally {
    controller.exploreRecipeList.clear();
    controller.exploreProfileList.clear();
    for (var recipe in controller.databaseRecipeList) {
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
                border:
                    Border.all(color: Theme.of(context).colorScheme.primary),
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

      // final userAvatar = await supabase.storage
      //     .from('profile')
      //     .download('${recipe['user_id']}');
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
      controller.exploreProfileList.add(Profile(
          id: userdata[0]['id'],
          createdAt: userdata[0]['created_at'].substring(0, 10),
          email: userdata[0]['email'],
          name: userdata[0]['name'],
          description: userdata[0]['description'],
          avatar: userAvatar));

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
              userAvatar: userAvatar,
              avatar: recipeAvatar));
        }
      }
    }
    print(controller.exploreRecipeList.length);
  }

  // init user-created recipe
  try {
    controller.userRecipeListDB = await supabase
        .from('recipe')
        .select('id, created_at, modified_at, name, description')
        .eq('user_id', user!.id);
    controller.userRecipeList.clear();
    for (var recipe in controller.userRecipeListDB) {
      var recipeAvatar;
      // try {
      //   recipeAvatar =
      //       await supabase.storage.from('recipe').download('${recipe['id']}');
      // } catch (error) {
      //   recipeAvatar = await supabase.storage
      //       .from('recipe')
      //       .download('defaultRecipeAvatar');
      // }
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
                border:
                    Border.all(color: Theme.of(context).colorScheme.primary),
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
                border:
                    Border.all(color: Theme.of(context).colorScheme.primary),
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

      final paws = await supabase
          .from('profile_liked_recipe')
          .select('*', FetchOptions(count: CountOption.exact))
          .eq('recipe', recipe['id']);

      final userdata = await supabase
          .from('profile')
          .select("*")
          .match({'id': user?.id}).single();
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

      controller.userRecipeList.add(Recipe(
          name: (recipe as Map)['name'],
          id: recipe['id'],
          created_at: recipe['created_at'],
          paws: paws.count,
          description: recipe['description'],
          modified_at: recipe['modified_at'],
          user_id: user!.id,
          userAvatar: userAvatar,
          user: Profile(
              id: user!.id,
              createdAt: userdata['created_at'].substring(0, 10),
              email: userdata['email'],
              name: userdata['name'],
              description: userdata['description'],
              avatar: userAvatar),
          avatar: recipeAvatar));
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
                    border: Border.all(
                        color: Theme.of(context).colorScheme.primary),
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
                    border: Border.all(
                        color: Theme.of(context).colorScheme.primary),
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

          List userdata = await supabase
              .from('profile')
              .select("*")
              .match({'id': recipe['user_id']});

          final paws = await supabase
              .from('profile_liked_recipe')
              .select('*', FetchOptions(count: CountOption.exact))
              .eq('recipe', recipe['id']);

          controller.userLikedRecipe.add(Recipe(
              name: (recipe as Map)['name'],
              id: recipe['id'],
              created_at: recipe['created_at'],
              paws: paws.count,
              description: recipe['description'],
              modified_at: recipe['modified_at'],
              user_id: recipe['user_id'],
              avatar: recipeAvatar,
              user: Profile(
                  id: userdata[0]['id'],
                  createdAt: userdata[0]['created_at'],
                  email: userdata[0]['email'],
                  name: userdata[0]['name'],
                  description: userdata[0]['description'],
                  avatar: userAvatar),
              userAvatar: userAvatar));
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
    }
  } catch (error) {
    print(error);
  }

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
                  border:
                      Border.all(color: Theme.of(context).colorScheme.primary),
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
                  border:
                      Border.all(color: Theme.of(context).colorScheme.primary),
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
            .from('recipe')
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

        final recipe = await supabase
            .from('recipe')
            .select('*')
            .eq('id', schedule.recipe)
            .single();
        final user = await supabase
            .from('profile')
            .select('*')
            .eq('id', userTemp['id'])
            .single();
        kEventSource[schedule.date] = [
          Recipe(
              id: recipe['id'],
              name: recipe['name'],
              description: recipe['description'],
              paws: 0,
              created_at: recipe['created_at'],
              modified_at: recipe['modified_at'],
              user_id: recipe['user_id'],
              scheduleID: schedule.id,
              avatar: recipeAvatar,
              user: Profile(
                  id: user['id'],
                  createdAt: user['created_at'],
                  email: user['email'],
                  name: user['name'],
                  description: user['description'],
                  avatar: userAvatar),
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
