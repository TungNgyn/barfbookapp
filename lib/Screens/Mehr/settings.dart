import 'package:Barfbook/Screens/Account/Login.dart';
import 'package:Barfbook/Screens/Account/SignUp.dart';
import 'package:Barfbook/Screens/Mehr/editProfile.dart';
import 'package:Barfbook/Screens/Mehr/profile.dart';
import 'package:Barfbook/controller.dart';
import 'package:Barfbook/loading.dart';
import 'package:Barfbook/main.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:Barfbook/util/custom_theme.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase/src/supabase_stream_builder.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ScreenSettings extends StatefulWidget {
  @override
  _settingsStartState createState() => _settingsStartState();
}

class _settingsStartState extends State<ScreenSettings>
    with SingleTickerProviderStateMixin {
  final Controller controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Opacity(
        opacity: 0.4,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/splash/background.png"),
                  fit: BoxFit.cover)),
        ),
      ),
      Center(
        child: Column(
          children: [
            SafeArea(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (controller.userProfile['user'].name != 'Gast') {
                        Get.to(() => ScreenProfile(
                            profile: controller.userProfile['user']));
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 52,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: Image.memory(
                                        controller.userProfile['user'].avatar)
                                    .image)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      user != null || session != null
                          ? "${controller.userProfile['user'].name}"
                          : "Gast",
                      style:
                          TextStyle(fontWeight: FontWeight.w200, fontSize: 21),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.background,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Account Section
                        Padding(
                          padding: EdgeInsets.only(left: 20, bottom: 5),
                          child: Text(
                            "Account",
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: DefaultTextStyle.of(context)
                                    .style
                                    .fontFamily),
                          ),
                        ),
                        controller.userProfile['user'].name == 'Gast'
                            ? accountGuestSettings(context)
                            : accountSettings(context),
                        // System Section
                        Padding(
                          padding:
                              EdgeInsets.only(left: 20, bottom: 5, top: 30),
                          child: Text(
                            "System",
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onPrimary,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 0.01,
                                    blurRadius: 0.01,
                                    color:
                                        Theme.of(context).colorScheme.outline)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: ListView(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                                Column(
                                  children: [
                                    TextButton(
                                      onPressed: () =>
                                          Get.changeThemeMode(ThemeMode.light),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Hell",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium!
                                                  .color),
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      height: 0,
                                      thickness: 0.7,
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Get.changeThemeMode(ThemeMode.dark),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Dark",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium!
                                                  .color),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        //about us
                        Padding(
                          padding:
                              EdgeInsets.only(left: 20, bottom: 5, top: 30),
                          child: Text(
                            "Barfbook-Team",
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onPrimary,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 0.01,
                                    blurRadius: 0.01,
                                    color:
                                        Theme.of(context).colorScheme.outline)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: ListView(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                                Column(
                                  children: [
                                    TextButton(
                                      onPressed: () {},
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Über uns ",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium!
                                                  .color),
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      height: 0,
                                      thickness: 0.7,
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Get.changeThemeMode(ThemeMode.dark),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Dark",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium!
                                                  .color),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    ]));
  }

  Container accountSettings(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                spreadRadius: 0.01,
                blurRadius: 0.01,
                color: Theme.of(context).colorScheme.outline)
          ]),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(5),
                  child: TextButton(
                    onPressed: () => Get.to(() =>
                        ScreenProfile(profile: controller.userProfile['user'])),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Profil",
                        style: TextStyle(
                            letterSpacing: 0.5,
                            fontSize: 16,
                            fontFamily:
                                DefaultTextStyle.of(context).style.fontFamily,
                            color:
                                Theme.of(context).textTheme.labelMedium!.color),
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 0,
                  thickness: 0.7,
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: TextButton(
                    onPressed: () => Get.to(() => ScreenEditProfile(
                        profile: controller.userProfile['user'])),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Profil bearbeiten",
                        style: TextStyle(
                            letterSpacing: 0.5,
                            fontSize: 16,
                            fontFamily:
                                DefaultTextStyle.of(context).style.fontFamily,
                            color:
                                Theme.of(context).textTheme.labelMedium!.color),
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 0,
                  thickness: 0.7,
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: TextButton(
                    onPressed: () => print("Money"),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Abonnement abschließen",
                        style: TextStyle(
                            letterSpacing: 0.5,
                            fontSize: 16,
                            fontFamily:
                                DefaultTextStyle.of(context).style.fontFamily,
                            color:
                                Theme.of(context).textTheme.labelMedium!.color),
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 0,
                  thickness: 0.7,
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: TextButton(
                    onPressed: () => {
                      authController.signOut(),
                      Get.offAll(() => ScreenLogin())
                    },
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Abmelden",
                          style: TextStyle(
                              letterSpacing: 0.5,
                              fontSize: 16,
                              fontFamily:
                                  DefaultTextStyle.of(context).style.fontFamily,
                              color: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .color),
                        )),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  accountGuestSettings(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0.01,
                  blurRadius: 0.01,
                  color: Theme.of(context).colorScheme.outline)
            ]),
        child: Padding(
            padding: const EdgeInsets.all(5),
            child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Column(children: [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: TextButton(
                        onPressed: () => {
                          authController
                              .signOut()
                              .then((value) => Get.offAll(() => ScreenLogin()))
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Anmelden",
                            style: TextStyle(
                                letterSpacing: 0.5,
                                fontSize: 16,
                                fontFamily: DefaultTextStyle.of(context)
                                    .style
                                    .fontFamily,
                                color: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .color),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: TextButton(
                        onPressed: () => {
                          authController
                              .signOut()
                              .then((value) => Get.offAll(() => ScreenSignUp()))
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Account erstellen",
                            style: TextStyle(
                                letterSpacing: 0.5,
                                fontSize: 16,
                                fontFamily: DefaultTextStyle.of(context)
                                    .style
                                    .fontFamily,
                                color: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .color),
                          ),
                        ),
                      ),
                    )
                  ])
                ])));
  }
}
