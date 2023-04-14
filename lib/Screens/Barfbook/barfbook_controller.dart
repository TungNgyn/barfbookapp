import 'package:Barfbook/Screens/Mehr/profile_controller.dart';
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
      required this.path,
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
  final String path;
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
      this.userAvatar});

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
}

class CustomFilterChip {
  String label;
  bool isSelected;

  CustomFilterChip(this.label, this.isSelected);
}
