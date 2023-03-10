import 'dart:collection';

import 'package:Barfbook/controller.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
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
      {required this.name,
      required this.type,
      required this.category,
      required this.icon});

  final String name;
  final String type;
  final String category;
  final Image icon;

  @override
  String toString() {
    return name;
  }
}

const enumType = {
  1: "Rind",
  2: "Geflügel",
  3: "Pferd",
  4: "Wild",
  5: "Ziege",
  6: "Kaninchen",
  7: "Lamm",
  8: "Fisch",
  9: "Vegan"
};

const enumCategory = {
  1: "Fleisch",
  2: "Magen",
  3: "Knochen",
  4: "Innereien",
  5: "Gemüse",
  6: "Obst",
};

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
  var recipeIngredient = [].obs;

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
                onPressed: () {},
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              TextField(
                onChanged: (textfeld1text) {},
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Rezeptname"),
              ),
              TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                      controller: _ingredientController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Zutatensuche")),
                  suggestionsCallback: (pattern) async {
                    return await supabase
                        .from('ingredient')
                        .select('name, type, category, vegan')
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
                          Text(enumCategory[suggestion['category']] as String),
                          Spacer(),
                          Text(enumType[suggestion['type']] as String)
                        ],
                      ),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    selectedIngredient = Ingredient(
                        name: (suggestion as Map)['name'] as String,
                        type: enumType[suggestion['type']] as String,
                        category:
                            enumCategory[suggestion['category']] as String,
                        icon:
                            Image.asset("assets/images/recipe/icons/beef.png"));
                    _ingredientController.text = (suggestion)['name'];
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
              // LayoutBuilder(builder: (context, constraints) {
              //   return Autocomplete(
              //     displayStringForOption: _displayStringForOption,
              //     optionsBuilder: (TextEditingValue textEditingValue) {
              //       return textEditingValue.text.isEmpty
              //           ? const Iterable<Ingredient>.empty()
              //           : _ingredientOptions.where((Ingredient option) {
              //               return option.name
              //                   .isCaseInsensitiveContains(textEditingValue.text);
              //             });
              //     },
              //     optionsViewBuilder: (context, onSelected, options) {
              //       return Align(
              //         alignment: Alignment.topLeft,
              //         child: Material(
              //           child: SizedBox(
              //             width: constraints.biggest.width,
              // child: ListView.builder(
              //     padding: EdgeInsets.zero,
              //     itemBuilder: ((context, index) {
              //       final option = options.elementAt(index);

              // return Card(
              //   child: ListTile(
              //     leading: option.icon,
              //     title: Text(
              //       option.name,
              //       style: TextStyle(fontSize: 24),
              //     ),
              //     subtitle: Row(
              //       children: [
              //         Text(option.category),
              //         Spacer(),
              //         Text(option.type)
              //       ],
              //     ),
              //     onTap: () => onSelected(option),
              //   ),
              //                   );
              //                 }),
              //                 itemCount: options.length),
              //           ),
              //         ),
              //       );
              //     },
              //     onSelected: (Ingredient selection) {
              //       debugPrint(
              //           'You just selected ${_displayStringForOption(selection)}');
              //     },
              //   );
              // }),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                      child: Card(
                          child: FlutterLogo(
                    size: 350,
                  )))),
              ElevatedButton(
                  onPressed: () {
                    recipeIngredient.add(selectedIngredient);
                  },
                  child: Text("Hinzufügen")),
              ElevatedButton(
                  onPressed: () {
                    print(recipeIngredient);
                  },
                  child: Text("show")),
              ElevatedButton(
                  onPressed: () {
                    recipeIngredient.clear();
                  },
                  child: Text("clear")),
              ExpansionTile(
                initiallyExpanded: true,
                title: Text("Zutaten"),
                children: [
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
            ]),
          ),
        ));
  }
}
