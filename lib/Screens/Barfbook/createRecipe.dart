import 'dart:collection';

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

late List ingredientdata;

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
  late String teil1;
  late String teil2;
  var beef = false;
  var duck = false;
  var goat = false;
  var goose = false;
  var hen = false;
  var horse = false;
  var lamb = false;
  var rabbit = false;
  var vegan = false;

  final TextEditingController _ingredientController = TextEditingController();

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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              onChanged: (textfeld1text) {
                teil1 = textfeld1text;
              },
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
                  print(suggestion);
                  _ingredientController.text = (suggestion as Map)['name'];
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
                child: Text("show"))
          ],
        ),
      ),
    );
  }

  late Ingredient selectedIngredient;
  List<Ingredient> recipeIngredient = [];
  List<Ingredient> _ingredientOptions = <Ingredient>[
    for (var i = 0; i < ingredientdata.length; i++)
      Ingredient(
          name: "${ingredientdata[i]['name']}",
          type: enumType[ingredientdata[i]['type']] as String,
          category: enumCategory[ingredientdata[i]['category']] as String,
          icon: enumIcon[ingredientdata[i]['type']] as Image)
  ];

  String _displayStringForOption(Ingredient option) {
    selectedIngredient = option;
    return option.name;
  }
}
