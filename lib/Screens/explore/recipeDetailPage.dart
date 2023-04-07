import 'package:Barfbook/Screens/Barfbook/barfbook_controller.dart';
import 'package:Barfbook/controller.dart';
import 'package:Barfbook/loading.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RecipeDetailPage extends StatefulWidget {
  final Recipe recipe;
  RecipeDetailPage({required this.recipe});

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  Future? _future;
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

  late List recipeIngredients = [];
  final Controller controller = Get.find();

  var currentPageViewItemIndicator = 0;
  PageController pageController = PageController();

  _pageViewController(int currentIndex) {
    currentPageViewItemIndicator = currentIndex;
  }

  bool favorite = false;
  @override
  void initState() {
    _future = loadData();
    for (Recipe recipe in controller.userLikedRecipe) {
      if (recipe.id == widget.recipe.id) {
        favorite = true;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.done
            ? Scaffold(
                appBar: AppBar(
                  title: Text(widget.recipe.name),
                  actions: [
                    IconButton(
                        onPressed: () {
                          print(weightSum);
                        },
                        icon: Icon(Icons.abc)),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {});
                          Get.defaultDialog(
                              title: 'Zutaten',
                              content: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                width: MediaQuery.of(context).size.height * 0.8,
                                child: SingleChildScrollView(
                                    child: Column(children: [
                                  Wrap(
                                    children: [
                                      for (Ingredient ingredient
                                          in recipeIngredients)
                                        Card(
                                            elevation: 4,
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 10),
                                                    child: Card(
                                                        child: FlutterLogo(
                                                            size: 70)),
                                                  ),
                                                  Flexible(
                                                    flex: 10,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          ingredient.name,
                                                          style: TextStyle(
                                                              fontSize: 18),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        Text(
                                                            '${ingredient.gram} Gramm'),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                    ],
                                  ),
                                ])),
                              ));
                        },
                        child: Text("Zutaten")),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            toggleFavorite();
                          });
                        },
                        icon: (favorite == true
                            ? Icon(Icons.favorite)
                            : Icon(Icons.favorite_border))),
                    IconButton(
                        onPressed: () {
                          Get.defaultDialog(
                              title: "Details",
                              textConfirm: "Profil ansehen",
                              middleText:
                                  "Erstellt am ${widget.recipe.created_at} \nZuletzt bearbeitet am ${widget.recipe.modified_at}\nvon ${widget.recipe.user}");
                        },
                        icon: Icon(Icons.info)),
                    IconButton(
                        onPressed: () {
                          Get.bottomSheet(
                              isScrollControlled: true,
                              Container(
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(25),
                                          topRight: Radius.circular(25))),
                                  height:
                                      MediaQuery.of(context).size.height * 0.8,
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: EdgeInsets.all(25),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Kommentare",
                                            style: TextStyle(fontSize: 31),
                                          ),
                                          SizedBox(height: 35),
                                          TextField(
                                            maxLines: 8,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 1,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary)),
                                              hintText:
                                                  "Schreib was dir gefällt!",
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          ElevatedButton(
                                              onPressed: () {},
                                              child: Text("Kommentieren")),
                                          SizedBox(height: 20),
                                          Obx(() => ListView(
                                                children: [Text("data")],
                                              ))
                                        ],
                                      ),
                                    ),
                                  )));
                        },
                        icon: Icon(Icons.comment)),
                    SizedBox(width: 30)
                  ],
                ),
                body: SingleChildScrollView(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.only(left: 15, right: 15, bottom: 10),
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            PageView.builder(
                                controller: pageController,
                                itemCount: 5,
                                onPageChanged: (int index) {
                                  setState(() {
                                    _pageViewController(index);
                                  });
                                },
                                itemBuilder: (_, index) {
                                  return ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Card(child: FlutterLogo()));
                                }),
                            Positioned(
                              bottom: 20,
                              child: Row(
                                children: _buildPageIndicator(),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.36,
                            child: Card(
                                child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _indicator(Colors.green, "Vegetarisch",
                                          vegSum + fruitSum),
                                      IconButton(
                                          onPressed: () {
                                            Get.defaultDialog(
                                                title:
                                                    'Analytische Bestandteile',
                                                content: Center(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20),
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
                                                              Text('Kalorien:'),
                                                              Text(
                                                                  '${caloriesSum.toStringAsFixed(1)}kcal')
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text('Protein:'),
                                                              Text(
                                                                  '${proteinSum.toStringAsFixed(1)}g')
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text('Fett:'),
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
                                    padding: EdgeInsets.symmetric(vertical: 25),
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
                                                  pieTouchResponse != null &&
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
                                                  pieTouchResponse == null ||
                                                  pieTouchResponse
                                                          .touchedSection ==
                                                      null) {
                                                touchedIndex = -1;
                                                return;
                                              }
                                              touchedIndex = pieTouchResponse
                                                  .touchedSection!
                                                  .touchedSectionIndex;
                                            });
                                          }),
                                          sectionsSpace: 0,
                                          centerSpaceRadius: 60,
                                          sections: showSection())),
                                    ),
                                  ),
                                  _indicator(Colors.red, "Fleisch",
                                      meatSum + rumenSum + boneSum + organSum)
                                ],
                              ),
                            ))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Column(
                          children: [
                            const Text("Beschreibung",
                                style: TextStyle(fontSize: 24)),
                            Text(
                              widget.recipe.description,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ))
            : Center(
                child: CircularProgressIndicator(),
              ));
  }

  Widget _pageIndicator(bool isActive) {
    return Container(
      height: 10,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        height: isActive ? 10 : 8.0,
        width: isActive ? 12 : 8.0,
        decoration: BoxDecoration(
          boxShadow: [
            isActive
                ? BoxShadow(
                    color: Color(0XFF2FB7B2).withOpacity(0.72),
                    blurRadius: 4.0,
                    spreadRadius: 1.0,
                  )
                : BoxShadow(
                    color: Colors.white38,
                  )
          ],
          shape: BoxShape.circle,
          color: isActive ? Colors.white : Colors.white38,
        ),
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < 5; i++) {
      list.add(i == currentPageViewItemIndicator
          ? _pageIndicator(true)
          : _pageIndicator(false));
    }
    return list;
  }

  updateLikedRecipe() async {
    for (var map in controller.userLikedRecipeXrefDB) {
      if (map?.containsKey("recipe") ?? false) {
        print(map['recipe']);
        var tempRecipe = await supabase
            .from('recipe')
            .select('id, created_at, modified_at, name, description')
            .eq('id', map['recipe']);

        controller.userLikedRecipe.clear();
        for (var recipe in tempRecipe) {
          controller.userLikedRecipe.add(Recipe(
              name: (recipe as Map)['name'],
              id: recipe['id'],
              created_at: recipe['created_at'],
              paws: 0,
              description: recipe['description'],
              modified_at: recipe['modified_at'],
              user_id: user!.id,
              user: ""));
        }
      }
    }
  }

  void toggleFavorite() async {
    if (favorite == false) {
      await supabase
          .from('profile_liked_recipe')
          .insert({'recipe': widget.recipe.id, 'profile': user?.id});
      loadData();
    } else {
      await supabase
          .from('profile_liked_recipe')
          .delete()
          .match({'recipe': widget.recipe.id, 'profile': user?.id});
      loadData();
    }
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

    // like check
    final liked = await supabase
        .from('profile_liked_recipe')
        .select('*', FetchOptions(count: CountOption.exact))
        .match({'profile': user?.id, 'recipe': widget.recipe.id});

    liked.count == 1 ? favorite = true : favorite = false;
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
