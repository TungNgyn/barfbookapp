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
                            CircleAvatar(
                              radius: 67,
                              child: CircleAvatar(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.surface,
                                  radius: 64,
                                  child: Image.asset(
                                      'assets/images/defaultAvatar.png')

                                  // FlutterLogo(
                                  //   size: 64,
                                  // ),
                                  ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 24),
                              child: Text(
                                "${profile.name}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 21),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            color: Theme.of(context).colorScheme.surface,
                            child: Padding(
                              padding:
                                  EdgeInsets.only(top: 30, left: 24, right: 24),
                              child: Column(
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
                                    profile.description,
                                    style: TextStyle(fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]))
            : Center(child: CircularProgressIndicator()));
  }
}
