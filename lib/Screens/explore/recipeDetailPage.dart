import 'package:Barfbook/Screens/Barfbook/Barfbook.dart';
import 'package:Barfbook/Screens/Barfbook/Barfbook.dart';
import 'package:Barfbook/Screens/Barfbook/barfbook_controller.dart';
import 'package:Barfbook/Screens/Barfbook/editRecipe.dart';
import 'package:Barfbook/Screens/Barfbook/pet_controller.dart';
import 'package:Barfbook/Screens/Mehr/profile.dart';
import 'package:Barfbook/Screens/Mehr/profile_controller.dart';
import 'package:Barfbook/controller.dart';
import 'package:Barfbook/loading.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RecipeDetailPage extends StatefulWidget {
  final Recipe recipe;
  bool favorite;
  RecipeDetailPage({required this.recipe, this.favorite = false});

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  Future<List<dynamic>>? _future;
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

  @override
  void initState() {
    _future = Future.wait([loadData(), loadComments()]);
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
                  actions: [
                    if (widget.recipe.user_id == user!.id)
                      IconButton(
                          onPressed: () {
                            Get.to(
                                () => ScreenEditRecipe(recipe: widget.recipe));
                          },
                          icon: (Icon(Icons.edit))),
                    // IconButton(
                    //     onPressed: () {
                    //       TextEditingController _commentController =
                    //           TextEditingController();
                    //       Get.bottomSheet(
                    //           isScrollControlled: true,
                    //           Container(
                    //               decoration: BoxDecoration(
                    //                   color: Theme.of(context)
                    //                       .colorScheme
                    //                       .onPrimary,
                    //                   borderRadius: BorderRadius.only(
                    //                       topLeft: Radius.circular(25),
                    //                       topRight: Radius.circular(25))),
                    //               height:
                    //                   MediaQuery.of(context).size.height * 0.8,
                    //               child: SingleChildScrollView(
                    //                 child: Padding(
                    //                   padding: EdgeInsets.symmetric(
                    //                       horizontal: 10, vertical: 15),
                    //                   child: Column(
                    //                     children: [
                    //                       Text(
                    //                         "Kommentare",
                    //                         style: TextStyle(fontSize: 31),
                    //                       ),
                    //                       SizedBox(height: 35),
                    //                       TextField(
                    //                         controller: _commentController,
                    //                         maxLines: 8,
                    //                         decoration: InputDecoration(
                    //                           border: OutlineInputBorder(
                    //                               borderRadius:
                    //                                   BorderRadius.circular(
                    //                                       12)),
                    //                           hintText:
                    //                               "Schreib was dir gefällt!",
                    //                         ),
                    //                       ),
                    //                       SizedBox(height: 5),
                    //                       ElevatedButton(
                    //                           onPressed: () {
                    //                             setState(() {
                    //                               controller.commentList.add(Comment(
                    //                                   created_at: DateTime(
                    //                                       DateTime.now().year,
                    //                                       DateTime.now().month,
                    //                                       DateTime.now().day),
                    //                                   modified_at: DateTime(
                    //                                       DateTime.now().year,
                    //                                       DateTime.now().month,
                    //                                       DateTime.now().day),
                    //                                   recipeID:
                    //                                       widget.recipe.id,
                    //                                   profileID: user?.id,
                    //                                   comment:
                    //                                       _commentController
                    //                                           .text,
                    //                                   profile: Profile(
                    //                                       id: controller
                    //                                           .userProfile[
                    //                                               'user']
                    //                                           .id,
                    //                                       createdAt: controller
                    //                                           .userProfile[
                    //                                               'user']
                    //                                           .createdAt,
                    //                                       email: controller
                    //                                           .userProfile[
                    //                                               'user']
                    //                                           .email,
                    //                                       name: controller
                    //                                           .userProfile['user']
                    //                                           .name,
                    //                                       description: controller.userProfile['user'].description,
                    //                                       avatar: controller.userProfile['user'].avatar)));
                    //                               insertComment(
                    //                                   widget.recipe.id,
                    //                                   _commentController.text);
                    //                             });
                    //                           },
                    //                           child: Text("Kommentieren")),
                    //                       SizedBox(height: 20),
                    //                       Obx(() {
                    //                         List<Widget> list = [];
                    //                         if (controller
                    //                             .commentList.isEmpty) {
                    //                           list.add(
                    //                               Text("Keine Kommentare"));
                    //                         }

                    //                         for (Comment comment
                    //                             in controller.commentList) {
                    //                           list.insert(
                    //                               0,
                    //                               CommentCard(
                    //                                   comment: comment));
                    //                         }
                    //                         return Column(
                    //                           children: list,
                    //                         );
                    //                       })
                    //                     ],
                    //                   ),
                    //                 ),
                    //               )));
                    //     },
                    //     icon: Icon(Icons.comment)),
                  ],
                ),
                body:
                    // CustomScrollView(
                    // slivers: [
                    //   SliverAppBar(
                    //     expandedHeight: 300,
                    //     pinned: true,
                    //     flexibleSpace: FlexibleSpaceBar(
                    //       title: Text(
                    //         widget.recipe.name,
                    //         style: TextStyle(
                    //             color:
                    //                 Theme.of(context).textTheme.bodyLarge!.color),
                    //       ),
                    //       background: Padding(
                    //           padding:
                    //               EdgeInsets.only(bottom: 50, left: 35, right: 35),
                    //           child: widget.recipe.avatar),
                    //     ),
                    //     actions: [
                    //         widget.recipe.user_id != user!.id
                    //             ? IconButton(
                    //                 onPressed: () {
                    //                   setState(() {
                    //                     toggleFavorite();
                    //                   });
                    //                 },
                    //                 icon: (widget.favorite == true
                    //                     ? Icon(Icons.favorite)
                    //                     : Icon(Icons.favorite_border)))
                    //             : IconButton(
                    //                 onPressed: () {
                    //                   Get.to(() =>
                    //                       ScreenEditRecipe(recipe: widget.recipe));
                    //                 },
                    //                 icon: (Icon(Icons.edit))),
                    //         IconButton(
                    //             onPressed: () {
                    //               Get.defaultDialog(
                    //                   title: 'Details',
                    //                   content: Column(
                    //                     children: [
                    //                       GestureDetector(
                    //                         onTap: () {
                    //                           Get.to(() => ScreenProfile(
                    //                               profile: widget.recipe.user!));
                    //                         },
                    //                         child: Column(
                    //                           children: [
                    //                             CircleAvatar(
                    //                               child: widget.recipe.userAvatar,
                    //                               radius: 48,
                    //                             ),
                    //                             Text(
                    //                               '${widget.recipe.user!.name}',
                    //                               style: TextStyle(fontSize: 18),
                    //                             ),
                    //                           ],
                    //                         ),
                    //                       ),
                    //                       Text(
                    //                           "Erstellt am ${widget.recipe.created_at}"),
                    //                       Text(
                    //                           "Bearbeitet am ${widget.recipe.modified_at}"),
                    //                     ],
                    //                   ));
                    //             },
                    //             icon: Icon(Icons.info)),
                    //         IconButton(
                    //             onPressed: () {
                    //               TextEditingController _commentController =
                    //                   TextEditingController();
                    //               Get.bottomSheet(
                    //                   isScrollControlled: true,
                    //                   Container(
                    //                       decoration: BoxDecoration(
                    //                           color: Theme.of(context)
                    //                               .colorScheme
                    //                               .onPrimary,
                    //                           borderRadius: BorderRadius.only(
                    //                               topLeft: Radius.circular(25),
                    //                               topRight: Radius.circular(25))),
                    //                       height:
                    //                           MediaQuery.of(context).size.height *
                    //                               0.8,
                    //                       child: SingleChildScrollView(
                    //                         child: Padding(
                    //                           padding: EdgeInsets.only(
                    //                               left: 10,
                    //                               right: 10,
                    //                               top: 15,
                    //                               bottom: 20),
                    //                           child: Column(
                    //                             children: [
                    //                               Text(
                    //                                 "Kommentare",
                    //                                 style: TextStyle(fontSize: 31),
                    //                               ),
                    //                               SizedBox(height: 35),
                    //                               TextField(
                    //                                 controller: _commentController,
                    //                                 maxLines: 8,
                    //                                 decoration: InputDecoration(
                    //                                   border: OutlineInputBorder(
                    //                                       borderRadius:
                    //                                           BorderRadius.circular(
                    //                                               12)),
                    //                                   hintText:
                    //                                       "Schreib was dir gefällt!",
                    //                                 ),
                    //                               ),
                    //                               SizedBox(height: 5),
                    //                               ElevatedButton(
                    //                                   onPressed: () {
                    //                                     setState(() {
                    //                                       controller.commentList.add(Comment(
                    //                                           created_at: DateTime(
                    //                                               DateTime.now()
                    //                                                   .year,
                    //                                               DateTime.now()
                    //                                                   .month,
                    //                                               DateTime.now()
                    //                                                   .day),
                    //                                           modified_at: DateTime(
                    //                                               DateTime.now()
                    //                                                   .year,
                    //                                               DateTime.now()
                    //                                                   .month,
                    //                                               DateTime.now()
                    //                                                   .day),
                    //                                           recipeID:
                    //                                               widget.recipe.id,
                    //                                           profileID: user?.id,
                    //                                           comment:
                    //                                               _commentController
                    //                                                   .text,
                    //                                           profile: Profile(
                    //                                               id: controller
                    //                                                   .userProfile[
                    //                                                       'user']
                    //                                                   .id,
                    //                                               createdAt: controller
                    //                                                   .userProfile['user']
                    //                                                   .createdAt,
                    //                                               email: controller.userProfile['user'].email,
                    //                                               name: controller.userProfile['user'].name,
                    //                                               description: controller.userProfile['user'].description,
                    //                                               avatar: controller.userProfile['user'].avatar)));
                    //                                       insertComment(
                    //                                           widget.recipe.id,
                    //                                           _commentController
                    //                                               .text);
                    //                                     });
                    //                                   },
                    //                                   child: Text("Kommentieren")),
                    //                               SizedBox(height: 20),
                    //                               Obx(() {
                    //                                 List<Widget> list = [];
                    //                                 if (controller
                    //                                     .commentList.isEmpty) {
                    //                                   list.add(
                    //                                       Text("Keine Kommentare"));
                    //                                 }

                    //                                 for (Comment comment
                    //                                     in controller.commentList) {
                    //                                   list.insert(
                    //                                       0,
                    //                                       CommentCard(
                    //                                           comment: comment));
                    //                                 }
                    //                                 return Column(
                    //                                   children: list,
                    //                                 );
                    //                               })
                    //                             ],
                    //                           ),
                    //                         ),
                    //                       )));
                    //             },
                    //             icon: Icon(Icons.comment)),
                    //     ],
                    //   ),
                    SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.recipe.name,
                              style: TextStyle(fontSize: 31),
                            ),
                            IconButton(
                                onPressed: () {
                                  Get.defaultDialog(
                                      title: "Details",
                                      content: Column(
                                        children: [
                                          Container(
                                              height: 96,
                                              width: 96,
                                              child: widget.recipe.userAvatar),
                                          Text(widget.recipe.user!.name),
                                          Text(
                                              'Erstellt am ${widget.recipe.created_at.day}.${widget.recipe.created_at.month}.${widget.recipe.created_at.year}'),
                                          Text(
                                              'Bearbeitet am ${widget.recipe.modified_at.day}.${widget.recipe.modified_at.month}.${widget.recipe.modified_at.year}')
                                        ],
                                      ));
                                },
                                icon: Icon(Icons.info)),
                          ],
                        ),
                        Row(
                          children: [
                            FaIcon(FontAwesomeIcons.paw),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                '${widget.recipe.paws}',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                            onPressed: () {
                              TextEditingController _commentController =
                                  TextEditingController();
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
                                          MediaQuery.of(context).size.height *
                                              0.8,
                                      child: SingleChildScrollView(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 15),
                                          child: Column(
                                            children: [
                                              Text(
                                                "Kommentare",
                                                style: TextStyle(fontSize: 31),
                                              ),
                                              SizedBox(height: 35),
                                              TextField(
                                                controller: _commentController,
                                                maxLines: 8,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  hintText:
                                                      "Schreib was dir gefällt!",
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      controller.commentList.add(Comment(
                                                          created_at: DateTime(
                                                              DateTime.now()
                                                                  .year,
                                                              DateTime.now()
                                                                  .month,
                                                              DateTime.now()
                                                                  .day),
                                                          modified_at: DateTime(
                                                              DateTime.now()
                                                                  .year,
                                                              DateTime.now()
                                                                  .month,
                                                              DateTime.now()
                                                                  .day),
                                                          recipeID:
                                                              widget.recipe.id,
                                                          profileID: user?.id,
                                                          comment:
                                                              _commentController
                                                                  .text,
                                                          profile: Profile(
                                                              id: controller
                                                                  .userProfile[
                                                                      'user']
                                                                  .id,
                                                              createdAt: controller
                                                                  .userProfile['user']
                                                                  .createdAt,
                                                              email: controller.userProfile['user'].email,
                                                              name: controller.userProfile['user'].name,
                                                              description: controller.userProfile['user'].description,
                                                              avatar: controller.userProfile['user'].avatar,
                                                              rank: controller.userProfile['user'].rank)));
                                                      insertComment(
                                                          widget.recipe.id,
                                                          _commentController
                                                              .text);
                                                    });
                                                  },
                                                  child: Text("Kommentieren")),
                                              SizedBox(height: 20),
                                              Obx(() {
                                                List<Widget> list = [];
                                                if (controller
                                                    .commentList.isEmpty) {
                                                  list.add(
                                                      Text("Keine Kommentare"));
                                                }

                                                for (Comment comment
                                                    in controller.commentList) {
                                                  list.insert(
                                                      0,
                                                      CommentCard(
                                                          comment: comment));
                                                }
                                                return Column(
                                                  children: list,
                                                );
                                              })
                                            ],
                                          ),
                                        ),
                                      )));
                            },
                            child: Text(
                              "${controller.commentList.length} Kommentare",
                              style: TextStyle(fontSize: 16),
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            height: 256,
                            width: MediaQuery.of(context).size.width,
                            child: widget.recipe.avatar,
                          ),
                        ),
                        Text(
                          widget.recipe.description,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        if (widget.recipe.user_id != user!.id)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    toggleFavorite();
                                  });
                                },
                                child: Row(
                                  children: [
                                    Icon(widget.favorite == true
                                        ? (Icons.favorite)
                                        : (Icons.favorite_border)),
                                    Text("Rezept speichern"),
                                  ],
                                )),
                          ),
                        ElevatedButton(
                            onPressed: () {
                              Get.defaultDialog(
                                  title: 'Haustier auswählen',
                                  content: Column(
                                    children: [
                                      for (Pet pet in controller.userPetList)
                                        PetCard(pet: pet)
                                    ],
                                  ));
                            },
                            child: Row(
                              children: [
                                Icon(Icons.usb),
                                Text("Rezept anwenden"),
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: Colors.grey.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: Container(
                                color: Theme.of(context).colorScheme.surface,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    height: 100,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 10),
                                                  child: Container(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .surface,
                                                    child: Image.asset(
                                                      'assets/icons/ingredient/carbohydrates.png',
                                                      width: 40,
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Kohlenhydrate'),
                                                    Text(
                                                        '${carbohydratesSum.toStringAsFixed(1)}g'),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 10),
                                                  child: Container(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .surface,
                                                    child: Image.asset(
                                                      'assets/icons/ingredient/calories.png',
                                                      width: 40,
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Kalorien'),
                                                    Text(
                                                        '${caloriesSum.toStringAsFixed(1)}kcal'),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 10),
                                                  child: Container(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .surface,
                                                    child: Image.asset(
                                                      'assets/icons/ingredient/protein.png',
                                                      width: 40,
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Protein'),
                                                    Text(
                                                        '${proteinSum.toStringAsFixed(1)}g'),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 10),
                                                  child: Container(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .surface,
                                                    child: Image.asset(
                                                      'assets/icons/ingredient/fat.png',
                                                      width: 40,
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Fett'),
                                                    Text(
                                                        '${fatSum.toStringAsFixed(1)}g'),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.36,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _indicator(Colors.green, "Vegetarisch",
                                        vegSum + fruitSum),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
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
                              )),
                        ),
                        Text(
                          'Zutaten',
                          style: TextStyle(fontSize: 21),
                        ),
                        Wrap(
                          children: [
                            for (Ingredient ingredient in recipeIngredients)
                              Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(
                                      color: Colors.grey.withOpacity(0.2),
                                      width: 1,
                                    ),
                                  ),
                                  child: Container(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(right: 10),
                                            child: Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  side: BorderSide(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                    width: 1,
                                                  ),
                                                ),
                                                child: Container(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .surface,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: Image.asset(
                                                      'assets/icons/ingredient/${ingredient.avatar}.png',
                                                      width: 64,
                                                    ),
                                                  ),
                                                )),
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
                                                    '${ingredient.gram} Gramm (${getPercentage(ingredient.category, ingredient.gram)}%)'),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
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
    try {
      controller.userLikedRecipeXrefDB = await supabase
          .from('profile_liked_recipe')
          .select('profile, recipe')
          .eq('profile', user!.id);

      for (var map in controller.userLikedRecipeXrefDB) {
        if (map?.containsKey("recipe") ?? false) {
          var tempRecipe = await supabase
              .from('select_recipe')
              .select('*')
              .eq('id', map['recipe']);

          List<String> dateParts = tempRecipe['created_at'].split('-');
          int year = int.parse(dateParts[0]);
          int month = int.parse(dateParts[1]);
          int day = int.parse(dateParts[2].substring(0, 2));

          List<String> datePartsMod = tempRecipe['modified_at'].split('-');
          int yearMod = int.parse(datePartsMod[0]);
          int monthMod = int.parse(datePartsMod[1]);
          int dayMod = int.parse(datePartsMod[2].substring(0, 2));

          controller.userLikedRecipe.clear();
          for (var recipe in tempRecipe) {
            controller.userLikedRecipe.add(Recipe(
                name: (recipe as Map)['name'],
                id: recipe['id'],
                created_at: DateTime(year, month, day),
                paws: 0,
                description: recipe['description'],
                modified_at: DateTime(yearMod, monthMod, dayMod),
                user_id: user!.id));
          }
        }
      }
    } catch (error) {
      print(error);
    }
  }

  void toggleFavorite() async {
    if (widget.favorite == false) {
      await supabase
          .from('profile_liked_recipe')
          .insert({'recipe': widget.recipe.id, 'profile': user?.id});
      widget.favorite = true;
      // initFavorite();
      controller.userLikedRecipe.add(widget.recipe);
      setState(() {});
    } else {
      await supabase
          .from('profile_liked_recipe')
          .delete()
          .match({'recipe': widget.recipe.id, 'profile': user?.id});
      widget.favorite = false;
      // initFavorite();
      controller.userLikedRecipe.remove(widget.recipe);
      setState(() {});
    }
  }

  loadComments() async {
    try {
      final commentListDB = await supabase
          .from('recipe_comment')
          .select('*')
          .eq('recipe', widget.recipe.id)
          .order('created_at', ascending: true);
      controller.commentList.clear();
      for (var comment in commentListDB) {
        try {
          final userAvatar = CachedNetworkImage(
            imageUrl:
                'https://wokqzyqvqztmyzhhuqqh.supabase.co/storage/v1/object/public/profile/${comment['profile']}',
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => Icon(Icons.error),
            imageBuilder: (context, imageProvider) {
              return Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border:
                      Border.all(color: Theme.of(context).colorScheme.primary),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
          final profile = await supabase
              .from('profile')
              .select('*')
              .eq('id', comment['profile'])
              .single();
          DateTime createdTime = DateTime(
              int.parse(comment['created_at'].substring(0, 4)),
              int.parse(comment['created_at'].substring(5, 7)),
              int.parse(comment['created_at'].substring(8, 10)));
          DateTime modifiedTime = DateTime(
              int.parse(comment['modified_at'].substring(0, 4)),
              int.parse(comment['modified_at'].substring(5, 7)),
              int.parse(comment['modified_at'].substring(8, 10)));
          controller.commentList.add(Comment(
              id: comment['id'],
              created_at: createdTime,
              modified_at: modifiedTime,
              recipeID: comment['recipe'],
              profileID: comment['profile'],
              comment: comment['comment'],
              profile: Profile(
                  id: profile['id'],
                  email: profile['email'],
                  name: profile['name'],
                  description: profile['description'],
                  avatar: userAvatar,
                  rank: profile['rank'])));
        } catch (error) {
          print(error);
        }
      }
    } catch (error) {
      print(error);
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
        final gram = recipeIngredient['grams'];
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
              avatar: ingredient['avatar'],
              gram: gram));
          caloriesSum += (ingredient['calories'].toDouble() / 100 * gram);
          proteinSum += (ingredient['protein'].toDouble() / 100 * gram);
          fatSum += (ingredient['fat'].toDouble() / 100 * gram);
          carbohydratesSum +=
              (ingredient['carbohydrates'].toDouble() / 100 * gram);
          mineralsSum += (ingredient['minerals'].toDouble() / 100 * gram);
          moistureSum += (ingredient['moisture'].toDouble() / 100 * gram);
          switch (ingredient['category']) {
            case 'Muskelfleisch':
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

    //init favorite
    try {
      for (var recipe in controller.userLikedRecipe) {
        if (recipe.id == widget.recipe.id) {
          widget.favorite = true;
        }
      }
    } catch (error) {
      print(error);
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

  getPercentage(String category, int gram) {
    final percent;

    switch (category) {
      case 'Muskelfleisch':
      case 'Pansen':
      case 'Knochen':
      case 'Innereien':
        return percent =
            (gram / (meatSum + rumenSum + boneSum + organSum) * 100)
                .toStringAsFixed(1);
      case 'Gemüse':
      case 'Obst':
        return percent = (gram / (vegSum + fruitSum) * 100).toStringAsFixed(1);
      default:
        return percent = 0;
    }
  }
}

class CommentCard extends StatelessWidget {
  final Comment comment;
  const CommentCard({
    required this.comment,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool editable = false;
    TextEditingController _commentController =
        TextEditingController(text: comment.comment);
    String _comment = comment.comment;
    DateTime _modifiedTime = comment.modified_at;
    return StatefulBuilder(
      builder: (context, setState) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: Colors.grey.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(() => ScreenProfile(profile: comment.profile));
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 32,
                              child: comment.profile.avatar),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              comment.profile.name,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                            '${comment.created_at.day}.${comment.created_at.month}.${comment.created_at.year}'),
                        if (comment.created_at != comment.modified_at)
                          Row(
                            children: [
                              Icon(Icons.edit),
                              Text(
                                  '${comment.modified_at.day}.${comment.modified_at.month}.${comment.modified_at.year}'),
                            ],
                          )
                      ],
                    )
                  ],
                ),
                Divider(),
                Expanded(
                  child: editable
                      ? TextField(
                          controller: _commentController,
                          maxLines: 3,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    _comment = _commentController.text;
                                    setState(() => editable = false);
                                    updateComment(comment.id, _comment);
                                  },
                                  icon: Icon(Icons.edit)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12))),
                        )
                      : GestureDetector(
                          onTap: () {
                            if (comment.profile.id == user?.id) {
                              setState(() => editable = true);
                            }
                          },
                          child: Text(_comment)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateComment(id, value) async {
    try {
      await supabase.rpc('update_recipe_comment',
          params: {'commentid': id, 'commentvalue': value});
    } catch (error) {
      print(error);
    }
  }
}

void insertComment(recipe, comment) async {
  try {
    await supabase.rpc('insert_comment', params: {
      'recipevalue': recipe,
      'profilevalue': user?.id,
      'commentvalue': comment
    });
  } catch (error) {
    print(error);
  }
}

class Comment {
  const Comment(
      {this.id,
      required this.created_at,
      required this.modified_at,
      required this.recipeID,
      required this.profileID,
      required this.comment,
      required this.profile});

  final id;
  final created_at;
  final modified_at;
  final recipeID;
  final profileID;
  final String comment;
  final Profile profile;
}
