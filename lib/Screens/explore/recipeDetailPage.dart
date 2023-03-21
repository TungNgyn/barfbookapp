import 'package:Barfbook/Screens/Barfbook/barfbook_controller.dart';
import 'package:Barfbook/controller.dart';
import 'package:Barfbook/loading.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecipeDetailPage extends StatefulWidget {
  final Recipe recipe;
  const RecipeDetailPage({required this.recipe});

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  final Controller controller = Get.find();

  var currentPageViewItemIndicator = 0;
  PageController pageController = PageController();

  _pageViewController(int currentIndex) {
    currentPageViewItemIndicator = currentIndex;
  }

  bool favorite = false;
  @override
  void initState() {
    for (Recipe recipe in controller.userLikedRecipe) {
      if (recipe.id == widget.recipe.id) {
        favorite = true;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.name),
        actions: [
          ElevatedButton(
              onPressed: () async {
                await initData();
                print(controller.userLikedRecipe);
                print(controller.userLikedRecipeDB);
                print(controller.userLikedRecipeXrefDB);
              },
              child: Text("aaa")),
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
                            color: Theme.of(context).colorScheme.onPrimary,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25))),
                        height: MediaQuery.of(context).size.height * 0.8,
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
                                        "Schreib was dir besonders gefällt!",
                                  ),
                                ),
                                SizedBox(height: 5),
                                ElevatedButton(
                                    onPressed: () {},
                                    child: Text("Kommentieren"))
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
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
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
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: const Text("Beschreibung", style: TextStyle(fontSize: 24)),
            ),
            Text(
              widget.recipe.description,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }

  Widget _indicator(bool isActive) {
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
          ? _indicator(true)
          : _indicator(false));
    }
    return list;
  }

  updateLikedRecipe() async {
    for (var map in controller.userLikedRecipeXrefDB) {
      if (map?.containsKey("recipe") ?? false) {
        print(map['recipe']);
        var tempRecipe = await supabase
            .from('recipe')
            .select('id, created_at, modified_at, name, description, paws')
            .eq('id', map['recipe']);

        controller.userLikedRecipe.clear();
        for (var recipe in tempRecipe) {
          controller.userLikedRecipe.add(Recipe(
              name: (recipe as Map)['name'],
              id: recipe['id'],
              created_at: recipe['created_at'],
              paws: recipe['paws'],
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
      favorite = true;

      await supabase
          .from('profile_liked_recipe')
          .insert({'recipe': widget.recipe.id, 'profile': user!.id});
      initData();
    } else {
      favorite = false;
      await supabase
          .from('profile_liked_recipe')
          .delete()
          .match({'recipe': widget.recipe.id, 'profile': user?.id});
      initData();
    }

    // if (!controller.userLikedRecipe.contains(widget.recipe.id)) {
    // await supabase
    //     .from('profile_liked_recipe')
    //     .insert({'recipe': widget.recipe.id, 'profile': user!.id});
    //   controller.userLikedRecipe.clear();
    //   controller.userLikedRecipe = await supabase
    //       .from('profile_liked_recipe')
    //       .select('recipe')
    //       .eq('profile', user!.id);
    //   for (var recipe in controller.userLikedRecipeDB) {
    //     controller.userLikedRecipe.add(Recipe(
    //         name: (recipe as Map)['name'],
    //         id: recipe['id'],
    //         created_at: recipe['created_at'],
    //         paws: recipe['paws'],
    //         description: recipe['description'],
    //         modified_at: recipe['modified_at'],
    //         user_id: user!.id,
    //         user: ""));
    //   }
    // } else {

    // }
  }
}
