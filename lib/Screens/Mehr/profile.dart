import 'package:Barfbook/Screens/Mehr/profile_controller.dart';
import 'package:Barfbook/controller.dart';
import 'package:Barfbook/loading.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenProfile extends StatelessWidget {
  ScreenProfile({required this.profile});
  final Profile profile;
  final Controller controller = Get.find();
  var recipeList;

  initData() async {
    recipeList =
        await supabase.from('recipe').select('*').eq('user_id', profile.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initData(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.done
            ? Scaffold(
                extendBodyBehindAppBar: true,
                appBar: AppBar(
                  title: Text("Profil"),
                  backgroundColor: Colors.transparent,
                ),
                body: Stack(children: [
                  Opacity(
                    opacity: 0.4,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage("assets/images/barfbookapp.png"),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  Column(
                    children: [
                      SafeArea(
                        child: Column(
                          children: [
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05),
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/defaultAvatar.png"),
                              radius: 65,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 24),
                              child: Text(
                                "${profile.name}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 21),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: Text("${profile.email}"),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.33,
                                    child: Column(
                                      children: [
                                        Text(
                                          '${recipeList.length}',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text("Rezepte")
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.33,
                                    child: Column(
                                      children: [
                                        Text(
                                          "0",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "Pfoten",
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.33,
                                    child: Column(
                                      children: [
                                        Text(
                                          "0",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "Kommentare",
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
                      SizedBox(height: 30),
                      Expanded(
                        flex: 5,
                        child: Container(
                          color: Theme.of(context).colorScheme.onSecondary,
                          child: Center(
                              child: Column(
                            children: [
                              SizedBox(height: 30),
                              Text(
                                "Über mich",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 21),
                              ),
                              SizedBox(height: 20),
                              Text(
                                profile.description,
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          )),
                        ),
                      ),
                    ],
                  ),
                ]))
            : Center(child: CircularProgressIndicator()));
  }
}
