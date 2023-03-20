import 'package:Barfbook/Screens/Barfbook/barfbook_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecipeDetailPage extends StatefulWidget {
  final Recipe recipe;
  const RecipeDetailPage({required this.recipe});

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  var currentPageViewItemIndicator = 0;
  PageController pageController = PageController();

  _pageViewController(int currentIndex) {
    currentPageViewItemIndicator = currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.name),
        actions: [
          IconButton(
              onPressed: () {
                Get.defaultDialog(
                    title: "Details",
                    textConfirm: "Profil ansehen",
                    middleText:
                        "Erstellt am ${widget.recipe.created_at} \nZuletzt bearbeitet am ${widget.recipe.modified_at}\nvon ${widget.recipe.user}");
              },
              icon: Icon(Icons.info)),
          IconButton(onPressed: () {}, icon: Icon(Icons.favorite))
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
}
