import 'dart:collection';

import 'package:Barfbook/Screens/Barfbook/Barfbook.dart';
import 'package:Barfbook/Screens/Barfbook/barfbook_controller.dart';
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

late Ingredient selectedIngredient;

class _newRecipeState extends State<ScreenCreateRecipe> {
  final TextEditingController _ingredientController = TextEditingController();
  final TextEditingController _recipeNameController = TextEditingController();
  final TextEditingController _recipeDescriptionController =
      TextEditingController();
  final TextEditingController _recipeGramController = TextEditingController();
  var recipeIngredient = [].obs;
  final Controller controller = Get.find();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _ingredientController.dispose();
    _recipeNameController.dispose();
    _recipeDescriptionController.dispose();
    super.dispose();
  }

  Future<dynamic> _createRecipe() async {
    var recipeId = await supabase.rpc('insert_recipe', params: {
      'recipename': _recipeNameController.text,
      'recipedescription': _recipeDescriptionController.text,
      'userid': user?.id
    });
    for (Ingredient ingredient in recipeIngredient) {
      await supabase.rpc('insert_ingredients',
          params: {'recipeid': recipeId, 'ingredientid': ingredient.id});
    }
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
                    suggestion as Map;
                    return ListTile(
                      title: Text(
                        (suggestion)['name'],
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
                    suggestion as Map;
                    Get.bottomSheet(
                      Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onPrimary,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25))),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Text(
                                "${(suggestion)['name']}",
                                style: TextStyle(fontSize: 28),
                              ),
                              SizedBox(height: 30),
                              TextField(
                                controller: _recipeGramController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Gewicht in Gramm"),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    recipeIngredient.add(Ingredient(
                                        name: (suggestion)['name'],
                                        id: suggestion['id'],
                                        type: suggestion['type'],
                                        category: suggestion['category'],
                                        gram: int.parse(
                                            _recipeGramController.text)));
                                    _ingredientController.clear();
                                    _recipeGramController.clear();
                                    Get.back();
                                  },
                                  child: Text("Hinzufügen"))
                            ],
                          ),
                        ),
                      ),
                    );
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
                              recipeIngredient.remove(ingredient);
                            },
                            icon: Image.asset(
                                "assets/images/recipe/icons/beef.png"),
                            label: Row(
                              children: [
                                Text(ingredient.name),
                                Text('${ingredient.gram} Gramm')
                              ],
                            )),
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
}
