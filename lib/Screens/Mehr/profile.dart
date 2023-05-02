import 'package:Barfbook/Screens/Barfbook/Barfbook.dart';
import 'package:Barfbook/Screens/Barfbook/barfbook_controller.dart';
import 'package:Barfbook/Screens/Mehr/editProfile.dart';
import 'package:Barfbook/Screens/Mehr/profile_controller.dart';
import 'package:Barfbook/Screens/Barfbook/pet_controller.dart';
import 'package:Barfbook/Screens/explore/explore.dart';
import 'package:Barfbook/controller.dart';
import 'package:Barfbook/loading.dart';
import 'package:Barfbook/main.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:Barfbook/util/database/database.dart';
import 'package:Barfbook/util/widgets/avatar_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenProfile extends StatefulWidget {
  ScreenProfile({required this.profileId});
  final String profileId;

  @override
  State<ScreenProfile> createState() => _ScreenProfileState();
}

class _ScreenProfileState extends State<ScreenProfile>
    with TickerProviderStateMixin {
  final Controller controller = Get.find();
  TabController? tabController;
  Profile? profile;
  Future? futureData;
  int selectedIndex = 0;
  List recipeList = [];
  List petList = [];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    futureData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureData,
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.done
            ? Scaffold(
                extendBodyBehindAppBar: true,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  actions: [
                    if (widget.profileId == user?.id)
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: IconButton(
                            onPressed: () {
                              Get.to(
                                  () => ScreenEditProfile(profile: profile!));
                            },
                            icon: Icon(Icons.edit)),
                      )
                  ],
                ),
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      SafeArea(
                        child: Column(
                          children: [
                            CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 64,
                                child: Container(
                                    child: getUserAvatar(widget.profileId))),
                            Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: Text(
                                "${profile!.name}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 31),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TabBar(
                                isScrollable: true,
                                controller: tabController,
                                indicator: BoxDecoration(
                                    borderRadius: BorderRadius.zero),
                                labelStyle: TextStyle(
                                    fontSize: 21, fontWeight: FontWeight.bold),
                                onTap: (tapIndex) {
                                  selectedIndex = tapIndex;
                                },
                                tabs: [
                                  Tab(text: "Profil"),
                                  Tab(text: "Haustiere"),
                                  Tab(text: "Rezepte"),
                                ])
                          ]),
                      SizedBox(height: 20),
                      Expanded(
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  Text(
                                    "Über mich",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 21),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    profile!.description,
                                    style: TextStyle(fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                            (petList.isEmpty)
                                ? Column(
                                    children: [
                                      Text("Noch keine Haustiere hinzugefügt."),
                                    ],
                                  )
                                : SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Wrap(
                                          children: [
                                            for (var pet in petList)
                                              BigPetCard(pet: pet)
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                            (recipeList.isEmpty)
                                ? Column(
                                    children: [
                                      Text("Noch keine Rezepte erstellt."),
                                    ],
                                  )
                                : SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Wrap(
                                          children: [
                                            for (var recipe in recipeList)
                                              BigRecipeCard(
                                                  controller: controller,
                                                  recipe: recipe)
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Center(child: CircularProgressIndicator()));
  }

  Future? fetchData() async {
    try {
      profile = await (database.select(database.profiles)
            ..where((tbl) => tbl.id.equals(widget.profileId)))
          .getSingle();
    } catch (error) {
      print(error);
    }
    try {
      final recipeDB = await supabase
          .from('select_recipe')
          .select('*')
          .eq('user_id', widget.profileId);
      for (final recipe in recipeDB) {
        await database.into(database.recipes).insertOnConflictUpdate(Recipe(
            id: recipe['id'],
            createdAt: getDateTime(recipe['created_at']),
            name: recipe['name'],
            description: recipe['description'],
            userId: recipe['user_id'],
            paws: recipe['paws'],
            modifiedAt: getDateTime(recipe['modified_at'])));
      }
      recipeList = await (database.select(database.recipes)
            ..where((tbl) => tbl.userId.equals(widget.profileId)))
          .get();
    } catch (error) {
      print(error);
    }
    try {
      final petDB =
          await supabase.from('pet').select('*').eq('owner', widget.profileId);
      for (var pet in petDB) {
        await database.into(database.pets).insertOnConflictUpdate(Pet(
              id: pet['id'],
              owner: widget.profileId,
              name: pet['name'],
              breed: pet['breed'],
              age: pet['age'],
              weight: pet['weight'],
              gender: pet['gender'],
              ration: pet['ration'].toDouble(),
            ));
      }
      petList = await (database.select(database.pets)
            ..where((tbl) => tbl.owner.equals(widget.profileId)))
          .get();
    } catch (error) {
      print(error);
    }
  }
}
