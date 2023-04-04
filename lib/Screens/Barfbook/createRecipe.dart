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
  double vegSum = 0;
  double fruitSum = 0;
  double meatSum = 0;
  double rumenSum = 0;
  double boneSum = 0;
  double organSum = 0;
  double weightSum = 0;
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
                                    print(suggestion['calories'].runtimeType);
                                    print(suggestion['protein'].runtimeType);
                                    print(suggestion);
                                    recipeIngredient.add(Ingredient(
                                        id: suggestion['id'],
                                        name: suggestion['name'],
                                        type: suggestion['type'],
                                        category: suggestion['category'],
                                        calories:
                                            suggestion['calories'].toDouble(),
                                        protein:
                                            suggestion['protein'].toDouble(),
                                        fat: suggestion['fat'].toDouble(),
                                        carbohydrates:
                                            suggestion['carbohydrates']
                                                .toDouble(),
                                        minerals:
                                            suggestion['minerals'].toDouble(),
                                        moisture:
                                            suggestion['moisture'].toDouble(),
                                        gram: double.parse(
                                          _recipeGramController.text,
                                        )));
                                    switch (suggestion['category']) {
                                      case 'Fleisch':
                                        meatSum += double.parse(
                                            _recipeGramController.text);
                                        break;
                                      case 'Pansen':
                                        rumenSum += double.parse(
                                            _recipeGramController.text);
                                        break;
                                      case 'Knochen':
                                        boneSum += double.parse(
                                            _recipeGramController.text);
                                        break;
                                      case 'Innereien':
                                        organSum += double.parse(
                                            _recipeGramController.text);
                                        break;
                                      case 'Gemüse':
                                        vegSum += double.parse(
                                            _recipeGramController.text);
                                        break;
                                      case 'Obst':
                                        fruitSum += double.parse(
                                            _recipeGramController.text);
                                        break;
                                      default:
                                        throw Error();
                                    }
                                    weightSum += double.parse(
                                        _recipeGramController.text);
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
                          _indicator(
                              Colors.green, "Vegetarisch", vegSum + fruitSum),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: SizedBox(
                              height: 200,
                              child: PieChart(PieChartData(
                                  pieTouchData: PieTouchData(touchCallback:
                                      (FlTouchEvent event, pieTouchResponse) {
                                    setState(() {
                                      if (!event.isInterestedForInteractions &&
                                          pieTouchResponse != null &&
                                          (pieTouchResponse.touchedSection!
                                                  .touchedSectionIndex !=
                                              -1)) {
                                        print(pieTouchResponse.touchedSection!
                                            .touchedSectionIndex);
                                        print(pieTouchResponse.touchedSection!
                                            .touchedSection!.value);
                                        print(pieTouchResponse.touchedSection!
                                            .touchedSection!.title);
                                        Get.defaultDialog(
                                            title: pieTouchResponse
                                                        .touchedSection!
                                                        .touchedSectionIndex ==
                                                    0
                                                ? 'Fleischanteil'
                                                : 'Gemüseanteil',
                                            content: SizedBox(
                                                height: 200,
                                                width: 300,
                                                child: BarChart(pieTouchResponse
                                                            .touchedSection!
                                                            .touchedSectionIndex ==
                                                        0
                                                    ? meatBarData()
                                                    : vegBarData())));
                                      }
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
                          _indicator(Colors.red, "Fleisch",
                              meatSum + rumenSum + boneSum + organSum)
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

  BarChartData meatBarData() {
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
        text = Text('G');
        break;
      case 1:
        text = Text('O');
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
        text = Text('M');
        break;
      case 1:
        text = Text('P');
        break;
      case 2:
        text = Text('K');
        break;
      case 3:
        text = Text('I');
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
    double y, {
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
            toY: weightSum == 0 ? 10 : weightSum,
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
            return makeGroupData(0, meatSum);
          case 1:
            return makeGroupData(1, rumenSum);
          case 2:
            return makeGroupData(2, boneSum);
          case 3:
            return makeGroupData(3, organSum);
          default:
            return throw Error();
        }
      });

  List<BarChartGroupData> vegGroups() => List.generate(2, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, vegSum);
          case 1:
            return makeGroupData(1, fruitSum);
          default:
            return throw Error();
        }
      });

  showSection() {
    return List.generate(2, (index) {
      final isTouched = index == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (index) {
        case 0:
          return PieChartSectionData(
            color: Colors.red,
            value: weightSum == 0
                ? 100 / 2
                : (meatSum + rumenSum + boneSum + organSum) / weightSum * 100,
            title: weightSum == 0
                ? '${(100 / 2).toStringAsFixed(1)}%'
                : '${(meatSum + rumenSum + boneSum + organSum) / weightSum * 100}%',
            titleStyle: TextStyle(
                fontSize: fontSize,
                shadows: shadows,
                color: Theme.of(context).colorScheme.onPrimary),
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
                : '${(vegSum + fruitSum) / weightSum * 100}%',
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
