import 'package:Barfbook/Screens/Barfbook/barfbook_controller.dart';
import 'package:Barfbook/controller.dart';
import 'package:Barfbook/loading.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ScreenExplore extends StatefulWidget {
  @override
  State<ScreenExplore> createState() => _ScreenExploreState();
}

class _ScreenExploreState extends State<ScreenExplore>
    with AutomaticKeepAliveClientMixin<ScreenExplore> {
  final Controller controller = Get.find();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: _pullRefresh,
      child: Scaffold(
        appBar: _appBar(),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: ListView(
            children: [
              _searchBar(),
              Text(
                "Beliebt",
                style: TextStyle(fontSize: 24),
              ),
              ListView.builder(
                shrinkWrap: true,
                reverse: true,
                physics: ClampingScrollPhysics(),
                itemCount: controller.exploreRecipeList.length,
                itemBuilder: (_, index) {
                  Recipe recipe = controller.exploreRecipeList[index];
                  return Padding(
                      padding: EdgeInsets.only(bottom: 15, top: 10),
                      child:
                          Text("${recipe.name}, erstellt von ${recipe.user}"));
                },
              )
            ],
          ),
        ),
      ),
    );

    //   child: Scaffold(
    //     body: Center(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Card(
    //             child: Padding(
    //               padding:  EdgeInsets.all(20),
    //               child: Column(
    //                 children: [
    //                   Text(
    //                     "${controller.exploreRecipeList[index].getName()}",
    //                     style: TextStyle(fontSize: 31),
    //                   ),
    //                   Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       Row(
    //                         children: [
    //                           Text(
    //                             "${controller.exploreRecipeList[index].getPaws()} ",
    //                             style: TextStyle(fontSize: 20),
    //                           ),
    //                           FaIcon(FontAwesomeIcons.paw)
    //                         ],
    //                       ),
    //                       Text(
    //                           "erstellt von ${controller.exploreRecipeList[index].getUser()}")
    //                     ],
    //                   )
    //                 ],
    //               ),
    //             ),
    //           ),
    //           SizedBox(height: 10),
    //           Row(
    //             mainAxisSize: MainAxisSize.min,
    //             children: [
    //               ElevatedButton.icon(
    //                 onPressed: () {},
    //                 icon: FlutterLogo(),
    //                 label: Text('Like'),
    //               ),
    //               SizedBox(width: 10),
    //               ElevatedButton(
    //                 onPressed: () {
    //                   setState(() {
    //                     index == 0 ? index = 1 : index = 0;
    //                   });
    //                 },
    //                 child: Text('Next'),
    //               ),
    //             ],
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> _pullRefresh() async {
    setState(() {});
  }

  PreferredSize _appBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(120),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hallo ${userdata['name']}",
                    style: TextStyle(fontSize: 31),
                  ),
                  Text(
                    "Entdecke neues",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.menu),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding _searchBar() {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: TextField(
        decoration: InputDecoration(
            hintText: 'Suche',
            prefixIcon: Icon(Icons.search, color: Colors.grey),
            suffixIcon: Icon(Icons.menu, color: Colors.grey),
            contentPadding: EdgeInsets.all(20),
            border: OutlineInputBorder(borderSide: BorderSide(width: 1))),
      ),
    );
  }
}
