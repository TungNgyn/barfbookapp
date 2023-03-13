import 'dart:collection';

import 'package:Barfbook/Screens/Barfbook/Barfbook.dart';
import 'package:Barfbook/Screens/Barfbook/barfbook_controller.dart';
import 'package:Barfbook/controller.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class ScreenEditRecipe extends StatefulWidget {
  final int recipeId;
  const ScreenEditRecipe({super.key, required this.recipeId});

  @override
  State<ScreenEditRecipe> createState() => _editRecipeState();
}

class _editRecipeState extends State<ScreenEditRecipe> {
  final TextEditingController _ingredientController = TextEditingController();
  final TextEditingController _recipeNameController = TextEditingController();
  final TextEditingController _recipeDescriptionController =
      TextEditingController();
  late final recipeData;
  List ingredientList = [];
  List recipeIngredient = [].obs;
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _ingredientController.dispose();
    _recipeNameController.dispose();
    _recipeDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _loadIngredient(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.done
              ? Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    title: Text("Rezept bearbeiten"),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: IconButton(
                          icon: Icon(Icons.create),
                          onPressed: () async {
                            await _createRecipe();
                            Get.back();
                          },
                        ),
                      )
                    ],
                  ),
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(children: [
                        TextField(
                          controller: _recipeNameController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Rezeptname"),
                        ),
                        Text(recipeData['created_at']),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.4,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                                child: Card(
                                    child: FlutterLogo(
                              size: 350,
                            )))),
                        TypeAheadField(
                            textFieldConfiguration: TextFieldConfiguration(
                                controller: _ingredientController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Suche nach Zutaten")),
                            suggestionsCallback: (pattern) async {
                              return await supabase
                                  .from('ingredient')
                                  .select('id, name, type, category')
                                  .ilike('name', '%${pattern}%');
                            },
                            itemBuilder: (context, suggestion) {
                              return ListTile(
                                title: Text(
                                  (suggestion as Map)['name'],
                                  style: TextStyle(fontSize: 24),
                                ),
                                subtitle: Row(
                                  children: [
                                    Text(suggestion['category']),
                                    Spacer(),
                                    Text(suggestion['type'])
                                  ],
                                ),
                              );
                            },
                            onSuggestionSelected: (suggestion) {
                              recipeIngredient.add(Ingredient(
                                name: (suggestion as Map)['name'],
                                id: suggestion['id'],
                                type: suggestion['type'],
                                category: suggestion['category'],
                              ));
                              _ingredientController.text = "";
                            },
                            noItemsFoundBuilder: (BuildContext context) {
                              return Padding(
                                padding: const EdgeInsets.all(20),
                                child: Text(
                                  'Keine Zutat gefunden!',
                                  style: TextStyle(fontSize: 18),
                                ),
                              );
                            }),
                        ExpansionTile(
                          initiallyExpanded: true,
                          title: Text("Zutaten"),
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  recipeIngredient.clear();
                                },
                                child: Text("Entfernen")),
                            Obx(() {
                              List<Widget> list = [];
                              for (var ingredient in recipeIngredient) {
                                list.add(SizedBox(
                                  height: 40,
                                  child: ElevatedButton.icon(
                                      style: ButtonStyle(),
                                      onPressed: () {
                                        recipeIngredient.remove(ingredient);
                                      },
                                      icon: Image.asset(
                                          "assets/images/recipe/icons/beef.png"),
                                      label: Text(ingredient.name)),
                                ));
                              }
                              return Wrap(
                                  alignment: WrapAlignment.spaceEvenly,
                                  direction: Axis.horizontal,
                                  spacing: 5,
                                  runSpacing: 5,
                                  children: list);
                            }),
                          ],
                        ),
                        TextField(
                            controller: _recipeDescriptionController,
                            maxLines: 20,
                            decoration: InputDecoration(
                                hintText: "Beschreibe dein Rezept!")),
                      ]),
                    ),
                  ))
              : Scaffold(body: Center(child: CircularProgressIndicator()));
        });
  }

  Future<dynamic> _createRecipe() async {
    var recipeId = await supabase.rpc('insert_recipe', params: {
      'recipename': _recipeNameController.text,
      'recipedescription': _recipeDescriptionController.text,
      'userid': user?.id
    });
    print(recipeId);
    for (Ingredient ingredient in recipeIngredient) {
      await supabase.rpc('insert_ingredients',
          params: {'recipeid': recipeId, 'ingredientid': ingredient.id});
    }
  }

  Future<dynamic> _loadIngredient() async {
    recipeData = await supabase
        .from('recipe')
        .select(
            '''id, name, created_at, modified_at, description, recipe_ingredient(ingredient)''')
        .eq('id', widget.recipeId)
        .single();
    Recipe recipe = Recipe(
        id: recipeData['id'],
        name: recipeData['name'],
        description: recipeData['description'],
        paws: recipeData['paws'],
        created_at: recipeData['created_at'],
        modified_at: recipeData['modified_at'],
        user_id: user!.id);
    ingredientList = recipeData['recipe_ingredient'];
    for (var ingredient in ingredientList) {
      final ingredientData = await supabase
          .from('ingredient')
          .select('name, type, category')
          .eq('id', ingredient['ingredient'])
          .single();
      recipeIngredient.add(Ingredient(
          id: ingredient['ingredient'],
          name: (ingredientData as Map)['name'],
          type: ingredientData['type'],
          category: ingredientData['category']));
    }
    _recipeNameController.text = recipeData['name'];
    _recipeDescriptionController.text = recipeData['description'];
  }
}
