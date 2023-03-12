import 'dart:collection';

import 'package:Barfbook/controller.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class ScreenCreateRecipe extends StatefulWidget {
  const ScreenCreateRecipe({super.key});

  @override
  State<ScreenCreateRecipe> createState() => _newRecipeState();
}

final Controller controller = Get.find();
late Ingredient selectedIngredient;

class Ingredient {
  const Ingredient(
      {required this.id,
      required this.name,
      required this.type,
      required this.category,
      required this.icon});

  final int id;
  final String name;
  final String type;
  final String category;
  final Image icon;

  @override
  String toString() {
    return name;
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

class _newRecipeState extends State<ScreenCreateRecipe> {
  final TextEditingController _ingredientController = TextEditingController();
  final TextEditingController _recipeNameController = TextEditingController();
  final TextEditingController _recipeDescriptionController =
      TextEditingController();
  var recipeIngredient = [].obs;

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
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Neues Rezept erstellen"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: Icon(Icons.add),
                onPressed: () async {
                  await _createRecipe();
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
                    border: OutlineInputBorder(), labelText: "Rezeptname"),
              ),
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
                        icon: Image.asset(
                            "assets/images/recipe/icons/beef.png")));
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
                    for (Ingredient ingredient in recipeIngredient) {
                      list.add(SizedBox(
                        height: 40,
                        child: ElevatedButton.icon(
                            style: ButtonStyle(),
                            onPressed: () {
                              setState(() {
                                recipeIngredient.remove(ingredient);
                              });
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
                  decoration:
                      InputDecoration(hintText: "Beschreibe dein Rezept!")),
            ]),
          ),
        ));
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
}
