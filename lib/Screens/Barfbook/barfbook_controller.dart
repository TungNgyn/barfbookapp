import 'package:Barfbook/Screens/Mehr/profile_controller.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class Ingredient {
  Ingredient(
      {required this.id,
      required this.name,
      required this.type,
      required this.category,
      required this.calories,
      required this.protein,
      required this.fat,
      required this.carbohydrates,
      required this.minerals,
      required this.moisture,
      required this.avatar,
      this.gram = 0});

  final int id;
  final String name;
  final String type;
  final String category;
  final double calories;
  final double protein;
  final double fat;
  final double carbohydrates;
  final double minerals;
  final double moisture;
  final avatar;
  double gram;
}

class Recipe {
  const Recipe(
      {required this.id,
      required this.name,
      required this.description,
      required this.paws,
      required this.created_at,
      required this.modified_at,
      required this.user_id,
      this.avatar,
      this.user,
      this.userAvatar,
      this.scheduleID});

  final int id;
  final String name;
  final String description;
  final int paws;
  final String created_at;
  final String modified_at;
  final String user_id;
  final Profile? user;
  final avatar;
  final userAvatar;
  final int? scheduleID;
}

class CustomFilterChip {
  String label;
  bool isSelected;

  CustomFilterChip(this.label, this.isSelected);
}

loadRecipeUser(var id) async {
  final userAvatar = CachedNetworkImage(
    imageUrl:
        'https://wokqzyqvqztmyzhhuqqh.supabase.co/storage/v1/object/public/profile/${id}',
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
  final user =
      await supabase.from('profile').select("*").match({'id': id}).single();
  return Profile(
      id: user['id'],
      createdAt: user['created_at'],
      email: user['email'],
      name: user['name'],
      description: user['description'],
      avatar: userAvatar);
}

loadUserAvatar(var id) {
  final userAvatar = CachedNetworkImage(
    imageUrl:
        'https://wokqzyqvqztmyzhhuqqh.supabase.co/storage/v1/object/public/profile/${id}',
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
  return userAvatar;
}

loadRecipeAvatar(var id) {
  final recipeAvatar =
      // await supabase.storage.from('recipe').download('${recipe['id']}');
      CachedNetworkImage(
    imageUrl:
        'https://wokqzyqvqztmyzhhuqqh.supabase.co/storage/v1/object/public/recipe/${id}',
    progressIndicatorBuilder: (context, url, downloadProgress) =>
        CircularProgressIndicator(value: downloadProgress.progress),
    errorWidget: (context, url, error) => Icon(Icons.error),
    imageBuilder: (context, imageProvider) {
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      );
    },
  );
  return recipeAvatar;
}
