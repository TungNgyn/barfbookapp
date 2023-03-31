import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class Ingredient {
  const Ingredient(
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
      this.gram = 0});

  final int id;
  final String name;
  final String type;
  final String category;
  final int calories;
  final double protein;
  final double fat;
  final int carbohydrates;
  final double minerals;
  final double moisture;
  final int gram;
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
      required this.user});

  final int id;
  final String name;
  final String description;
  final int paws;
  final String created_at;
  final String modified_at;
  final String user_id;
  final String user;
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
