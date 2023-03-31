import 'dart:collection';

import 'package:Barfbook/Screens/Barfbook/Barfbook.dart';
import 'package:Barfbook/Screens/Barfbook/barfbook_controller.dart';
import 'package:Barfbook/controller.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:fl_chart/fl_chart.dart';
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

  double meatSum = 0;
  double vegSum = 0;
  double weightSum = 0;
  List ingredientList = [];
  List recipeIngredient = [].obs;
  late Recipe recipe;
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _ingredientController.dispose();
    _recipeNameController.dispose();
    _recipeDescriptionController.dispose();
    super.dispose();
  }

  Future<dynamic> _updateRecipe() async {
    await supabase.rpc('update_recipe', params: {
      'recipename': _recipeNameController.text,
      'recipedescription': _recipeDescriptionController.text,
      'recipeid': widget.recipeId
    });
    await supabase
        .from('recipe_ingredient')
        .delete()
        .eq('recipe', widget.recipeId);
    for (Ingredient ingredient in recipeIngredient) {
      await supabase.rpc('insert_ingredients',
          params: {'recipeid': widget.recipeId, 'ingredientid': ingredient.id});
    }
  }

  _loadIngredient() async {
    recipeData = await supabase
        .from('recipe')
        .select(
            '''id, name, created_at, modified_at, description, paws, recipe_ingredient(ingredient)''')
        .eq('id', widget.recipeId)
        .single();

    recipe = Recipe(
        id: recipeData['id'],
        name: recipeData['name'],
        description: recipeData['description'],
        paws: recipeData['paws'],
        created_at: recipeData['created_at'],
        modified_at: recipeData['modified_at'],
        user_id: user!.id,
        user: "");
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
        category: ingredientData['category'],
        calories: ingredient['calories'],
        protein: ingredient['protein'],
        fat: ingredient['fat'],
        carbohydrates: ingredient['carbohydrates'],
        minerals: ingredient['minerals'],
        moisture: ingredient['moisture'],
      ));
    }
    _recipeNameController.text = recipeData['name'];
    _recipeDescriptionController.text = recipeData['description'];
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
                            await _updateRecipe();
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
                              labelText: "${recipe.name}"),
                        ),
                        // Text(recipeData['created_at']),
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
                                calories: suggestion['calories'],
                                protein: suggestion['protein'],
                                fat: suggestion['fat'],
                                carbohydrates: suggestion['carbohydrates'],
                                minerals: suggestion['minerals'],
                                moisture: suggestion['moisture'],
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
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Zutaten"),
                            TextButton(
                                onPressed: () {
                                  recipeIngredient.clear();
                                },
                                child: Text("Alles entfernen")),
                          ],
                        ),
                        SizedBox(height: 15),
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
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.4,
                              child: Card(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      _indicator(Colors.red, "Fleisch"),
                                      _indicator(Colors.green, "Vegetarisch")
                                    ],
                                  ),
                                  Container(
                                    height: 300,
                                    child: PieChart(PieChartData(
                                        sectionsSpace: 0,
                                        centerSpaceRadius: 40,
                                        sections: showSection())),
                                  ),
                                ],
                              ))),
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

  showSection() {
    return List.generate(2, (index) {
      switch (index) {
        case 0:
          return PieChartSectionData(
              color: Colors.red,
              value: meatSum / weightSum * 100,
              title: '${meatSum / weightSum * 100}%');
        case 1:
          return PieChartSectionData(
              color: Colors.green,
              value: vegSum / weightSum * 100,
              title: '${vegSum / weightSum * 100}%');
        default:
          throw Error();
      }
    });
  }
}

@override
Widget _indicator(Color color, String text) {
  return Row(
    children: [
      Container(
        height: 16,
        width: 16,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.white38,
            )
          ],
          shape: BoxShape.circle,
          color: color,
        ),
      ),
      SizedBox(width: 5),
      Text(text)
    ],
  );
}
