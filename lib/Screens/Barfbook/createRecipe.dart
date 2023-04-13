import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:Barfbook/Screens/Barfbook/barfbook_controller.dart';
import 'package:Barfbook/controller.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class ScreenCreateRecipe extends StatefulWidget {
  const ScreenCreateRecipe({super.key});

  @override
  State<ScreenCreateRecipe> createState() => _newRecipeState();
}

class _newRecipeState extends State<ScreenCreateRecipe> {
  final TextEditingController _ingredientController = TextEditingController();
  final TextEditingController _recipeNameController = TextEditingController();
  final TextEditingController _recipeDescriptionController =
      TextEditingController();

  final List selectedIngredients = [];

  final categoryFilter = [];
  final typeFilter = [];
  final List<CustomFilterChip> categoryList = [
    CustomFilterChip("Muskelfleisch", false),
    CustomFilterChip("Pansen", false),
    CustomFilterChip("Knochen", false),
    CustomFilterChip("Innereien", false),
    CustomFilterChip("Gemüse", false),
    CustomFilterChip("Obst", false),
  ];
  final List<CustomFilterChip> typeList = [
    CustomFilterChip("Rind", false),
    CustomFilterChip("Geflügel", false),
    CustomFilterChip("Lamm", false),
    CustomFilterChip("Pferd", false),
    CustomFilterChip("Vegetarisch", false),
  ];

  int touchedIndex = -1;
  List<double> vegSum = [0];
  List<double> fruitSum = [0];
  List<double> meatSum = [0];
  List<double> rumenSum = [0];
  List<double> boneSum = [0];
  List<double> organSum = [0];
  List<double> weightSum = [0];
  List<double> caloriesSum = [0];
  List<double> proteinSum = [0];
  List<double> fatSum = [0];
  List<double> carbohydratesSum = [0];
  List<double> mineralsSum = [0];
  List<double> moistureSum = [0];
  var recipeIngredient = [].obs;
  final Controller controller = Get.find();

  @override
  void dispose() {
    _ingredientController.dispose();
    _recipeNameController.dispose();
    _recipeDescriptionController.dispose();
    super.dispose();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   numberFocusNode.addListener(() {
  //     bool hasFocus = numberFocusNode.hasFocus;
  //     if (hasFocus) {
  //       KeyboardOverlay.showOverlay(context);
  //     } else {
  //       KeyboardOverlay.removeOverlay();
  //     }
  //   });
  // }

  Future<dynamic> _createRecipe() async {
    var recipeId = await supabase.rpc('insert_recipe', params: {
      'recipename': _recipeNameController.text,
      'recipedescription': _recipeDescriptionController.text,
      'userid': user?.id
    });
    for (Ingredient ingredient in recipeIngredient) {
      await supabase.rpc('insert_ingredients', params: {
        'recipeid': recipeId,
        'ingredientid': ingredient.id,
        'grams': ingredient.gram
      });
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
                  await _createRecipe().then((value) => Get.back());
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Zutaten",
                        style: TextStyle(fontSize: 18),
                      ),
                      IconButton(
                          onPressed: () {
                            Get.bottomSheet(
                                isScrollControlled: true,
                                StatefulBuilder(
                                  builder: (BuildContext context,
                                          StateSetter setModalState) =>
                                      Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.8,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25),
                                            topRight: Radius.circular(25))),
                                    child: ListView(
                                      children: [
                                        Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 15),
                                              child: Text(
                                                "Zutatensuche",
                                                style: TextStyle(
                                                    fontSize: 21,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: TypeAheadField(
                                                  textFieldConfiguration: TextFieldConfiguration(
                                                      controller:
                                                          _ingredientController,
                                                      decoration: InputDecoration(
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12)),
                                                          labelText:
                                                              "Suche nach Zutaten")),
                                                  suggestionsCallback:
                                                      (pattern) async {
                                                    return await supabase
                                                        .from('ingredient')
                                                        .select('*')
                                                        .ilike('name',
                                                            '%$pattern%')
                                                        .in_(
                                                            'category',
                                                            categoryFilter
                                                                    .isEmpty
                                                                ? [
                                                                    'Muskelfleisch',
                                                                    'Pansen',
                                                                    'Knochen',
                                                                    'Innereien',
                                                                    'Gemüse',
                                                                    'Obst'
                                                                  ]
                                                                : categoryFilter)
                                                        .in_(
                                                            'type',
                                                            typeFilter.isEmpty
                                                                ? [
                                                                    'Rind',
                                                                    'Lamm',
                                                                    'Vegetarisch',
                                                                    'Geflügel',
                                                                    'Pferd',
                                                                  ]
                                                                : typeFilter);
                                                  },
                                                  itemBuilder:
                                                      (context, suggestion) {
                                                    suggestion as Map;
                                                    return ListTile(
                                                      title: Text(
                                                        (suggestion)['name'],
                                                        style: TextStyle(
                                                            fontSize: 24),
                                                      ),
                                                      subtitle: Row(
                                                        children: [
                                                          Text(suggestion[
                                                              'category']),
                                                          Spacer(),
                                                          Text(suggestion[
                                                              'type'])
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  onSuggestionSelected:
                                                      (suggestion) {
                                                    suggestion as Map;
                                                    // Get.bottomSheet(
                                                    //   Container(
                                                    //     decoration: BoxDecoration(
                                                    //         color: Theme.of(context)
                                                    //             .colorScheme
                                                    //             .onPrimary,
                                                    //         borderRadius:
                                                    //             BorderRadius.only(
                                                    //                 topLeft: Radius
                                                    //                     .circular(
                                                    //                         25),
                                                    //                 topRight: Radius
                                                    //                     .circular(
                                                    //                         25))),
                                                    //     child: Padding(
                                                    //       padding:
                                                    //           EdgeInsets.all(10),
                                                    //       child: Column(
                                                    //         children: [
                                                    //           Text(
                                                    //             "${(suggestion)['name']}",
                                                    //             style: TextStyle(
                                                    //                 fontSize: 28),
                                                    //           ),
                                                    //           SizedBox(height: 30),
                                                    // TextField(
                                                    //   controller:
                                                    //       _recipeGramController,
                                                    //   keyboardType:
                                                    //       TextInputType
                                                    //           .number,
                                                    //   decoration: InputDecoration(
                                                    //       border:
                                                    //           OutlineInputBorder(),
                                                    //       labelText:
                                                    //           "Gewicht in Gramm"),
                                                    // ),
                                                    //           ElevatedButton(
                                                    //               onPressed: () {
                                                    recipeIngredient.add(Ingredient(
                                                        id: suggestion['id'],
                                                        name:
                                                            suggestion['name'],
                                                        type:
                                                            suggestion['type'],
                                                        category: suggestion[
                                                            'category'],
                                                        calories:
                                                            suggestion['calories']
                                                                .toDouble(),
                                                        protein:
                                                            suggestion['protein']
                                                                .toDouble(),
                                                        fat: suggestion['fat']
                                                            .toDouble(),
                                                        carbohydrates: suggestion[
                                                                'carbohydrates']
                                                            .toDouble(),
                                                        minerals: suggestion[
                                                                'minerals']
                                                            .toDouble(),
                                                        moisture: suggestion[
                                                                'moisture']
                                                            .toDouble(),
                                                        path: suggestion[
                                                            'path']));
                                                    //         Get.back();
                                                    //         setState(() {});
                                                    //       },
                                                    //       child: Text(
                                                    //           "Hinzufügen"))
                                                    // ],
                                                    // ),
                                                    // ),
                                                    // ),
                                                    // );
                                                  },
                                                  noItemsFoundBuilder:
                                                      (BuildContext context) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              20),
                                                      child: Text(
                                                        'Keine Zutat gefunden!',
                                                        style: TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                    );
                                                  }),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Text("Kategorie"),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: 15,
                                                  left: 15,
                                                  right: 15),
                                              child: Wrap(
                                                children: [
                                                  for (var category
                                                      in categoryList)
                                                    FilterChip(
                                                      label:
                                                          Text(category.label),
                                                      selected:
                                                          category.isSelected,
                                                      showCheckmark: false,
                                                      onSelected: (value) {
                                                        value == true
                                                            ? categoryFilter
                                                                .add(category
                                                                    .label)
                                                            : categoryFilter
                                                                .remove(category
                                                                    .label);

                                                        setModalState(() {
                                                          category.isSelected =
                                                              value;
                                                        });
                                                      },
                                                    )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Text("Art"),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: 15,
                                                  left: 15,
                                                  right: 15),
                                              child: Wrap(
                                                children: [
                                                  for (var type in typeList)
                                                    FilterChip(
                                                      label: Text(type.label),
                                                      selected: type.isSelected,
                                                      showCheckmark: false,
                                                      onSelected: (value) {
                                                        value == true
                                                            ? typeFilter
                                                                .add(type.label)
                                                            : typeFilter.remove(
                                                                type.label);

                                                        setModalState(() {
                                                          type.isSelected =
                                                              value;
                                                        });
                                                      },
                                                    )
                                                ],
                                              ),
                                            ),
                                            Obx(() {
                                              List<Widget> list = [];
                                              for (Ingredient ingredient
                                                  in recipeIngredient) {
                                                final _recipeGramController =
                                                    TextEditingController().obs;
                                                final _gramFocus = FocusNode();
                                                KeyboardActionsConfig
                                                    _buildKeyboardActionsConfig(
                                                        BuildContext context,
                                                        value) {
                                                  return KeyboardActionsConfig(
                                                    nextFocus: true,
                                                    keyboardActionsPlatform:
                                                        KeyboardActionsPlatform
                                                            .ALL,
                                                    keyboardBarColor:
                                                        Colors.grey[200],
                                                    actions: [
                                                      KeyboardActionsItem(
                                                        focusNode: _gramFocus,
                                                        toolbarButtons: [
                                                          (node) {
                                                            return GestureDetector(
                                                              onTap: () {
                                                                node.unfocus();
                                                              },
                                                              child: Icon(
                                                                  Icons.check),
                                                            );
                                                          }
                                                        ],
                                                      ),
                                                    ],
                                                  );
                                                }

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
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10),
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          10),
                                                              child: Card(
                                                                  child:
                                                                      Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10),
                                                                child: Image
                                                                    .network(
                                                                  ingredient
                                                                      .path,
                                                                  width: 64,
                                                                ),
                                                              )),
                                                            ),
                                                            Flexible(
                                                              flex: 7,
                                                              child: SizedBox(
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Tooltip(
                                                                      waitDuration:
                                                                          Duration
                                                                              .zero,
                                                                      message:
                                                                          ingredient
                                                                              .name,
                                                                      child:
                                                                          Text(
                                                                        ingredient
                                                                            .name,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                18),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                                    Text(ingredient
                                                                        .category),
                                                                    Text(ingredient
                                                                        .type)
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Flexible(
                                                              flex: 5,
                                                              child:
                                                                  KeyboardActions(
                                                                config: _buildKeyboardActionsConfig(
                                                                    context,
                                                                    _recipeGramController
                                                                        .value
                                                                        .text),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    IconButton(
                                                                        onPressed:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            recipeIngredient.remove(ingredient);

                                                                            caloriesSum.remove(ingredient.calories.toDouble() /
                                                                                100 *
                                                                                ingredient.gram);
                                                                            proteinSum.remove(ingredient.protein.toDouble() /
                                                                                100 *
                                                                                ingredient.gram);

                                                                            fatSum.remove(ingredient.fat.toDouble() /
                                                                                100 *
                                                                                ingredient.gram);
                                                                            carbohydratesSum.remove(ingredient.carbohydrates.toDouble() /
                                                                                100 *
                                                                                ingredient.gram);
                                                                            mineralsSum.remove(ingredient.minerals.toDouble() /
                                                                                100 *
                                                                                ingredient.gram);
                                                                            moistureSum.remove(ingredient.moisture.toDouble() /
                                                                                100 *
                                                                                ingredient.gram);
                                                                            switch (ingredient.category) {
                                                                              case 'Muskelfleisch':
                                                                                meatSum.remove(ingredient.gram);
                                                                                break;
                                                                              case 'Pansen':
                                                                                rumenSum.remove(ingredient.gram);
                                                                                break;
                                                                              case 'Knochen':
                                                                                boneSum.remove(ingredient.gram);
                                                                                break;
                                                                              case 'Innereien':
                                                                                organSum.remove(ingredient.gram);
                                                                                break;
                                                                              case 'Gemüse':
                                                                                vegSum.remove(ingredient.gram);
                                                                                break;
                                                                              case 'Obst':
                                                                                fruitSum.remove(ingredient.gram);
                                                                                break;
                                                                              default:
                                                                                throw Error();
                                                                            }
                                                                            weightSum.remove(ingredient.gram);
                                                                          });
                                                                        },
                                                                        icon: Icon(
                                                                            Icons.close)),
                                                                    TextField(
                                                                      onChanged:
                                                                          (value) {
                                                                        setState(
                                                                            () {
                                                                          //remove old value
                                                                          caloriesSum.remove(ingredient.calories.toDouble() /
                                                                              100 *
                                                                              ingredient.gram);
                                                                          proteinSum.remove(ingredient.protein.toDouble() /
                                                                              100 *
                                                                              ingredient.gram);

                                                                          fatSum.remove(ingredient.fat.toDouble() /
                                                                              100 *
                                                                              ingredient.gram);
                                                                          carbohydratesSum.remove(ingredient.carbohydrates.toDouble() /
                                                                              100 *
                                                                              ingredient.gram);
                                                                          mineralsSum.remove(ingredient.minerals.toDouble() /
                                                                              100 *
                                                                              ingredient.gram);
                                                                          moistureSum.remove(ingredient.moisture.toDouble() /
                                                                              100 *
                                                                              ingredient.gram);
                                                                          switch (
                                                                              ingredient.category) {
                                                                            case 'Muskelfleisch':
                                                                              meatSum.remove(ingredient.gram);
                                                                              break;
                                                                            case 'Pansen':
                                                                              rumenSum.remove(ingredient.gram);
                                                                              break;
                                                                            case 'Knochen':
                                                                              boneSum.remove(ingredient.gram);
                                                                              break;
                                                                            case 'Innereien':
                                                                              organSum.remove(ingredient.gram);
                                                                              break;
                                                                            case 'Gemüse':
                                                                              vegSum.remove(ingredient.gram);
                                                                              break;
                                                                            case 'Obst':
                                                                              fruitSum.remove(ingredient.gram);
                                                                              break;
                                                                            default:
                                                                              throw Error();
                                                                          }
                                                                          weightSum
                                                                              .remove(ingredient.gram);
                                                                          //update new value
                                                                          ingredient.gram = double.parse(_recipeGramController
                                                                              .value
                                                                              .text);
                                                                          caloriesSum.add(ingredient.calories.toDouble() /
                                                                              100 *
                                                                              double.parse(_recipeGramController.value.text));
                                                                          proteinSum.add(ingredient.protein.toDouble() /
                                                                              100 *
                                                                              double.parse(_recipeGramController.value.text));

                                                                          fatSum.add(ingredient.fat.toDouble() /
                                                                              100 *
                                                                              double.parse(_recipeGramController.value.text));
                                                                          carbohydratesSum.add(ingredient.carbohydrates.toDouble() /
                                                                              100 *
                                                                              double.parse(_recipeGramController.value.text));
                                                                          mineralsSum.add(ingredient.minerals.toDouble() /
                                                                              100 *
                                                                              double.parse(_recipeGramController.value.text));
                                                                          moistureSum.add(ingredient.moisture.toDouble() /
                                                                              100 *
                                                                              double.parse(_recipeGramController.value.text));
                                                                          switch (
                                                                              ingredient.category) {
                                                                            case 'Muskelfleisch':
                                                                              meatSum.add(double.parse(_recipeGramController.value.text));
                                                                              break;
                                                                            case 'Pansen':
                                                                              rumenSum.add(double.parse(_recipeGramController.value.text));
                                                                              break;
                                                                            case 'Knochen':
                                                                              boneSum.add(double.parse(_recipeGramController.value.text));
                                                                              break;
                                                                            case 'Innereien':
                                                                              organSum.add(double.parse(_recipeGramController.value.text));
                                                                              break;
                                                                            case 'Gemüse':
                                                                              vegSum.add(double.parse(_recipeGramController.value.text));
                                                                              break;
                                                                            case 'Obst':
                                                                              fruitSum.add(double.parse(_recipeGramController.value.text));
                                                                              break;
                                                                            default:
                                                                              throw Error();
                                                                          }
                                                                          weightSum.add(double.parse(_recipeGramController
                                                                              .value
                                                                              .text));
                                                                        });
                                                                      },
                                                                      inputFormatters: [
                                                                        FilteringTextInputFormatter
                                                                            .digitsOnly
                                                                      ],
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .number,
                                                                      textInputAction:
                                                                          TextInputAction
                                                                              .done,
                                                                      controller:
                                                                          _recipeGramController
                                                                              .value,
                                                                      decoration: InputDecoration(
                                                                          suffixIcon: Padding(
                                                                            padding:
                                                                                EdgeInsets.only(right: 5),
                                                                            child:
                                                                                Text('Gramm'),
                                                                          ),
                                                                          suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                                                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                                                          hintText: '${ingredient.gram}'),
                                                                      focusNode:
                                                                          _gramFocus,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ));
                                              }
                                              return Wrap(
                                                  alignment:
                                                      WrapAlignment.spaceEvenly,
                                                  direction: Axis.horizontal,
                                                  spacing: 5,
                                                  runSpacing: 5,
                                                  children: list);
                                            }),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                          },
                          icon: Icon(Icons.search))
                    ],
                  ),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          recipeIngredient.clear();
                          weightSum = [0];
                          meatSum = [0];
                          vegSum = [0];
                          fruitSum = [0];
                          rumenSum = [0];
                          boneSum = [0];
                          organSum = [0];
                          caloriesSum = [0];
                          proteinSum = [0];
                          fatSum = [0];
                          carbohydratesSum = [0];
                          mineralsSum = [0];
                          moistureSum = [0];
                        });
                      },
                      child: Text("Alles entfernen")),
                ],
              ),
              SizedBox(height: 15),
              Obx(() {
                List<Widget> list = [];
                for (Ingredient ingredient in recipeIngredient) {
                  list.add(InputChip(
                    label: Text(ingredient.name),
                    onDeleted: () {
                      setState(() {
                        recipeIngredient.remove(ingredient);

                        caloriesSum.remove(ingredient.calories.toDouble() /
                            100 *
                            ingredient.gram);
                        proteinSum.remove(ingredient.protein.toDouble() /
                            100 *
                            ingredient.gram);

                        fatSum.remove(
                            ingredient.fat.toDouble() / 100 * ingredient.gram);
                        carbohydratesSum.remove(
                            ingredient.carbohydrates.toDouble() /
                                100 *
                                ingredient.gram);
                        mineralsSum.remove(ingredient.minerals.toDouble() /
                            100 *
                            ingredient.gram);
                        moistureSum.remove(ingredient.moisture.toDouble() /
                            100 *
                            ingredient.gram);
                        switch (ingredient.category) {
                          case 'Muskelfleisch':
                            meatSum.remove(ingredient.gram);
                            break;
                          case 'Pansen':
                            rumenSum.remove(ingredient.gram);
                            break;
                          case 'Knochen':
                            boneSum.remove(ingredient.gram);
                            break;
                          case 'Innereien':
                            organSum.remove(ingredient.gram);
                            break;
                          case 'Gemüse':
                            vegSum.remove(ingredient.gram);
                            break;
                          case 'Obst':
                            fruitSum.remove(ingredient.gram);
                            break;
                          default:
                            throw Error();
                        }
                        weightSum.remove(ingredient.gram);
                      });
                    },
                  ));
                }
                return Wrap(
                  children: list,
                );
              }),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _indicator(
                                  Colors.green,
                                  "Vegetarisch",
                                  vegSum.fold<double>(0, (p, c) => p + c) +
                                      fruitSum.fold<double>(
                                          0, (p, c) => p + c)),
                              IconButton(
                                  onPressed: () {
                                    Get.defaultDialog(
                                        title: 'Analytische Bestandteile',
                                        content: Center(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text('Kalorien:'),
                                                      Text(
                                                          '${caloriesSum.fold<double>(0, (p, c) => p + c).toStringAsFixed(1)}kcal')
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text('Protein:'),
                                                      Text(
                                                          '${proteinSum.fold<double>(0, (p, c) => p + c).toStringAsFixed(1)}g')
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text('Fett:'),
                                                      Text(
                                                          '${fatSum.fold<double>(0, (p, c) => p + c).toStringAsFixed(1)}g')
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text('Kohlenhydrate:'),
                                                      Text(
                                                          '${carbohydratesSum.fold<double>(0, (p, c) => p + c).toStringAsFixed(1)}g')
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text('Mineralien:'),
                                                      Text(
                                                          '${mineralsSum.fold<double>(0, (p, c) => p + c).toStringAsFixed(1)}g')
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
                                  pieTouchData: PieTouchData(touchCallback:
                                      (FlTouchEvent event, pieTouchResponse) {
                                    setState(() {
                                      if (!event.isInterestedForInteractions &&
                                          pieTouchResponse != null &&
                                          (pieTouchResponse.touchedSection!
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
                                  centerSpaceRadius: 60,
                                  sections: showSection())),
                            ),
                          ),
                          _indicator(
                              Colors.red,
                              "Fleisch",
                              meatSum.fold<double>(0, (p, c) => p + c) +
                                  rumenSum.fold<double>(0, (p, c) => p + c) +
                                  boneSum.fold<double>(0, (p, c) => p + c) +
                                  organSum.fold<double>(0, (p, c) => p + c))
                        ],
                      ),
                    ))),
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
        text = Text(
            '${(vegSum.fold<double>(0, (p, c) => p + c) / (vegSum.fold<double>(0, (p, c) => p + c) + fruitSum.fold<double>(0, (p, c) => p + c)) * 100).toStringAsFixed(1)}%');
        break;
      case 1:
        text = Text(
            '${(fruitSum.fold<double>(0, (p, c) => p + c) / (vegSum.fold<double>(0, (p, c) => p + c) + fruitSum.fold<double>(0, (p, c) => p + c)) * 100).toStringAsFixed(1)}%');
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
            '${(meatSum.fold<double>(0, (p, c) => p + c) / (meatSum.fold<double>(0, (p, c) => p + c) + rumenSum.fold<double>(0, (p, c) => p + c) + boneSum.fold<double>(0, (p, c) => p + c) + organSum.fold<double>(0, (p, c) => p + c)) * 100).toStringAsFixed(1)}%');
        break;
      case 1:
        text = Text(
            '${(rumenSum.fold<double>(0, (p, c) => p + c) / (meatSum.fold<double>(0, (p, c) => p + c) + rumenSum.fold<double>(0, (p, c) => p + c) + boneSum.fold<double>(0, (p, c) => p + c) + organSum.fold<double>(0, (p, c) => p + c)) * 100).toStringAsFixed(1)}%');
        break;
      case 2:
        text = Text(
            '${(boneSum.fold<double>(0, (p, c) => p + c) / (meatSum.fold<double>(0, (p, c) => p + c) + rumenSum.fold<double>(0, (p, c) => p + c) + boneSum.fold<double>(0, (p, c) => p + c) + organSum.fold<double>(0, (p, c) => p + c)) * 100).toStringAsFixed(1)}%');
        break;
      case 3:
        text = Text(
            '${(organSum.fold<double>(0, (p, c) => p + c) / (meatSum.fold<double>(0, (p, c) => p + c) + rumenSum.fold<double>(0, (p, c) => p + c) + boneSum.fold<double>(0, (p, c) => p + c) + organSum.fold<double>(0, (p, c) => p + c)) * 100).toStringAsFixed(1)}%');
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
                0,
                meatSum.fold<double>(0, (p, c) => p + c),
                meatSum.fold<double>(0, (p, c) => p + c) +
                    rumenSum.fold<double>(0, (p, c) => p + c) +
                    boneSum.fold<double>(0, (p, c) => p + c) +
                    organSum.fold<double>(0, (p, c) => p + c));
          case 1:
            return makeGroupData(
                1,
                rumenSum.fold<double>(0, (p, c) => p + c),
                meatSum.fold<double>(0, (p, c) => p + c) +
                    rumenSum.fold<double>(0, (p, c) => p + c) +
                    boneSum.fold<double>(0, (p, c) => p + c) +
                    organSum.fold<double>(0, (p, c) => p + c));
          case 2:
            return makeGroupData(
                2,
                boneSum.fold<double>(0, (p, c) => p + c),
                meatSum.fold<double>(0, (p, c) => p + c) +
                    rumenSum.fold<double>(0, (p, c) => p + c) +
                    boneSum.fold<double>(0, (p, c) => p + c) +
                    organSum.fold<double>(0, (p, c) => p + c));
          case 3:
            return makeGroupData(
                3,
                organSum.fold<double>(0, (p, c) => p + c),
                meatSum.fold<double>(0, (p, c) => p + c) +
                    rumenSum.fold<double>(0, (p, c) => p + c) +
                    boneSum.fold<double>(0, (p, c) => p + c) +
                    organSum.fold<double>(0, (p, c) => p + c));
          default:
            return throw Error();
        }
      });

  List<BarChartGroupData> vegGroups() => List.generate(2, (i) {
        switch (i) {
          case 0:
            return makeGroupData(
                0,
                vegSum.fold<double>(0, (p, c) => p + c),
                vegSum.fold<double>(0, (p, c) => p + c) +
                    fruitSum.fold<double>(0, (p, c) => p + c));
          case 1:
            return makeGroupData(
                1,
                fruitSum.fold<double>(0, (p, c) => p + c),
                vegSum.fold<double>(0, (p, c) => p + c) +
                    fruitSum.fold<double>(0, (p, c) => p + c));
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
            value: weightSum.fold<double>(0, (p, c) => p + c) == 0
                ? 100 / 2
                : (meatSum.fold<double>(0, (p, c) => p + c) +
                        rumenSum.fold<double>(0, (p, c) => p + c) +
                        boneSum.fold<double>(0, (p, c) => p + c) +
                        organSum.fold<double>(0, (p, c) => p + c)) /
                    weightSum.fold<double>(0, (p, c) => p + c) *
                    100,
            title: weightSum.fold<double>(0, (p, c) => p + c) == 0
                ? '${(100 / 2).toStringAsFixed(1)}%'
                : '${((meatSum.fold<double>(0, (p, c) => p + c) + rumenSum.fold<double>(0, (p, c) => p + c) + boneSum.fold<double>(0, (p, c) => p + c) + organSum.fold<double>(0, (p, c) => p + c)) / weightSum.fold<double>(0, (p, c) => p + c) * 100).toStringAsFixed(1)}%',
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
            value: weightSum.fold<double>(0, (p, c) => p + c) == 0
                ? 100 / 2
                : (vegSum.fold<double>(0, (p, c) => p + c) +
                        fruitSum.fold<double>(0, (p, c) => p + c)) /
                    weightSum.fold<double>(0, (p, c) => p + c) *
                    100,
            title: weightSum.fold<double>(0, (p, c) => p + c) == 0
                ? '${(100 / 2).toStringAsFixed(1)}%'
                : '${((vegSum.fold<double>(0, (p, c) => p + c) + fruitSum.fold<double>(0, (p, c) => p + c)) / weightSum.fold<double>(0, (p, c) => p + c) * 100).toStringAsFixed(1)}%',
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
