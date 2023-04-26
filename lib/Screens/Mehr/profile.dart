import 'package:Barfbook/Screens/Barfbook/Barfbook.dart';
import 'package:Barfbook/Screens/Barfbook/barfbook_controller.dart';
import 'package:Barfbook/Screens/Mehr/editProfile.dart';
import 'package:Barfbook/Screens/Mehr/profile_controller.dart';
import 'package:Barfbook/Screens/Barfbook/pet_controller.dart';
import 'package:Barfbook/Screens/explore/explore.dart';
import 'package:Barfbook/controller.dart';
import 'package:Barfbook/loading.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
                                child: Container(child: widget.profile.avatar)),
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
                                    widget.profile.description,
                                    style: TextStyle(fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                            (petList.isEmpty)
                                ? Text("Noch keine Haustiere hinzugefügt.")
                                : SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Wrap(
                                          children: [
                                            for (var pet in petList)
                                              PetCard(pet: pet)
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                            (recipeList.isEmpty)
                                ? Text("Noch keine Rezepte erstellt.")
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
      final recipeDB = await supabase
          .from('recipe')
          .select('*')
          .eq('user_id', widget.profile.id);
      for (var recipe in recipeDB) {
        List userdata = await supabase
            .from('profile')
            .select("*")
            .match({'id': recipe['user_id']});
        final userAvatar = CachedNetworkImage(
          imageUrl:
              'https://wokqzyqvqztmyzhhuqqh.supabase.co/storage/v1/object/public/profile/${recipe['user_id']}',
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
        final paws = await supabase
            .from('profile_liked_recipe')
            .select('*', FetchOptions(count: CountOption.exact))
            .eq('recipe', recipe['id']);

        List<String> dateParts = recipe['created_at'].split('-');
        int year = int.parse(dateParts[0]);
        int month = int.parse(dateParts[1]);
        int day = int.parse(dateParts[2].substring(0, 2));

        List<String> datePartsMod = recipe['created_at'].split('-');
        int yearMod = int.parse(datePartsMod[0]);
        int monthMod = int.parse(datePartsMod[1]);
        int dayMod = int.parse(datePartsMod[2].substring(0, 2));

        recipeList.add(Recipe(
            id: recipe['id'],
            name: recipe['name'],
            description: recipe['description'],
            paws: paws.count,
            created_at: DateTime(year, month, day),
            modified_at: DateTime(yearMod, monthMod, dayMod),
            user_id: recipe['user_id'],
            avatar: CachedNetworkImage(
              imageUrl:
                  'https://wokqzyqvqztmyzhhuqqh.supabase.co/storage/v1/object/public/recipe/${recipe['id']}',
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => Icon(Icons.error),
              imageBuilder: (context, imageProvider) {
                return Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(
                        color: Theme.of(context).colorScheme.primary),
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
            user: Profile(
                id: userdata[0]['id'],
                createdAt: userdata[0]['created_at'],
                email: userdata[0]['email'],
                name: userdata[0]['name'],
                description: userdata[0]['description'],
                avatar: userAvatar),
            userAvatar: userAvatar));
      }
    } catch (error) {
      print(error);
    }
    try {
      final petDB =
          await supabase.from('pet').select('*').eq('owner', widget.profile.id);
      for (var pet in petDB) {
        // final avatar =
        //     await supabase.storage.from('pet').download('${pet['id']}');
        final avatar = CachedNetworkImage(
          imageUrl:
              'https://wokqzyqvqztmyzhhuqqh.supabase.co/storage/v1/object/public/pet/${pet['id']}',
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
