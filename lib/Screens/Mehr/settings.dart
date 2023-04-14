import 'package:Barfbook/Screens/Account/Login.dart';
import 'package:Barfbook/Screens/Account/SignUp.dart';
import 'package:Barfbook/Screens/Mehr/AGB.dart';
import 'package:Barfbook/Screens/Mehr/aboutUsPage.dart';
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
  bool isPressedLight = false;
  bool isPressedDark = false;
  bool isPressedAbout = false;
  bool isPressedAGB = false;

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
                      radius: 64,
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
                    child: Column(
                      children: [
                        Text(
                          user != null || session != null
                              ? "${controller.userProfile['user'].name}"
                              : "Gast",
                          style: TextStyle(
                              fontWeight: FontWeight.w200, fontSize: 24),
                        ),
                        if (user != null || session != null)
                          Text("${controller.userProfile['user'].email}")
                      ],
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
                          child: ListView(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              Column(
                                children: [
                                  GestureDetector(
                                    onTapDown: (details) {
                                      setState(() {
                                        isPressedLight = true;
                                      });
                                    },
                                    onTapCancel: () {
                                      setState(() {
                                        isPressedLight = false;
                                      });
                                    },
                                    onTap: () => {
                                      Get.changeThemeMode(ThemeMode.light),
                                      setState(() {
                                        isPressedLight = false;
                                      })
                                    },
                                    child: Container(
                                      color: isPressedLight
                                          ? Colors.transparent.withOpacity(0.1)
                                          : Colors.transparent,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Light",
                                            style: TextStyle(
                                                letterSpacing: 0.5,
                                                fontSize: 16,
                                                fontFamily:
                                                    DefaultTextStyle.of(context)
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
                                  ),
                                  Divider(
                                    height: 0,
                                    thickness: 0.7,
                                  ),
                                  GestureDetector(
                                    onTapDown: (details) {
                                      setState(() {
                                        isPressedDark = true;
                                      });
                                    },
                                    onTapCancel: () {
                                      setState(() {
                                        isPressedDark = false;
                                      });
                                    },
                                    onTap: () => {
                                      Get.changeThemeMode(ThemeMode.dark),
                                      setState(() {
                                        isPressedDark = false;
                                      })
                                    },
                                    child: Container(
                                      color: isPressedDark
                                          ? Colors.transparent.withOpacity(0.1)
                                          : Colors.transparent,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Dark",
                                              style: TextStyle(
                                                  letterSpacing: 0.5,
                                                  fontSize: 16,
                                                  fontFamily:
                                                      DefaultTextStyle.of(
                                                              context)
                                                          .style
                                                          .fontFamily,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium!
                                                      .color),
                                            )),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
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
                          child: ListView(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              Column(
                                children: [
                                  GestureDetector(
                                    onTapDown: (details) {
                                      setState(() {
                                        isPressedAGB = true;
                                      });
                                    },
                                    onTapCancel: () {
                                      setState(() {
                                        isPressedAGB = false;
                                      });
                                    },
                                    onTap: () => {
                                      Get.to(() => AGB()),
                                      setState(() {
                                        isPressedAGB = false;
                                      })
                                    },
                                    child: Container(
                                      color: isPressedAGB
                                          ? Colors.transparent.withOpacity(0.1)
                                          : Colors.transparent,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Allgemeine Geschäftsbedingungen",
                                              style: TextStyle(
                                                  letterSpacing: 0.5,
                                                  fontSize: 16,
                                                  fontFamily:
                                                      DefaultTextStyle.of(
                                                              context)
                                                          .style
                                                          .fontFamily,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium!
                                                      .color),
                                            )),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    height: 0,
                                    thickness: 0.7,
                                  ),
                                  GestureDetector(
                                    onTapDown: (details) {
                                      setState(() {
                                        isPressedAbout = true;
                                      });
                                    },
                                    onTapCancel: () {
                                      setState(() {
                                        isPressedAbout = false;
                                      });
                                    },
                                    onTap: () => {
                                      Get.to(() => AboutUsPage()),
                                      setState(() {
                                        isPressedAbout = false;
                                      })
                                    },
                                    child: Container(
                                      color: isPressedAbout
                                          ? Colors.transparent.withOpacity(0.1)
                                          : Colors.transparent,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Über uns",
                                            style: TextStyle(
                                                letterSpacing: 0.5,
                                                fontSize: 16,
                                                fontFamily:
                                                    DefaultTextStyle.of(context)
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
                                  ),
                                ],
                              )
                            ],
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

  bool isPressedProfile = false;
  bool isPressedAbo = false;
  bool isPressedLogOff = false;
  bool isPressedProfileEdit = false;
  bool isPressed = false;
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
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Column(
            children: [
              GestureDetector(
                onTapDown: (details) {
                  setState(() {
                    isPressedProfile = true;
                  });
                },
                onTapCancel: () {
                  setState(() {
                    isPressedProfile = false;
                  });
                },
                onTap: () {
                  setState(() {
                    isPressedProfile = false;
                  });
                  Get.to(
                    () =>
                        ScreenProfile(profile: controller.userProfile['user']),
                  );
                },
                child: Container(
                  color: isPressedProfile
                      ? Colors.transparent.withOpacity(0.1)
                      : Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Icon(Icons.account_box),
                          Text(
                            "Profil",
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
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Divider(
                height: 0,
                thickness: 0.7,
              ),
              GestureDetector(
                onTapDown: (details) {
                  setState(() {
                    isPressedProfileEdit = true;
                  });
                },
                onTapCancel: () {
                  setState(() {
                    isPressedProfileEdit = false;
                  });
                },
                onTap: () => {
                  Get.to(
                    () => ScreenEditProfile(
                        profile: controller.userProfile['user']),
                  ),
                  setState(() {
                    isPressedProfileEdit = false;
                  })
                },
                child: Container(
                  color: isPressedProfileEdit
                      ? Colors.transparent.withOpacity(0.1)
                      : Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Icon(Icons.manage_accounts),
                          Text(
                            "Profil bearbeiten",
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
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Divider(
                height: 0,
                thickness: 0.7,
              ),
              GestureDetector(
                onTapDown: (details) {
                  setState(() {
                    isPressedAbo = true;
                  });
                },
                onTapCancel: () {
                  setState(() {
                    isPressedAbo = false;
                  });
                },
                onTap: () => {
                  print("Money"),
                  setState(() {
                    isPressedAbo = false;
                  })
                },
                child: Container(
                  color: isPressedAbo
                      ? Colors.transparent.withOpacity(0.1)
                      : Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Icon(Icons.monetization_on),
                          Text(
                            "Abonnement abschließen",
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
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Divider(
                height: 0,
                thickness: 0.7,
              ),
              GestureDetector(
                onTapDown: (details) {
                  setState(() {
                    isPressedLogOff = true;
                  });
                },
                onTapCancel: () {
                  setState(() {
                    isPressedLogOff = false;
                  });
                },
                onTap: () => {
                  authController.signOut(),
                  Get.offAll(() => ScreenLogin()),
                  setState(() {
                    isPressedLogOff = false;
                  })
                },
                child: Container(
                  color: isPressedLogOff
                      ? Colors.transparent.withOpacity(0.1)
                      : Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Icon(Icons.logout),
                            Text(
                              "Abmelden",
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
                          ],
                        )),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  bool isPressedLogIn = false;
  bool isPressedSignIn = false;
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
        child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Column(children: [
                GestureDetector(
                  onTapDown: (details) {
                    setState(() {
                      isPressedLogIn = true;
                    });
                  },
                  onTapCancel: () {
                    setState(() {
                      isPressedLogIn = false;
                    });
                  },
                  onTap: () => {
                    setState(() {
                      isPressedLogIn = false;
                    }),
                    authController
                        .signOut()
                        .then((value) => Get.offAll(() => ScreenLogin()))
                  },
                  child: Container(
                    color: isPressedLogIn
                        ? Colors.transparent.withOpacity(0.1)
                        : Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Icon(Icons.login),
                            Text(
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
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTapDown: (details) {
                    setState(() {
                      isPressedSignIn = true;
                    });
                  },
                  onTapCancel: () {
                    setState(() {
                      isPressedSignIn = false;
                    });
                  },
                  onTap: () => {
                    authController
                        .signOut()
                        .then((value) => Get.offAll(() => ScreenSignUp()))
                  },
                  child: Container(
                    color: isPressedSignIn
                        ? Colors.transparent.withOpacity(0.1)
                        : Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Icon(Icons.account_box),
                            Text(
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
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ])
            ]));
  }
}
