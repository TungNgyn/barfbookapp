import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class ScreenCreateRecipe extends StatefulWidget {
  const ScreenCreateRecipe({super.key});

  @override
  State<ScreenCreateRecipe> createState() => _newRecipeState();
}

late Map ingredientdata;

Future<void> getIngredient() async {
  var ingredients =
      await supabase.from('ingredient').select("name, type, category");
  var i = 1;
  for (var ingredient in ingredients) {
    i++;
    try {
      ingredientdata = await supabase
          .from('ingredient')
          .select("name, type, category")
          .match({'id': i}).single();
    } catch (error) {
      print("ERROR = $error");
    }
  }
}

class Ingredient {
  const Ingredient({required this.name, required this.icon});

  final String name;
  final Image icon;

  @override
  String toString() {
    return name;
  }
}

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

  @override
  Widget build(BuildContext context) {
    getIngredient();
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
            SizedBox(height: 20),
            TextField(
                onChanged: (textfeld2text) {
                  teil2 = textfeld2text;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Wort2")),
            LayoutBuilder(builder: (context, constraints) {
              return Autocomplete(
                displayStringForOption: _displayStringForOption,
                optionsBuilder: (TextEditingValue textEditingValue) {
                  return textEditingValue.text.isEmpty
                      ? const Iterable<Ingredient>.empty()
                      : _ingredientOptions.where((Ingredient option) {
                          return option.name
                              .isCaseInsensitiveContains(textEditingValue.text);
                        });
                },
                optionsViewBuilder: (context, onSelected, options) {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      child: SizedBox(
                        width: constraints.biggest.width,
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemBuilder: ((context, index) {
                              final option = options.elementAt(index);

                              return Card(
                                child: ListTile(
                                  leading: option.icon,
                                  title: Text(
                                    option.name,
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  onTap: () => onSelected(option),
                                ),
                              );
                            }),
                            itemCount: options.length),
                      ),
                    ),
                  );
                },
                onSelected: (Ingredient selection) {
                  debugPrint(
                      'You just selected ${_displayStringForOption(selection)}');
                },
              );
            }),
            ElevatedButton(
                onPressed: () {
                  debugPrint(supabase
                      .from('ingredient')
                      .select("name, type, category") as String?);
                },
                child: Text("ALLL"))
          ],
        ),
      ),
    );
  }

  List<Ingredient> _ingredientOptions = <Ingredient>[
    Ingredient(
        // name: ingredientdata["name"],
        name: "all",
        icon: Image.asset("assets/images/recipe/icons/beef.png")),
    Ingredient(
        name: "Ente", icon: Image.asset("assets/images/recipe/icons/duck.png")),
    Ingredient(
        name: "Huhn", icon: Image.asset("assets/images/recipe/icons/hen.png")),
    Ingredient(
        name: "Gans",
        icon: Image.asset("assets/images/recipe/icons/goose.png")),
    Ingredient(
        name: "Ziege",
        icon: Image.asset("assets/images/recipe/icons/goat.png")),
    Ingredient(
        name: "Pferd",
        icon: Image.asset("assets/images/recipe/icons/horse.png")),
    Ingredient(
        name: "Lamm", icon: Image.asset("assets/images/recipe/icons/lamb.png")),
    Ingredient(
        name: "Hase",
        icon: Image.asset("assets/images/recipe/icons/rabbit.png")),
    Ingredient(
        name: "Vegan",
        icon: Image.asset("assets/images/recipe/icons/vegan.png"))
  ];
  static String _displayStringForOption(Ingredient option) => option.name;
}
