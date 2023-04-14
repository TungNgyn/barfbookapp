import 'package:Barfbook/Screens/Barfbook/barfbook_controller.dart';
import 'package:Barfbook/Screens/Mehr/editProfile.dart';
import 'package:Barfbook/Screens/Mehr/profile_controller.dart';
import 'package:Barfbook/Screens/calculator/pet_controller.dart';
import 'package:Barfbook/controller.dart';
import 'package:Barfbook/loading.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenProfile extends StatefulWidget {
  ScreenProfile({required this.profile});
  final Profile profile;

  @override
  State<ScreenProfile> createState() => _ScreenProfileState();
}

class _ScreenProfileState extends State<ScreenProfile>
    with TickerProviderStateMixin {
  final Controller controller = Get.find();
  TabController? tabController;
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
                    if (widget.profile.id == user?.id)
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: IconButton(
                            onPressed: () {
                              Get.to(() =>
                                  ScreenEditProfile(profile: widget.profile));
                            },
                            icon: Icon(Icons.edit)),
                      )
                  ],
                ),
                // body: Stack(children: [
                //   Opacity(
                //     opacity: 0.4,
                //     child: Container(
                //       decoration: BoxDecoration(
                //           image: DecorationImage(
                //               image:
                //                   AssetImage("assets/images/barfbookapp.png"),
                //               fit: BoxFit.cover)),
                //     ),
                //   ),
                //   Column(
                //     children: [
                // SafeArea(
                //   child: Column(
                //     children: [
                //       CircleAvatar(
                //         radius: 67,
                //         child: CircleAvatar(
                //             backgroundColor:
                //                 Theme.of(context).colorScheme.surface,
                //             radius: 64,
                //             child: Image.asset(
                //                 'assets/images/defaultAvatar.png')

                //             // FlutterLogo(
                //             //   size: 64,
                //             // ),
                //             ),
                //       ),
                //       Padding(
                //         padding: EdgeInsets.only(top: 24),
                //         child: Text(
                //           "${widget.profile.name}",
                //           style: TextStyle(
                //               fontWeight: FontWeight.w600, fontSize: 21),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SafeArea(
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 64,
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image:
                                            Image.memory(widget.profile.avatar)
                                                .image)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: Text(
                                "${widget.profile.name}",
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Über mich",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 21),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  widget.profile.description,
                                  style: TextStyle(fontSize: 18),
                                )
                              ],
                            ),
                            (petList.isEmpty)
                                ? Text("Noch keine Haustiere hinzugefügt.")
                                : Column(
                                    children: [
                                      for (var pet in petList)
                                        CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          radius: 64,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary),
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image:
                                                        Image.memory(pet.avatar)
                                                            .image)),
                                          ),
                                        ),
                                    ],
                                  ),
                            (recipeList.isEmpty)
                                ? Text("Noch keine Rezepte erstellt.")
                                : Column(
                                    children: [
                                      for (var recipe in recipeList)
                                        Text('${recipe.name}')
                                    ],
                                  ),
                          ],
                        ),
                      ),
                      SafeArea(
                        child: ElevatedButton(
                            onPressed: () {
                              print(petList);
                            },
                            child: Text("Pet")),
                      )
                    ],
                  ),
                ),
              )
            : Center(child: CircularProgressIndicator()));
  }

  Future? fetchData() async {
    try {
      final recipeDB = await supabase
          .from('recipe')
          .select('*')
          .eq('user_id', widget.profile.id);
      for (var recipe in recipeDB) {
        recipeList.add(Recipe(
            id: recipe['id'],
            name: recipe['name'],
            description: recipe['description'],
            paws: 0,
            created_at: recipe['created_at'],
            modified_at: recipe['modified_at'],
            user_id: recipe['user_id']));
      }
    } catch (error) {
      print(error);
    }
    try {
      final petDB =
          await supabase.from('pet').select('*').eq('owner', widget.profile.id);
      for (var pet in petDB) {
        print(pet['id']);
        final avatar =
            await supabase.storage.from('pet').download('${pet['id']}');
        petList.add(Pet(
            owner: pet['owner'],
            name: pet['name'],
            breed: pet['breed'],
            age: pet['age'],
            weight: pet['weight'],
            gender: pet['gender'],
            ration: pet['ration'].toDouble(),
            avatar: avatar));
      }
    } catch (error) {
      print(error);
    }
  }
}
