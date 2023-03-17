import 'package:flutter/material.dart';

class Ingredient {
  const Ingredient(
      {required this.id,
      required this.name,
      required this.type,
      required this.category});

  final int id;
  final String name;
  final String type;
  final String category;
}

class Recipe {
  const Recipe(
      {required this.id,
      required this.name,
      required this.description,
      required this.paws,
      required this.created_at,
      required this.modified_at,
      required this.user_id});

  final int id;
  final String name;
  final String description;
  final int paws;
  final String created_at;
  final String modified_at;
  final String user_id;

  String getName() {
    return name;
  }

  String getDescription() {
    return description;
  }

  String getCreated_at() {
    return created_at;
  }

  String getModified_at() {
    return modified_at;
  }

  String getUser_id() {
    return user_id;
  }

  int getPaws() {
    return paws;
  }
}

var enumIcon = {
  1: Image.asset("assets/images/recipe/icons/beef.png"),
  2: Image.asset("assets/images/recipe/icons/hen.png"),
  3: Image.asset("assets/images/recipe/icons/horse.png"),
  4: Image.asset("assets/images/recipe/icons/beef.png"), // to be change
  5: Image.asset("assets/images/recipe/icons/goat.png"),
  6: Image.asset("assets/images/recipe/icons/rabbit.png"),
  7: Image.asset("assets/images/recipe/icons/lamb.png"),
  8: Image.asset("assets/images/recipe/icons/beef.png"), // to be change
  9: Image.asset("assets/images/recipe/icons/vegan.png")
};
