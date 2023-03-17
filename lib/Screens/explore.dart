import 'package:Barfbook/Screens/Barfbook/barfbook_controller.dart';
import 'package:Barfbook/controller.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class ScreenExplore extends StatefulWidget {
  @override
  State<ScreenExplore> createState() => _ScreenExploreState();
}

class _ScreenExploreState extends State<ScreenExplore> {
  final Controller controller = Get.find();
  var recipeList = [].obs;
  late int index = 0;
  @override
  void initState() {
    super.initState();
    getRecipeList();
    index = 0;
  }

  getRecipeList() async {
    controller.userRecipeList = await supabase.from('recipe').select(
        'id, created_at, modified_at, name, description, paws, user_id');
    recipeList.clear();
    for (var recipe in controller.userRecipeList) {
      recipeList.add(Recipe(
          name: (recipe as Map)['name'],
          id: recipe['id'],
          created_at: recipe['created_at'],
          paws: recipe['paws'],
          description: recipe['description'],
          modified_at: recipe['modified_at'],
          user_id: recipe['user_id']));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text("${recipeList[index].getName()}"),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: FlutterLogo(),
                  label: Text('Like'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      index = 1;
                    });
                  },
                  child: Text('Next'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
