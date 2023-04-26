import 'dart:io';

import 'package:flutter/material.dart';

class Profile {
  const Profile(
      {required this.id,
      this.createdAt,
      required this.email,
      required this.name,
      required this.description,
      required this.avatar});

  final String id;
  final DateTime? createdAt;
  final String email;
  final String name;
  final String description;
  final Widget avatar;
}
