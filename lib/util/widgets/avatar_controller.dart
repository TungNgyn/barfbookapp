import 'package:Barfbook/main.dart';
import 'package:Barfbook/util/database/database.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

getUserAvatar(String id) {
  return CachedNetworkImage(
    imageUrl:
        'https://wokqzyqvqztmyzhhuqqh.supabase.co/storage/v1/object/public/profile/$id',
    progressIndicatorBuilder: (context, url, downloadProgress) =>
        CircularProgressIndicator(value: downloadProgress.progress),
    errorWidget: (context, url, error) =>
        Image.asset('assets/images/defaultAvatar.png'),
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
}

Future<Profile> getRecipeUserProfile(String id) async {
  final a = await (database.select(database.profiles)
        ..where((tbl) => tbl.id.equals(id)))
      .getSingle();
  return a;
}

getRecipeAvatar(int id) {
  return CachedNetworkImage(
    imageUrl:
        'https://wokqzyqvqztmyzhhuqqh.supabase.co/storage/v1/object/public/recipe/$id',
    progressIndicatorBuilder: (context, url, downloadProgress) =>
        CircularProgressIndicator(value: downloadProgress.progress),
    errorWidget: (context, url, error) =>
        Image.asset('assets/images/defaultRecipeAvatar.png'),
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

getDogAvatar(int id) {
  return CachedNetworkImage(
    imageUrl:
        'https://wokqzyqvqztmyzhhuqqh.supabase.co/storage/v1/object/public/pet/$id',
    progressIndicatorBuilder: (context, url, downloadProgress) =>
        CircularProgressIndicator(value: downloadProgress.progress),
    errorWidget: (context, url, error) =>
        Image.asset('assets/images/defaultDogAvatar.png'),
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
}
