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
  final Recipe recipe;

  const ScreenEditRecipe({super.key, required this.recipe});

  @override
  State<ScreenEditRecipe> createState() => _editRecipeState();
}

class _editRecipeState extends State<ScreenEditRecipe> {
  Future? _future;
  final TextEditingController _ingredientController = TextEditingController();
  final TextEditingController _recipeNameController = TextEditingController();
  final TextEditingController _recipeDescriptionController =
      TextEditingController();

  int touchedIndex = -1;
  double vegSum = 0;
  double fruitSum = 0;
  double meatSum = 0;
  double rumenSum = 0;
  double boneSum = 0;
  double organSum = 0;
  double weightSum = 0;
  double caloriesSum = 0;
  double proteinSum = 0;
  double fatSum = 0;
  double carbohydratesSum = 0;
  double mineralsSum = 0;
  double moistureSum = 0;
  List ingredientList = [];
  late List recipeIngredients = [];
  List recipeIngredient = [].obs;
  final Controller controller = Get.find();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _ingredientController.dispose();
    _recipeNameController.dispose();
    _recipeDescriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _future = loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
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
                            await _updateRecipe().then((value) => Get.back());
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
                                  labelText: "${widget.recipe.name}"),
                            ),
                            // Text(recipeData['created_at']),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
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
                              for (Ingredient ingredient in recipeIngredient) {
                                list.add(GestureDetector(
                                  onTap: () {
                                    // recipeIngredient.remove(ingredient);
                                  },
                                  child: Card(
                                    elevation: 4,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    child: SizedBox(
                                      height: 100,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 10),
                                              child: Card(
                                                  child: FlutterLogo(size: 70)),
                                            ),
                                            Flexible(
                                              flex: 10,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    ingredient.name,
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                      '${ingredient.gram} Gramm'),
                                                ],
                                              ),
                                            ),
                                            Spacer(),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Row(
                                                  children: [
                                                    Card(
                                                      elevation: 2,
                                                      child: IconButton(
                                                          onPressed: () {
                                                            recipeIngredient
                                                                .remove(
                                                                    ingredient);
                                                          },
                                                          icon: Icon(
                                                              Icons.remove)),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      child: Text(
                                                        '1',
                                                        style: TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                    Card(
                                                      elevation: 2,
                                                      child: IconButton(
                                                          onPressed: () {},
                                                          icon:
                                                              Icon(Icons.add)),
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
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.36,
                                  child: Card(
                                      child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            _indicator(
                                                Colors.green,
                                                "Vegetarisch",
                                                vegSum + fruitSum),
                                            IconButton(
                                                onPressed: () {
                                                  Get.defaultDialog(
                                                      title:
                                                          'Analytische Bestandteile',
                                                      content: Center(
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      20),
                                                          child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                        'Kalorien:'),
                                                                    Text(
                                                                        '${caloriesSum.toStringAsFixed(1)}kcal')
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                        'Protein:'),
                                                                    Text(
                                                                        '${proteinSum.toStringAsFixed(1)}g')
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                        'Fett:'),
                                                                    Text(
                                                                        '${fatSum.toStringAsFixed(1)}g')
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                        'Kohlenhydrate:'),
                                                                    Text(
                                                                        '${carbohydratesSum.toStringAsFixed(1)}g')
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                        'Mineralien:'),
                                                                    Text(
                                                                        '${mineralsSum.toStringAsFixed(1)}g')
                                                                  ],
                                                                ),
                                                              ]),
                                                        ),
                                                      ));
                                                },
                                                icon: Icon(Icons.info))
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 25),
                                          child: SizedBox(
                                            height: 200,
                                            child: PieChart(PieChartData(
                                                pieTouchData: PieTouchData(
                                                    touchCallback:
                                                        (FlTouchEvent event,
                                                            pieTouchResponse) {
                                                  setState(() {
                                                    if (!event
                                                            .isInterestedForInteractions &&
                                                        pieTouchResponse !=
                                                            null &&
                                                        (pieTouchResponse
                                                                .touchedSection!
                                                                .touchedSectionIndex !=
                                                            -1)) {
                                                      Get.defaultDialog(
                                                          title: pieTouchResponse
                                                                      .touchedSection!
                                                                      .touchedSectionIndex ==
                                                                  0
                                                              ? 'Fleischanteil'
                                                              : 'Gemüseanteil',
                                                          content: SizedBox(
                                                              height: 200,
                                                              width: 200,
                                                              child: BarChart(pieTouchResponse
                                                                          .touchedSection!
                                                                          .touchedSectionIndex ==
                                                                      0
                                                                  ? meatBarData()
                                                                  : vegBarData())));
                                                    }
                                                    if (!event
                                                            .isInterestedForInteractions ||
                                                        pieTouchResponse ==
                                                            null ||
                                                        pieTouchResponse
                                                                .touchedSection ==
                                                            null) {
                                                      touchedIndex = -1;
                                                      return;
                                                    }
                                                    touchedIndex =
                                                        pieTouchResponse
                                                            .touchedSection!
                                                            .touchedSectionIndex;
                                                  });
                                                }),
                                                sectionsSpace: 0,
                                                centerSpaceRadius: 60,
                                                sections: showSection())),
                                          ),
                                        ),
                                        _indicator(
                                            Colors.red,
                                            "Fleisch",
                                            meatSum +
                                                rumenSum +
                                                boneSum +
                                                organSum)
                                      ],
                                    ),
                                  ))),
                            ),
                            TextField(
                                controller: _recipeDescriptionController,
                                maxLines: 10,
                                decoration: InputDecoration(
                                    hintText: "${widget.recipe.description}")),
                          ]))))
              : Scaffold(body: Center(child: CircularProgressIndicator()));
        });
  }

  loadData() async {
    // load ingredient
    recipeIngredients.clear();
    try {
      final recipeIngredientsList = await supabase
          .from('recipe_ingredient')
          .select('*')
          .eq('recipe', widget.recipe.id);
      for (var recipeIngredient in recipeIngredientsList) {
        final gram = recipeIngredient['grams'].toDouble();
        final ingredientsList = await supabase
            .from('ingredient')
            .select('*')
            .eq('id', recipeIngredient['ingredient']);
        for (var ingredient in ingredientsList) {
          recipeIngredients.add(Ingredient(
              id: ingredient['id'],
              name: ingredient['name'],
              type: ingredient['type'],
              category: ingredient['category'],
              calories: ingredient['calories'].toDouble(),
              protein: ingredient['protein'].toDouble(),
              fat: ingredient['fat'].toDouble(),
              carbohydrates: ingredient['carbohydrates'].toDouble(),
              minerals: ingredient['minerals'].toDouble(),
              moisture: ingredient['moisture'].toDouble(),
              gram: gram));
          caloriesSum += (ingredient['calories'].toDouble() / 100 * gram);
          proteinSum += (ingredient['protein'].toDouble() / 100 * gram);
          fatSum += (ingredient['fat'].toDouble() / 100 * gram);
          carbohydratesSum +=
              (ingredient['carbohydrates'].toDouble() / 100 * gram);
          mineralsSum += (ingredient['minerals'].toDouble() / 100 * gram);
          moistureSum += (ingredient['moisture'].toDouble() / 100 * gram);
          switch (ingredient['category']) {
            case 'Fleisch':
              meatSum += gram;
              break;
            case 'Pansen':
              rumenSum += gram;
              break;
            case 'Knochen':
              boneSum += gram;
              break;
            case 'Innereien':
              organSum += gram;
              break;
            case 'Gemüse':
              vegSum += gram;
              break;
            case 'Obst':
              fruitSum += gram;
              break;
            default:
              throw Error();
          }
          weightSum += gram;
        }
      }
    } catch (error) {
      print(error);
    }
  }

  Future<dynamic> _updateRecipe() async {
    try {
      await supabase.rpc('update_recipe', params: {
        'recipename': _recipeNameController.text,
        'recipedescription': _recipeDescriptionController.text,
        'recipeid': widget.recipe.id
      });
      await supabase
          .from('recipe_ingredient')
          .delete()
          .eq('recipe', widget.recipe.id);
      for (Ingredient ingredient in recipeIngredient) {
        await supabase.rpc('insert_ingredients', params: {
          'recipeid': widget.recipe.id,
          'ingredientid': ingredient.id
        });
      }
    } catch (error) {
      print(error);
      Get.snackbar("Fehler!", "Etwas hat nicht funktioniert");
    }
  }

  BarChartData meatBarData() {
    return BarChartData(
        alignment: BarChartAlignment.spaceBetween,
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            tooltipHorizontalAlignment: FLHorizontalAlignment.right,
            tooltipMargin: -10,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String component;
              switch (group.x) {
                case 0:
                  component = 'Muskelfleisch';
                  break;
                case 1:
                  component = 'Magen/Pansen';
                  break;
                case 2:
                  component = 'Fleischige Knochen';
                  break;
                case 3:
                  component = 'Innereien';
                  break;
                default:
                  throw Error();
              }
              return BarTooltipItem(
                '$component\n',
                const TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '${(rod.toY - 1).toStringAsFixed(1)}g',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
            show: true,
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: meatTitles,
                    reservedSize: 38))),
        borderData: FlBorderData(show: false),
        barGroups: meatGroups(),
        gridData: FlGridData(show: false));
  }

  BarChartData vegBarData() {
    return BarChartData(
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            tooltipHorizontalAlignment: FLHorizontalAlignment.right,
            tooltipMargin: -10,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String component;
              switch (group.x) {
                case 0:
                  component = 'Gemüse';
                  break;
                case 1:
                  component = 'Obst';
                  break;
                default:
                  throw Error();
              }
              return BarTooltipItem(
                '$component\n',
                const TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '${(rod.toY - 1).toStringAsFixed(1)}g',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
            show: true,
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: vegTitles,
                    reservedSize: 38))),
        borderData: FlBorderData(show: false),
        barGroups: vegGroups(),
        gridData: FlGridData(show: false));
  }

  Widget vegTitles(double value, TitleMeta meta) {
    Widget text;
    switch (value.toInt()) {
      case 0:
        text =
            Text('${(vegSum / (vegSum + fruitSum) * 100).toStringAsFixed(1)}%');
        break;
      case 1:
        text = Text(
            '${(fruitSum / (vegSum + fruitSum) * 100).toStringAsFixed(1)}%');
        break;
      default:
        text = Text('');
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  Widget meatTitles(double value, TitleMeta meta) {
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text(
            '${(meatSum / (meatSum + rumenSum + boneSum + organSum) * 100).toStringAsFixed(1)}%');
        break;
      case 1:
        text = Text(
            '${(rumenSum / (meatSum + rumenSum + boneSum + organSum) * 100).toStringAsFixed(1)}%');
        break;
      case 2:
        text = Text(
            '${(boneSum / (meatSum + rumenSum + boneSum + organSum) * 100).toStringAsFixed(1)}%');
        break;
      case 3:
        text = Text(
            '${(organSum / (meatSum + rumenSum + boneSum + organSum) * 100).toStringAsFixed(1)}%');
        break;
      default:
        text = Text('');
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y,
    double yMax, {
    Color? barColor,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    barColor = Theme.of(context).colorScheme.tertiary;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y + 1,
          color: barColor,
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: yMax,
            color: barColor.withOpacity(0.1),
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> meatGroups() => List.generate(4, (i) {
        switch (i) {
          case 0:
            return makeGroupData(
                0, meatSum, meatSum + rumenSum + boneSum + organSum);
          case 1:
            return makeGroupData(
                1, rumenSum, meatSum + rumenSum + boneSum + organSum);
          case 2:
            return makeGroupData(
                2, boneSum, meatSum + rumenSum + boneSum + organSum);
          case 3:
            return makeGroupData(
                3, organSum, meatSum + rumenSum + boneSum + organSum);
          default:
            return throw Error();
        }
      });

  List<BarChartGroupData> vegGroups() => List.generate(2, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, vegSum, vegSum + fruitSum);
          case 1:
            return makeGroupData(1, fruitSum, vegSum + fruitSum);
          default:
            return throw Error();
        }
      });

  showSection() {
    return List.generate(2, (index) {
      final isTouched = index == touchedIndex;
      final fontSize = isTouched ? 25.0 : 18.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 20)];
      switch (index) {
        case 0:
          return PieChartSectionData(
            color: Colors.red,
            value: weightSum == 0
                ? 100 / 2
                : (meatSum + rumenSum + boneSum + organSum) / weightSum * 100,
            title: weightSum == 0
                ? '${(100 / 2).toStringAsFixed(1)}%'
                : '${((meatSum + rumenSum + boneSum + organSum) / weightSum * 100).toStringAsFixed(1)}%',
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                shadows: shadows,
                color: Theme.of(context).colorScheme.onSecondary),
            radius: radius,
          );
        case 1:
          return PieChartSectionData(
            color: Colors.green,
            value: weightSum == 0
                ? 100 / 2
                : (vegSum + fruitSum) / weightSum * 100,
            title: weightSum == 0
                ? '${(100 / 2).toStringAsFixed(1)}%'
                : '${((vegSum + fruitSum) / weightSum * 100).toStringAsFixed(1)}%',
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                shadows: shadows,
                color: Theme.of(context).colorScheme.onSecondary),
            radius: radius,
          );
        default:
          throw Error();
      }
    });
  }

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
