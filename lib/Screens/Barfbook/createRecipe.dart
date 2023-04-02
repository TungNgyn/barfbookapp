import 'dart:collection';

import 'package:Barfbook/Screens/Barfbook/Barfbook.dart';
import 'package:Barfbook/Screens/Barfbook/barfbook_controller.dart';
import 'package:Barfbook/controller.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:fl_chart/fl_chart.dart';
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

  int touchedIndex = -1;
  int vegSum = 0;
  int fruitSum = 0;
  int meatSum = 0;
  int rumenSum = 0;
  int boneSum = 0;
  int organSum = 0;
  int weightSum = 0;
  var recipeIngredient = [].obs;
  final Controller controller = Get.find();

  @override
  void dispose() {
    _ingredientController.dispose();
    _recipeNameController.dispose();
    _recipeDescriptionController.dispose();
    _recipeGramController.dispose();
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
                        .select('*')
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
                                    print(suggestion);
                                    recipeIngredient.add(Ingredient(
                                        name: (suggestion)['name'],
                                        id: suggestion['id'],
                                        type: suggestion['type'],
                                        category: suggestion['category'],
                                        calories: suggestion['calories'],
                                        protein: suggestion['protein'],
                                        fat: suggestion['fat'],
                                        carbohydrates:
                                            suggestion['carbohydrates'],
                                        minerals: suggestion['minerals'],
                                        moisture: suggestion['moisture'],
                                        gram: int.parse(
                                          _recipeGramController.text,
                                        )));
                                    suggestion['category'] == 'Fleisch'
                                        ? meatSum += int.parse(
                                            _recipeGramController.text)
                                        : vegSum += int.parse(
                                            _recipeGramController.text);
                                    weightSum +=
                                        int.parse(_recipeGramController.text);
                                    _ingredientController.clear();
                                    _recipeGramController.clear();
                                    Get.back();
                                    setState(() {});
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
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Zutaten"),
                  TextButton(
                      onPressed: () {
                        recipeIngredient.clear();
                        weightSum = 0;
                        meatSum = 0;
                        vegSum = 0;
                      },
                      child: Text("Alles entfernen")),
                ],
              ),
              SizedBox(height: 15),
              Obx(() {
                List<Widget> list = [];
                for (Ingredient ingredient in recipeIngredient) {
                  list.add(GestureDetector(
                    onTap: () {
                      // recipeIngredient.remove(ingredient);
                    },
                    child: Card(
                      elevation: 4,
                      color: Theme.of(context).colorScheme.background,
                      child: SizedBox(
                        height: 100,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Card(child: FlutterLogo(size: 70)),
                              ),
                              Flexible(
                                flex: 10,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ingredient.name,
                                      style: TextStyle(fontSize: 18),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text('${ingredient.gram} Gramm'),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      Card(
                                        elevation: 2,
                                        child: IconButton(
                                            onPressed: () {
                                              recipeIngredient
                                                  .remove(ingredient);
                                            },
                                            icon: Icon(Icons.remove)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          '1',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      Card(
                                        elevation: 2,
                                        child: IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.add)),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
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
                        child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _indicator(
                                      Color(0xff679267), "Gemüse", vegSum),
                                  _indicator(
                                      Color(0xffC9CC3F), "Obst", fruitSum)
                                ],
                              ),
                              _indicator(Colors.green, "Vegetarisch",
                                  vegSum + fruitSum)
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: SizedBox(
                              height: 200,
                              child: PieChart(PieChartData(
                                  pieTouchData: PieTouchData(touchCallback:
                                      (FlTouchEvent event, pieTouchResponse) {
                                    setState(() {
                                      if (!event.isInterestedForInteractions ||
                                          pieTouchResponse == null ||
                                          pieTouchResponse.touchedSection ==
                                              null) {
                                        touchedIndex = -1;
                                        return;
                                      }
                                      touchedIndex = pieTouchResponse
                                          .touchedSection!.touchedSectionIndex;
                                    });
                                  }),
                                  sectionsSpace: 0,
                                  centerSpaceRadius: 40,
                                  sections: showSection())),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _indicator(Color(0xffD2042D), "Muskelfleisch",
                                      meatSum),
                                  _indicator(
                                      Color(0xffEC5800), "Pansen", rumenSum),
                                  _indicator(
                                      Color(0xff8B636C), "Knochen", boneSum),
                                  _indicator(
                                      Color(0xff880808), "Innereien", organSum),
                                ],
                              ),
                              _indicator(Colors.red, "Fleisch",
                                  meatSum + rumenSum + boneSum + organSum)
                            ],
                          ),
                        ],
                      ),
                    ))),
              ),
              ElevatedButton(
                  onPressed: () {
                    print(weightSum);
                  },
                  child: Text("CALC")),
              TextField(
                  controller: _recipeDescriptionController,
                  maxLines: 20,
                  decoration:
                      InputDecoration(hintText: "Beschreibe dein Rezept!")),
            ]),
          ),
        ));
  }

  showSection() {
    return List.generate(6, (index) {
      final isTouched = index == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (index) {
        case 0:
          return PieChartSectionData(
            color: Color(0xffD2042D),
            value: weightSum == 0 ? 100 / 6 : meatSum / weightSum * 100,
            title: weightSum == 0
                ? '${(100 / 6).toStringAsFixed(1)}%'
                : '${meatSum / weightSum * 100}%',
            titleStyle: TextStyle(
                fontSize: fontSize,
                shadows: shadows,
                color: Theme.of(context).colorScheme.onPrimary),
            radius: radius,
          );
        case 1:
          return PieChartSectionData(
            color: Color(0xffEC5800),
            value: weightSum == 0 ? 100 / 6 : rumenSum / weightSum * 100,
            title: weightSum == 0
                ? '${(100 / 6).toStringAsFixed(1)}%'
                : '${rumenSum / weightSum * 100}%',
            titleStyle: TextStyle(
                fontSize: fontSize,
                shadows: shadows,
                color: Theme.of(context).colorScheme.onPrimary),
            radius: radius,
          );
        case 2:
          return PieChartSectionData(
            color: Color(0xff8B636C),
            value: weightSum == 0 ? 100 / 6 : boneSum / weightSum * 100,
            title: weightSum == 0
                ? '${(100 / 6).toStringAsFixed(1)}%'
                : '${boneSum / weightSum * 100}%',
            titleStyle: TextStyle(
                fontSize: fontSize,
                shadows: shadows,
                color: Theme.of(context).colorScheme.onPrimary),
            radius: radius,
          );
        case 3:
          return PieChartSectionData(
            color: Color(0xff880808),
            value: weightSum == 0 ? 100 / 6 : organSum / weightSum * 100,
            title: weightSum == 0
                ? '${(100 / 6).toStringAsFixed(1)}%'
                : '${organSum / weightSum * 100}%',
            titleStyle: TextStyle(
                fontSize: fontSize,
                shadows: shadows,
                color: Theme.of(context).colorScheme.onPrimary),
            radius: radius,
          );
        case 4:
          return PieChartSectionData(
            color: Color(0xff679267),
            value: weightSum == 0 ? 100 / 6 : vegSum / weightSum * 100,
            title: weightSum == 0
                ? '${(100 / 6).toStringAsFixed(1)}%'
                : '${vegSum / weightSum * 100}%',
            titleStyle: TextStyle(
                fontSize: fontSize,
                shadows: shadows,
                color: Theme.of(context).colorScheme.onPrimary),
            radius: radius,
          );
        case 5:
          return PieChartSectionData(
            color: Color(0xffC9CC3F),
            value: weightSum == 0 ? 100 / 6 : fruitSum / weightSum * 100,
            title: weightSum == 0
                ? '${(100 / 6).toStringAsFixed(1)}%'
                : '${fruitSum / weightSum * 100}%',
            titleStyle: TextStyle(
                fontSize: fontSize,
                shadows: shadows,
                color: Theme.of(context).colorScheme.onPrimary),
            radius: radius,
          );
        default:
          throw Error();
      }
    });
  }

  @override
  Widget _indicator(Color color, String text, var gram) {
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
        Text('${gram}g $text'),
      ],
    );
  }
}
